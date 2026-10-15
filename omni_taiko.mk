#
# omni_taiko.mk - shim buat builder lama yang expect omni_ prefix
# Isinya cuma forward ke twrp_taiko.mk
#
$(call inherit-product, device/xiaomi/taiko/twrp_taiko.mk)

PRODUCT_NAME := omni_taiko
