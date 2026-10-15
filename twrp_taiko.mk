#
# twrp_taiko.mk - primary product buat minimal-manifest-twrp (twrp-14)
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit dari device recovery minimal
$(call inherit-product, device/xiaomi/taiko/device.mk)

# Inherit common TWRP (modern: vendor/twrp/config/common.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := taiko
PRODUCT_NAME := twrp_taiko
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi Pad 2
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Samakan fingerprint stock biar AVB/OTA check konsisten
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="taiko-user 16 BP2A.250605.031.A3 OS3.0.2.0.WOVMIXM release-keys" \
    BuildFingerprint=Redmi/taiko_global/taiko:16/BP2A.250605.031.A3/OS3.0.2.0.WOVMIXM:user/release-keys \
    SystemName=taiko_global \
    SystemDevice=taiko
