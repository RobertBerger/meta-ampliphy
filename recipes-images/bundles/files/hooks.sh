#!/bin/sh
set -e # Exit immediately if a command fails

set -x

# Intercept RAUC right when it is preparing to flash the boot slot class
if [ "$1" = "slot-install" ] && [ "$RAUC_SLOT_CLASS" = "boot" ]; then
    echo "Hook Intercept: Safely formatting ${RAUC_SLOT_DEVICE} as FAT32..."
    
    # 1. Clear active partition holders
    umount -f "${RAUC_SLOT_DEVICE}" 2>/dev/null || true
    
    # 2. MATCHED GEOMETRY: Let mkfs calculate the perfect, clean cluster bounds for 128MiB
    mkfs.vfat -F 32 "${RAUC_SLOT_DEVICE}"
    
    # 3. Create a reliable, temporary runtime mount directory
    MY_MOUNTPOINT="/tmp/rauc_hook_boot_mount"
    mkdir -p "${MY_MOUNTPOINT}"
    
    # 4. Mount using standard production translation parameters
    mount -t vfat -o rw,fmask=0022,dmask=0022,shortname=mixed "${RAUC_SLOT_DEVICE}" "${MY_MOUNTPOINT}"
    
    # 5. DYNAMIC PATH FALLBACK: Safely locate the bundle source archive directory path
    BUNDLE_ROOT="${RAUC_BUNDLE_MOUNTPOINT:-/run/rauc/mnt/bundle}"
    PAYLOAD_ARCHIVE="${BUNDLE_ROOT}/boot.tar.gz"
    
    if [ ! -f "${PAYLOAD_ARCHIVE}" ] && [ -f "./boot.tar.gz" ]; then
        PAYLOAD_ARCHIVE="./boot.tar.gz"
    fi
    
    echo "Extracting payload from ${PAYLOAD_ARCHIVE} into ${MY_MOUNTPOINT}..."
    tar -xzf "${PAYLOAD_ARCHIVE}" -C "${MY_MOUNTPOINT}"
    
    # 6. Flush structural data blocks and clean up mount paths cleanly
    sync
    umount "${MY_MOUNTPOINT}"
    rmdir "${MY_MOUNTPOINT}"

set +x
    
    echo "Hook Intercept: Boot slot setup completed successfully!"
    exit 0
fi

exit 0


