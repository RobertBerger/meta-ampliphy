FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = "file://fstab \
                  file://print_issue.sh \
                  file://base-files.conf \
                  file://20-bootpart.rules \
                  file://isbootpart \
"

dirs755:append = " ${sysconfdir}/profile.d"

python do_patch:append() {
    if "am57xx" in d.getVar("OVERRIDES").split(":"):
        bb.process.run("sed -i -e '\\|/boot|d' %s/fstab" % d.getVar("UNPACKDIR"))
}

do_install:append() {
    install -d ${D}/mnt/artifacts
    install -d ${D}/mnt/config
    install -m 0755 ${UNPACKDIR}/print_issue.sh ${D}${sysconfdir}/profile.d/print_issue.sh
    install -m 0644 ${UNPACKDIR}/share/dot.profile ${D}${ROOT_HOME}/.profile
    install -m 0644 ${UNPACKDIR}/share/dot.bashrc ${D}${ROOT_HOME}/.bashrc
    install -Dm 0644 ${UNPACKDIR}/base-files.conf ${D}${sysconfdir}/tmpfiles.d/base-files.conf

    # 1. Install the native Phytec udev rule template
    install -d ${D}${sysconfdir}/udev/rules.d
    sed 's#@BINDIR@#${bindir}#g' ${UNPACKDIR}/20-bootpart.rules > ${D}${sysconfdir}/udev/rules.d/20-bootpart.rules
    chmod 0644 ${D}${sysconfdir}/udev/rules.d/20-bootpart.rules

    # 2. Install the native Phytec isbootpart helper script
    install -d ${D}${bindir}
    install -m 0755 ${UNPACKDIR}/isbootpart ${D}${bindir}

    # 3. Install your reliable runtime mount manager script into sbindir
    install -d ${D}${sbindir}
    cat << 'EOF' > ${D}${sbindir}/u-boot-dynamic-link.sh
#!/bin/sh

# Discover active root storage base drive path dynamically at late boot stage
ROOT_DEV_RAW=$(tr ' ' '\n' < /proc/cmdline | grep '^root=' | cut -d= -f2)
if [ "$ROOT_DEV_RAW" = "/dev/root" ] || [ -z "$ROOT_DEV_RAW" ]; then
    ROOT_DEV_RAW=$(awk '$2 == "/" {print $1}' /proc/mounts)
fi

ROOT_DEV=$(readlink -f "$ROOT_DEV_RAW")
BOOT_DISK=$(basename "$ROOT_DEV" | sed -E 's/p[0-9]+$//')

if [ -n "$BOOT_DISK" ] && [ -b "/dev/${BOOT_DISK}" ]; then
    echo "Custom dynamic mount manager executing onto block layer: /dev/${BOOT_DISK}"
    mkdir -p /mnt/config /mnt/artifacts

    # Secure late runtime partition execution
    mount -t ext4 -o defaults "/dev/${BOOT_DISK}p3" /mnt/config 2>/dev/null
    mount -t ext4 -o defaults "/dev/${BOOT_DISK}p7" /mnt/artifacts 2>/dev/null
fi
EOF
    chmod 0755 ${D}${sbindir}/u-boot-dynamic-link.sh

    # 4. Install your custom service manager unit file
    install -d ${D}${systemd_system_unitdir}
    cat << 'EOF' > ${D}${systemd_system_unitdir}/custom-dev-boot.service
[Unit]
Description=Dynamic Partition Mounting Hook for RAUC Slots
DefaultDependencies=no
Conflicts=umount.target
After=systemd-udevd.service udevadm-trigger.service
Before=multi-user.target rauc.service

[Service]
Type=oneshot
ExecStart=${sbindir}/u-boot-dynamic-link.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

    # 5. Create the enabling symlink target for startup automation
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -sf ${systemd_system_unitdir}/custom-dev-boot.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/custom-dev-boot.service
}

do_install_basefilesissue:append() {
    if [ -n "${DISTRO_NAME}" ]; then
        sed -i 's/%h//g' ${D}${sysconfdir}/issue.net
    fi
}

FILES:${PN} += " \
    /mnt/artifacts \
    /mnt/config \
    ${bindir} \
    ${sysconfdir}/udev/rules.d \
    ${sbindir}/u-boot-dynamic-link.sh \
    ${systemd_system_unitdir}/custom-dev-boot.service \
    ${sysconfdir}/systemd/system/multi-user.target.wants/custom-dev-boot.service \
"

