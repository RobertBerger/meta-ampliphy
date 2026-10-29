# Copyright (C) 2026 Robert Berger <robert.berger@ReliableEmbeddedSystems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

FILESEXTRAPATHS:prepend := "${CERT_PATH}/rauc:"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS += "phytec-dev-ca-native config-partition"
do_fetch[depends] += "phytec-dev-ca-native:do_install"

# Set path to the rauc keyring, which is installed in the image
RAUC_KEYRING_FILE ?= "mainca-rsa.crt.pem"
RAUC_KEYRING_FILE_DEVICE_PATH ?= "${@os.path.basename(d.getVar("RAUC_KEYRING_FILE"))}"

# Fetch reference configs dynamically based on both emmc and sd machine features
SRC_URI += " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'emmc', 'file://system_emmc.conf', 'file://system_nand.conf', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'sd', 'file://system_sd.conf', '', d)} \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Baseline machine configuration variables (Internal eMMC Storage)
EMMC_DEV ??= "0"
NAND_DEV ??= "0"

ROOTFS_0_DEV ??= "/dev/mmcblk${EMMC_DEV}p5"
ROOTFS_1_DEV ??= "/dev/mmcblk${EMMC_DEV}p6"
ROOTFS_0_DEV:securestorage ?= "/dev/mapper/mmcblk${EMMC_DEV}p5"
ROOTFS_1_DEV:securestorage ?= "/dev/mapper/mmcblk${EMMC_DEV}p6"

# Custom SD Card interface parameters (External SD Storage)
SD_DEV ??= "0"
SD_ROOTFS_0_DEV ??= "/dev/mmcblk${SD_DEV}p5"
SD_ROOTFS_1_DEV ??= "/dev/mmcblk${SD_DEV}p6"

# Define new template defaults specific to the i.MX8M Plus geometry constraints
SD_BOOT_REG_START ??= "32K"
SD_BOOT_REG_SIZE ??= "4M"

USE_BOOTLOADER_SLOT ?= "${USE_BOOTLOADER_SLOT_WEAK_DEFAULT}"
USE_BOOTLOADER_SLOT_WEAK_DEFAULT = "true"
USE_BOOTLOADER_SLOT_WEAK_DEFAULT:ti33x = "false"

# Maintain caching dependencies for your extra variables
do_fetch[vardeps] += " \
    PREFERRED_PROVIDER_virtual/bootloader \
    EMMC_DEV \
    NAND_DEV \
    ROOTFS_0_DEV \
    ROOTFS_1_DEV \
    SD_DEV \
    SD_ROOTFS_0_DEV \
    SD_ROOTFS_1_DEV \
    SD_BOOT_REG_START \
    SD_BOOT_REG_SIZE \
    RAUC_KEYRING_FILE \
    USE_BOOTLOADER_SLOT \
"

def map_system_conf_bootloader(d):
    bootloader_map = {
        "barebox": "barebox",
        "u-boot": "uboot",
        "u-boot-master": "uboot",
        "u-boot-phytec": "uboot",
        "u-boot-phytec-imx": "uboot",
        "u-boot-phytec-ti": "uboot"
    }
    bootloader = d.getVar("PREFERRED_PROVIDER_virtual/bootloader")
    if bootloader not in bootloader_map:
        bb.warn("Unsupported or no PREFERRED_PROVIDER selected for virtual/bootloader, rauc will not work correctly.")
        return "noop"
    else:
        return bootloader_map[bootloader]

do_install:prepend() {
    # 1. Process eMMC template (Unchanged)
    if ${@bb.utils.contains('MACHINE_FEATURES', 'emmc', 'true', 'false', d)}; then
        cp ${UNPACKDIR}/system_emmc.conf ${UNPACKDIR}/system_emmc_final.conf
        sed -i \
            -e 's/@MACHINE@/${MACHINE}/g' \
            -e 's/@BOOTLOADER@/${@map_system_conf_bootloader(d)}/g' \
            -e 's/@EMMC_DEV@/${EMMC_DEV}/g' \
            -e 's/@NAND_DEV@/${NAND_DEV}/g' \
            -e 's!@ROOTFS_0_DEV@!${ROOTFS_0_DEV}!g' \
            -e 's!@ROOTFS_1_DEV@!${ROOTFS_1_DEV}!g' \
            -e 's!@RAUC_KEYRING_FILE@!/usr/lib/rauc/${RAUC_KEYRING_FILE_DEVICE_PATH}!g' \
            ${@bb.utils.contains("USE_BOOTLOADER_SLOT", "true", "", "-e '/@IF_BOOTLOADER_SLOT@/,/@ENDIF_BOOTLOADER_SLOT@/d'", d)} \
            -e '/@\(IF\|ENDIF\)[A-Z_]\+@/d' \
            ${UNPACKDIR}/system_emmc_final.conf
    fi

    # 2. Process SD card template with your new dynamic region variables
    if ${@bb.utils.contains('MACHINE_FEATURES', 'sd', 'true', 'false', d)}; then
        cp ${UNPACKDIR}/system_sd.conf ${UNPACKDIR}/system_sd_final.conf
        sed -i \
            -e 's/@MACHINE@/${MACHINE}/g' \
            -e 's/@BOOTLOADER@/${@map_system_conf_bootloader(d)}/g' \
            -e 's/@SD_DEV@/${SD_DEV}/g' \
            -e 's!@SD_ROOTFS_0_DEV@!${SD_ROOTFS_0_DEV}!g' \
            -e 's!@SD_ROOTFS_1_DEV@!${SD_ROOTFS_1_DEV}!g' \
            -e 's/@SD_BOOT_REG_START@/${SD_BOOT_REG_START}/g' \
            -e 's/@SD_BOOT_REG_SIZE@/${SD_BOOT_REG_SIZE}/g' \
            -e 's!@RAUC_KEYRING_FILE@!/usr/lib/rauc/${RAUC_KEYRING_FILE_DEVICE_PATH}!g' \
            ${@bb.utils.contains("USE_BOOTLOADER_SLOT", "true", "", "-e '/@IF_BOOTLOADER_SLOT@/,/@ENDIF_BOOTLOADER_SLOT@/d'", d)} \
            -e '/@\(IF\|ENDIF\)[A-Z_]\+@/d' \
            ${UNPACKDIR}/system_sd_final.conf
    fi

    # 3. Satisfy core recipes requirements (Unchanged)
    if [ -f ${UNPACKDIR}/system_emmc_final.conf ]; then
        cp ${UNPACKDIR}/system_emmc_final.conf ${UNPACKDIR}/system.conf
    else
        cp ${UNPACKDIR}/system_sd_final.conf ${UNPACKDIR}/system.conf
    fi
}

