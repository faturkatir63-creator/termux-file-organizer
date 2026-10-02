# Termux File Organizer

Script Bash sederhana untuk merapikan file dalam folder Android dari Termux berdasarkan jenis file.

## Fitur

- Mengelompokkan file ke folder kategori secara otomatis
- Mendukung mode preview dengan `--dry-run`
- Mendukung konfirmasi otomatis dengan `--yes`
- Mendukung folder sumber kustom dengan `--source FOLDER`
- Tidak memindahkan folder, hanya file yang ada langsung di folder sumber

## Kategori file

| Kategori | Ekstensi |
| --- | --- |
| Gambar | jpg, jpeg, png, gif, webp |
| Video | mp4, mkv, avi, webm |
| Audio | mp3, m4a, wav, ogg, flac |
| Dokumen | pdf, doc, docx, xls, xlsx, ppt, pptx, txt |
| APK | apk |
| Arsip | zip, rar, 7z, tar, gz |

## Persiapan

Aktifkan akses penyimpanan Termux:

```bash
termux-setup-storage
```

Pastikan Bash tersedia:

```bash
pkg install bash
```

## Cara pakai

Masuk ke folder proyek:

```bash
cd ~/termux-file-organizer
```

Beri izin eksekusi:

```bash
chmod +x organize.sh
```

Rapikan folder Download default:

```bash
./organize.sh
```

Preview tanpa memindahkan file:

```bash
./organize.sh --dry-run
```

Rapikan tanpa pertanyaan konfirmasi:

```bash
./organize.sh --yes
```

## Memilih folder sumber

Secara default, script menggunakan:

```text
~/storage/downloads
```

Gunakan `--source` untuk memilih folder lain:

```bash
# Preview file di folder Pictures
./organize.sh --source ~/storage/pictures --dry-run

# Rapikan file di folder Pictures
./organize.sh --source ~/storage/pictures

# Rapikan folder uji tanpa pertanyaan konfirmasi
./organize.sh --source ~/organizer-test --yes
```

## Contoh hasil

Misalnya folder sumber berisi:

```text
foto.jpg
lagu.mp3
laporan.pdf
aplikasi.apk
backup.zip
```

Setelah script dijalankan, hasilnya menjadi:

```text
Folder-Sumber/
├── APK/
│   └── aplikasi.apk
├── Arsip/
│   └── backup.zip
├── Audio/
│   └── lagu.mp3
├── Dokumen/
│   └── laporan.pdf
└── Gambar/
    └── foto.jpg
```

## Bantuan

Tampilkan seluruh opsi yang tersedia:

```bash
./organize.sh --help
```

## Catatan

- Gunakan `--dry-run` terlebih dahulu sebelum pemindahan nyata.
- Script hanya memeriksa file di level pertama folder sumber.
- File yang ekstensinya tidak tercantum dalam kategori tidak dipindahkan.
- Hindari menjalankan script pada folder sistem atau folder aplikasi yang sensitif.
