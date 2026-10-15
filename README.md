# TWRP device tree — Redmi Pad 2 (taiko)

Status: **WIP bringup, belum tested boot.** Base dari
`ItzJustNett/android_device_xiaomi_taiko` (lineage-23.0) + kernel prebuilt
`ItzJustNett/android_device_xiaomi_taiko-kernel`.

Fakta device yang dipakai di tree ini (sudah diverifikasi dari dump):
- Kernel `6.12.30-android16-5` GKI 4k, boot header v4, A/B virtual_ab
- Offsets/pagesize + `dtbo.img` + `dtb/taiko.dtb` + `modules.load` diambil apa adanya dari repo kernel
- Partisi super 7.5GB, `vendor_boot` 64MB, AVB testkey (khusus bringup)
- Stock fingerprint `OS3.0.2.0.WOVMIXM` (Android 16)

## Isi repo

| File | Fungsi |
|---|---|
| `BoardConfig.mk` | Arch arm64, kernel prebuilt, partisi, AVB, flag TWRP tablet |
| `device.mk` | Product minimal recovery (fastbootd, health, update_engine). Bukan device.mk Lineage |
| `recovery.fstab` | Fstab format TWRP (slotselect, FBE, OTG/microSD) |
| `twrp_taiko.mk` | Product utama (`lunch twrp_taiko-eng`) |
| `omni_taiko.mk` | Shim buat builder lama (`lunch omni_taiko-eng`) |
| `manifests/taiko.xml` | Contoh local_manifest |
| `.github/workflows/build.yml` | Buildbot GitHub Actions |

## Cara pakai (buildbot, disarankan)

1. Bikin repo baru di GitHub, misal `twrp_device_xiaomi_taiko`, push isi folder ini ke branch `twrp-14`.
2. Buka tab Actions → Run workflow. Manifest yang dipakai `twrp-14`, kernel diambil otomatis dari repo ItzJustNett.
3. Ambil `recovery.img` + `vendor_boot.img` dari Artifacts.

Runner GitHub (~70GB free) cukup karena sync shallow minimal, tanpa ccache besar.

## Build lokal (HDD eksternal 200GB)

200GB **cukup buat TWRP saja** (~80-100GB total), tidak cukup buat Lineage full.
Syarat disk: **ext4** (bukan NTFS/exFAT), USB3, matikan auto-sleep.

```bash
# 1. repo minimal TWRP
mkdir ~/twrp && cd ~/twrp
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-14
mkdir -p .repo/local_manifests
cp /path/to/manifests/taiko.xml .repo/local_manifests/
# edit taiko.xml: ganti YOUR_GITHUB_USER
repo sync -c --force-sync --no-tags -j$(nproc)

# 2. build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch twrp_taiko-eng
mka -j$(nproc) recoveryimage vendorbootimage
# hasil: out/target/product/taiko/recovery.img + vendor_boot.img
```

## Test aman (jangan langsung flash)

```bash
fastboot getvar current-slot
fastboot boot out/target/product/taiko/vendor_boot.img
# kalau blank / bootloop, tahan power 10 detik, balik ke stock otomatis
adb pull /tmp/recovery.log
```

Baru flash permanen kalau `fastboot boot` sudah masuk menu + touchscreen jalan:
```bash
fastboot flash vendor_boot vendor_boot.img
```

## TODO sebelum klaim stable

1. `getprop ro.board.platform` — pastikan `mt6789`, kalau beda ganti `TARGET_BOARD_PLATFORM`.
2. Brightness path — cek `adb shell ls /sys/class/leds/` dan `max_brightness`. Update `TW_BRIGHTNESS_PATH` / `TW_MAX_BRIGHTNESS` kalau bukan `lcd-backlight` / 2047.
3. Touchscreen — kernel modules recovery sudah di-include dari `modules.load.recovery`, tapi kalau sentuh mati kirim `dmesg` + `/tmp/recovery.log`.
4. Decrypt /data (FBE A16) kemungkinan belum jalan di build pertama. Fallback: backup via OTG/microSD.
5. Density/tema — `landscape_hdpi` asumsi tablet. Kalau UI kepotong, coba `portrait_hdpi`.
6. `README.md` + density 540 di repo Lineage masih sisa emerald — jangan copy mentah ke sini.

## Kredit

Tree Lineage, kernel prebuilt, dan vendor blobs: `ItzJustNett`. Tree recovery ini cuma adaptasi minimal agar bisa `lunch + mka` tanpa narik seluruh blob Lineage.
