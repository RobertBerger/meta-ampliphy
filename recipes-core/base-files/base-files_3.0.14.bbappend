FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://fstab \
                  file://print_issue.sh \
                  file://base-files.conf \
                  file://20-bootpart.rules \
                  file://isbootpart \
                  file://u-boot-dynamic-link.sh \
                  file://custom-dev-boot.service \
                  file://nfs-boot-mask \
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
    install -m 0755 ${UNPACKDIR}/u-boot-dynamic-link.sh ${D}${sbindir}/u-boot-dynamic-link.sh

    # 4. Install your custom service manager unit file
    install -d ${D}${systemd_system_unitdir}
    # Process the template directly out to the destination directory
    sed 's#@SBINDIR@#${sbindir}#g' ${UNPACKDIR}/custom-dev-boot.service > ${D}${systemd_system_unitdir}/custom-dev-boot.service
    # Secure the file permissions on the newly generated output file
    chmod 0644 ${D}${systemd_system_unitdir}/custom-dev-boot.service

    # 5. Create the enabling symlink target for startup automation
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -sf ${systemd_system_unitdir}/custom-dev-boot.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/custom-dev-boot.service

    # 6. Instead of forcing udev to fake a device node,
    #    we can instruct the system to dynamically mask the /boot mount if it detects a network filesystem root.
    #    Systemd checks its generator paths before evaluating fstab, so this completely removes the roadblock before the timeout loop can even start.
    #    We create a small systemd generator script inside your rootfs at /lib/systemd/system-generators/nfs-boot-mask
    install -d ${D}${systemd_unitdir}/system-generators
    install -m 0755 ${UNPACKDIR}/nfs-boot-mask ${D}${systemd_unitdir}/system-generators/nfs-boot-mask
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

