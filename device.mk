# Minimal device.mk for taiko recovery. Deliberately not Lineage's device.mk:
# audio/camera/sensor are useless here and only slow the build down.
DEVICE_PATH := device/xiaomi/taiko

# A/B virtual + dynamic partitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    checkpoint_gc \
    otapreopt_script

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# recovery/root/etc/init.recovery.mt6789.rc is copied into the recovery ramdisk
# by the build system (recovery/root mechanism) and imported by TWRP via
# "import /init.recovery.${ro.hardware}.rc", so no PRODUCT_COPY_FILES needed.

# Fastbootd (required for A/B devices without a recovery partition)
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health, so the battery percentage reads correctly in recovery
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

# Boot control untuk A/B
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-service

# libtar (bootable/recovery, TW_INCLUDE_CRYPTO_FBE) links these AIDL NDK stubs.
# They are reachable only from a Make module, so Soong never builds them unless
# the product names them -- leaving a dangling <lib>.so.toc link prerequisite.
PRODUCT_PACKAGES += \
    android.security.apc-ndk_platform \
    android.system.keystore2-V1-ndk_platform \
    android.security.authorization-ndk_platform \
    android.security.maintenance-ndk_platform

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
