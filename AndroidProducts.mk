PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_taiko.mk \
    $(LOCAL_DIR)/omni_taiko.mk

# Hanya format 2 bagian di sini: build 12.1 memvalidasi tiap entri sebagai
# product-variant saat parse dan menolak entri 3 bagian (error Invalid variant).
# Buat manifest A14, lunch 3 bagian tetap bisa dipanggil eksplisit
# (lunch twrp_taiko-trunk_staging-eng) tanpa butuh entri di daftar ini.
COMMON_LUNCH_CHOICES := \
    twrp_taiko-eng \
    omni_taiko-eng
