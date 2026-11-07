#!/bin/sh

# Fast path: Exit immediately if RAUC is not installed/configured on this rootfs
if [ ! -f /etc/rauc/system.conf ]; then
    echo "RAUC configuration not found. Skipping dynamic partition mounts."
    exit 0
fi

# Discover active root storage base drive path dynamically at late boot stage
ROOT_DEV_RAW=$(tr ' ' '\n' < /proc/cmdline | grep '^root=' | cut -d= -f2)
if [ "$ROOT_DEV_RAW" = "/dev/root" ] || [ -z "$ROOT_DEV_RAW" ]; then
    ROOT_DEV_RAW=$(awk '$2 == "/" {print $1}' /proc/mounts)
fi

ROOT_DEV=$(readlink -f "$ROOT_DEV_RAW")
BOOT_DISK=$(basename "$ROOT_DEV" | sed -E 's/p[0-9]+$//')

ERR_STATUS=0

if [ -n "$BOOT_DISK" ] && [ -b "/dev/${BOOT_DISK}" ]; then
    echo "Custom dynamic mount manager executing onto block layer: /dev/${BOOT_DISK}"

    # 1. Mount standard legacy config partition (p3)
    if ! mount -t auto -o defaults "/dev/${BOOT_DISK}p3" /mnt/config; then
        echo "ERROR: Failed to mount config partition (/dev/${BOOT_DISK}p3)"
        ERR_STATUS=1
    fi

    # 2. Check layout configuration and mount via explicit local disk paths
    # Old layout target: artifacts sits on p7
    # New layout target: artifacts shifts to p10, overlays sit on p8 and p9

    if [ -b "/dev/${BOOT_DISK}p10" ]; then
        # NEW ADVANCED DATA LAYOUT DETECTED
        if [ -d /mnt/etc-overlay ] && ! mount "/dev/${BOOT_DISK}p7" /mnt/etc-overlay; then ERR_STATUS=1; fi
        if [ -d /mnt/genericoverlay ] && ! mount "/dev/${BOOT_DISK}p8" /mnt/genericoverlay; then ERR_STATUS=1; fi
        if [ -d /mnt/persistent-data ] && ! mount "/dev/${BOOT_DISK}p9" /mnt/persistent-data; then ERR_STATUS=1; fi
        if [ -d /mnt/artifacts ] && ! mount "/dev/${BOOT_DISK}p10" /mnt/artifacts; then ERR_STATUS=1; fi
    elif [ -b "/dev/${BOOT_DISK}p9" ]; then
        # THREE-PARTITION INTERMEDIATE LAYOUT DETECTED
        if [ -d /mnt/etc-overlay ] && ! mount "/dev/${BOOT_DISK}p7" /mnt/etc-overlay; then ERR_STATUS=1; fi
        if [ -d /mnt/genericoverlay ] && ! mount "/dev/${BOOT_DISK}p8" /mnt/genericoverlay; then ERR_STATUS=1; fi
        if [ -d /mnt/artifacts ] && ! mount "/dev/${BOOT_DISK}p9" /mnt/artifacts; then ERR_STATUS=1; fi
    elif [ -b "/dev/${BOOT_DISK}p7" ]; then
        # LEGACY BASELINE LAYOUT DETECTED
        if [ -d /mnt/artifacts ]; then mount "/dev/${BOOT_DISK}p7" /mnt/artifacts || ERR_STATUS=$?; fi
    else
        echo "ERROR: Unable to locate a valid artifacts partition structure."
        ERR_STATUS=1
    fi
fi

exit $ERR_STATUS
