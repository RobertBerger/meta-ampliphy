#!/bin/sh
set -eu

RAUC_DIR="/etc/rauc"
SD_DEV="@SD_DEV@"

if [ -f "${RAUC_DIR}/system_sd.conf" ] && [ -f "${RAUC_DIR}/system_emmc.conf" ]; then
    ROOT_SRC=$(findmnt -n -o SOURCE / 2>/dev/null || true)
    ROOT_BASE=$(basename "${ROOT_SRC}")

    case "${ROOT_BASE}" in
        mmcblk${SD_DEV}p*|mmcblk${SD_DEV})
            ln -sf system_sd.conf "${RAUC_DIR}/system.conf"
            ;;
        *)
            ln -sf system_emmc.conf "${RAUC_DIR}/system.conf"
            ;;
    esac
elif [ -f "${RAUC_DIR}/system_sd.conf" ]; then
    ln -sf system_sd.conf "${RAUC_DIR}/system.conf"
elif [ -f "${RAUC_DIR}/system_emmc.conf" ]; then
    ln -sf system_emmc.conf "${RAUC_DIR}/system.conf"
fi