do_install:append() {
    # FIX: Create target config directories before executing copies to prevent shell execution failure flags
    install -d ${D}${sysconfdir}/rauc

    # 1. Force copy the certificate out of CERT_PATH into UNPACKDIR so the validation loops pass safely
    if [ -f "${CERT_PATH}/rauc/${RAUC_KEYRING_FILE}" ]; then
        cp "${CERT_PATH}/rauc/${RAUC_KEYRING_FILE}" "${UNPACKDIR}/${RAUC_KEYRING_FILE}"
    fi

    # Install files depending strictly on what is enabled
    if ${@bb.utils.contains('MACHINE_FEATURES', 'emmc', 'true', 'false', d)}; then
        install -m 0644 ${UNPACKDIR}/system_emmc_final.conf ${D}${sysconfdir}/rauc/system_emmc.conf
    fi

    if ${@bb.utils.contains('MACHINE_FEATURES', 'sd', 'true', 'false', d)}; then
        install -m 0644 ${UNPACKDIR}/system_sd_final.conf ${D}${sysconfdir}/rauc/system_sd.conf
    fi

    # Smart compilation baseline linking selection
    if ${@bb.utils.contains('MACHINE_FEATURES', 'emmc', 'true', 'false', d)}; then
        ln -sf system_emmc.conf ${D}${sysconfdir}/rauc/system.conf
    elif ${@bb.utils.contains('MACHINE_FEATURES', 'sd', 'true', 'false', d)}; then
        ln -sf system_sd.conf ${D}${sysconfdir}/rauc/system.conf
    fi

    # Universal target boot-time Systemd manager hook
    install -d ${D}${sysconfdir}/systemd/system/rauc.service.d
    cat <<EOF > ${D}${sysconfdir}/systemd/system/rauc.service.d/override.conf
[Service]
ExecStartPre=/bin/sh -c " \
if [ -f /etc/rauc/system_sd.conf ] && [ -f /etc/rauc/system_emmc.conf ]; then \
    if grep -q 'root=/dev/mmcblk1' /proc/cmdline || grep -q 'root=/dev/mapper/mmcblk1' /proc/cmdline; then \
        ln -sf system_sd.conf /etc/rauc/system.conf; \
    else \
        ln -sf system_emmc.conf /etc/rauc/system.conf; \
    fi \
elif [ -f /etc/rauc/system_sd.conf ]; then \
    ln -sf system_sd.conf /etc/rauc/system.conf; \
elif [ -f /etc/rauc/system_emmc.conf ]; then \
    ln -sf system_emmc.conf /etc/rauc/system.conf; \
fi"
EOF

    # 2. Validate signature keys checking wrapper (Now safe because the file exists in UNPACKDIR)
    if [ -f "${UNPACKDIR}/${RAUC_KEYRING_FILE}" ]; then
        shasum=$(sha256sum "${UNPACKDIR}/${RAUC_KEYRING_FILE}" | cut -d' ' -f1)
        if [ "$shasum" = "91efd86dfbffa360c909b06b54902348075c5ba7902ad1ec30d25527a1f8ca09" ]; then
            bbwarn "You're including Phytec's Development Keyring in the rauc bundle. Please create your own!"
        fi
    fi
}

FILES:${PN} += " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'emmc', '${sysconfdir}/rauc/system_emmc.conf', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'sd', '${sysconfdir}/rauc/system_sd.conf', '', d)} \
    ${sysconfdir}/systemd/system/rauc.service.d/override.conf \
"

