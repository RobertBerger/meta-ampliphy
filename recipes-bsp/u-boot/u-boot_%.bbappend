FILESEXTRAPATHS:prepend := "${THISDIR}/features:"

# Inherit PHYTEC's environment class helper tool
inherit uboot-extra-env

# Inject the RAUC config fragment ONLY if 'rauc' is in DISTRO_FEATURES
SRC_URI:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'rauc', 'file://rauc.cfg', '', d)}"

# Inject secure boot configurations if enabled
SRC_URI:append:secureboot = " \
    file://disable-insecure-bootmeths.cfg \
"

# Python execution block to append variables directly into U-Boot's built-in environment
python do_env:append:phyboard-pollux-imx8mp-3() {
    # Only execute RAUC environment overrides if 'rauc' feature is enabled
    if bb.utils.contains('DISTRO_FEATURES', 'rauc', True, False, d):
        # Force U-Boot to look for RAUC bootmeths natively at startup
        env_add(d, "doraucboot", "1")
        env_add(d, "bootmeths", "rauc script efi extlinux pxe")
    
    # You can also use this block to inject custom network boot fallback logic:
    env_add(d, "boot_script_dhcp", "net_boot_fit.scr.uimg")
}

# Conditionally include secure configurations based on your active global project features
require ${@bb.utils.contains('DISTRO_FEATURES', 'secureboot', 'recipes-bsp/u-boot/secureboot.inc', '', d)}
require ${@bb.utils.contains('DISTRO_FEATURES', 'hardening', 'recipes-bsp/u-boot/hardening.inc', '', d)}
