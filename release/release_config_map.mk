# device/xiaomi/taiko/release/release_config_map.mk
#
# Minimal TWRP manifest (TeamWin android-14.1 build) tidak membawa release
# config sama sekali, padahal lunch A14+ wajib <product>-<release>-<variant>.
# File ini mendeklarasikan release "trunk_staging" (nama release default AOSP)
# supaya lunch berikut valid:
#   lunch twrp_taiko-trunk_staging-eng
#
# Path ini otomatis ditemukan build system via wildcard
# device/*/*/release/release_config_map.mk di core/release_config.mk.
$(call declare-release-config, trunk_staging, device/xiaomi/taiko/release/trunk_staging.scl)
