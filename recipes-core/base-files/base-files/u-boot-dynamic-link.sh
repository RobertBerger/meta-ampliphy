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

if [ -n "$BOOT_DISK" ] && [ -b "/dev/${BOOT_DISK}" ]; then
    echo "Custom dynamic mount manager executing onto block layer: /dev/${BOOT_DISK}"

    # Use auto filesystem type mapping and let errors output natively
    mount -t auto -o defaults "/dev/${BOOT_DISK}p3" /mnt/config
    mount -t auto -o defaults "/dev/${BOOT_DISK}p7" /mnt/artifacts
fi
