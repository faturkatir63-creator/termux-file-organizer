#!/data/data/com.termux/files/usr/bin/bash

set -u

DOWNLOAD="$HOME/storage/downloads"

if [ ! -d "$DOWNLOAD" ]; then
  echo "Folder Download belum dapat diakses."
  echo "Jalankan dulu: termux-setup-storage"
  exit 1
fi

mkdir -p \
  "$DOWNLOAD/Gambar" \
  "$DOWNLOAD/Video" \
  "$DOWNLOAD/Dokumen" \
  "$DOWNLOAD/APK" \
  "$DOWNLOAD/Arsip" \
  "$DOWNLOAD/Lainnya"

move_files() {
  local destination="$1"
  shift

  for pattern in "$@"; do
    find "$DOWNLOAD" -maxdepth 1 -type f -iname "$pattern" -exec mv -n {} "$destination/" \;
  done
}

move_files "$DOWNLOAD/Gambar" "*.jpg" "*.jpeg" "*.png" "*.gif" "*.webp"
move_files "$DOWNLOAD/Video" "*.mp4" "*.mkv" "*.avi" "*.webm"
move_files "$DOWNLOAD/Dokumen" "*.pdf" "*.doc" "*.docx" "*.xls" "*.xlsx" "*.ppt" "*.pptx" "*.txt"
move_files "$DOWNLOAD/APK" "*.apk"
move_files "$DOWNLOAD/Arsip" "*.zip" "*.rar" "*.7z" "*.tar" "*.gz"

echo "Selesai. File Download sudah dirapikan."
