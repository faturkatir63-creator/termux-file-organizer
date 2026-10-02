#!/data/data/com.termux/files/usr/bin/bash

set -u

SOURCE_DIR="$HOME/storage/downloads"
DRY_RUN=false
AUTO_CONFIRM=false

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Folder Download belum dapat diakses."
  echo "Jalankan dulu: termux-setup-storage"
  exit 1
fi

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      ;;
    --yes)
      AUTO_CONFIRM=true
      ;;
    --source)
      shift
      if [ -z "${1:-}" ]; then
        echo "Error: --source membutuhkan lokasi folder."
        exit 1
      fi
      SOURCE_DIR="$1"
      ;;
    --help|-h)
      echo "Termux File Organizer v1.2.0"
      echo
      echo "Cara pakai:"
      echo "  ./organize.sh"
      echo "  ./organize.sh --dry-run"
      echo "  ./organize.sh --yes"
      echo "  ./organize.sh --source FOLDER"
      exit 0
      ;;
    *)
      echo "Opsi tidak dikenal: $1"
      echo "Gunakan ./organize.sh --help"
      exit 1
      ;;
  esac

  shift
done

declare -A CATEGORIES=(
  ["Gambar"]="*.jpg *.jpeg *.png *.gif *.webp"
  ["Video"]="*.mp4 *.mkv *.avi *.webm"
  ["Audio"]="*.mp3 *.m4a *.wav *.ogg *.flac"
  ["Dokumen"]="*.pdf *.doc *.docx *.xls *.xlsx *.ppt *.pptx *.txt"
  ["APK"]="*.apk"
  ["Arsip"]="*.zip *.rar *.7z *.tar *.gz"
)

count_files() {
  local patterns="$1"
  local total=0
  local pattern

  for pattern in $patterns; do
    while IFS= read -r -d '' file; do
      total=$((total + 1))
    done < <(find "$SOURCE_DIR" -maxdepth 1 -type f -iname "$pattern" -print0)
  done

  echo "$total"
}

show_preview() {
  local category
  local patterns
  local pattern
  local found=false

  echo "Preview file yang ditemukan:"
  echo

  for category in "${!CATEGORIES[@]}"; do
    patterns="${CATEGORIES[$category]}"

    for pattern in $patterns; do
      while IFS= read -r -d '' file; do
        echo "[PREVIEW] $(basename "$file") -> $category/"
        found=true
      done < <(find "$SOURCE_DIR" -maxdepth 1 -type f -iname "$pattern" -print0)
    done
  done

  if [ "$found" = false ]; then
    echo "Tidak ada file yang cocok untuk dirapikan."
    exit 0
  fi
}

move_category() {
  local category="$1"
  local patterns="$2"
  local destination="$SOURCE_DIR/$category"
  local pattern

  mkdir -p "$destination"

  for pattern in $patterns; do
    while IFS= read -r -d '' file; do
      mv -n "$file" "$destination/"
      echo "[PINDAH] $(basename "$file") -> $category/"
    done < <(find "$SOURCE_DIR" -maxdepth 1 -type f -iname "$pattern" -print0)
  done
}

show_preview

if [ "$DRY_RUN" = true ]; then
  echo
  echo "Preview selesai. Tidak ada file yang dipindahkan."
  exit 0
fi

if [ "$AUTO_CONFIRM" = false ]; then
  echo
  read -r -p "Lanjut memindahkan file? (y/N): " answer

  case "$answer" in
    y|Y|yes|YES)
      ;;
    *)
      echo "Dibatalkan. Tidak ada file yang dipindahkan."
      exit 0
      ;;
  esac
fi

for category in "${!CATEGORIES[@]}"; do
  move_category "$category" "${CATEGORIES[$category]}"
done

echo
echo "Selesai. File Download sudah dirapikan."
