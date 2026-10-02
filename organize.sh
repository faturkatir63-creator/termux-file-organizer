#!/data/data/com.termux/files/usr/bin/bash

set -u

DOWNLOAD="$HOME/storage/downloads"
DRY_RUN=false

if [ ! -d "$DOWNLOAD" ]; then
  echo "Folder Download belum dapat diakses."
  echo "Jalankan dulu: termux-setup-storage"
  exit 1
fi

if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=true
fi

mkdir -p \
  "$DOWNLOAD/Gambar" \
  "$DOWNLOAD/Video" \
  "$DOWNLOAD/Dokumen" \
  "$DOWNLOAD/APK" \
  "$DOWNLOAD/Arsip"

organize_files() {
  local destination="$1"
  shift

  for pattern in "$@"; do
    while IFS= read -r -d '' file; do
      if [ "$DRY_RUN" = true ]; then
        echo "[PREVIEW] $(basename "$file") -> $(basename "$destination")/"
      else
        mv -n "$file" "$destination/"
        echo "[PINDAH] $(basename "$file") -> $(basename "$destination")/"
      fi
    done < <(find "$DOWNLOAD" -maxdepth 1 -type f -iname "$pattern" -print0)
  done
}

organize_files "$DOWNLOAD/Gambar" "*.jpg" "*.jpeg" "*.png" "*.gif" "*.webp"
organize_files "$DOWNLOAD/Video" "*.mp4" "*.mkv" "*.avi" "*.webm"
organize_files "$DOWNLOAD/Dokumen" "*.pdf" "*.doc" "*.docx" "*.xls" "*.xlsx" "*.ppt" "*.pptx" "*.txt"
organize_files "$DOWNLOAD/APK" "*.apk"
organize_files "$DOWNLOAD/Arsip" "*.zip" "*.rar" "*.7z" "*.tar" "*.gz"

if [ "$DRY_RUN" = true ]; then
  echo "Preview selesai. Tidak ada file yang dipindahkan."
else
  echo "Selesai. File Download sudah dirapikan."
fi
