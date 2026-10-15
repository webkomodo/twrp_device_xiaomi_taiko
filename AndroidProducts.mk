PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_taiko.mk \
    $(LOCAL_DIR)/omni_taiko.mk

# A14+ build system wajib format 3 bagian: product-release-variant.
# trunk_staging adalah release default AOSP (dipakai tapas/banchan juga).
# Entri 2 bagian disertakan buat manifest twrp-12.1 (lunch klasik).
COMMON_LUNCH_CHOICES := \
    twrp_taiko-eng \
    omni_taiko-eng \
    twrp_taiko-trunk_staging-eng \
    omni_taiko-trunk_staging-eng
