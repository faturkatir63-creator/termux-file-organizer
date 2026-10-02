# Termux File Organizer

Script Bash untuk merapikan file di folder Download Android menggunakan Termux.

## Fitur

- Memindahkan gambar ke folder `Gambar`
- Memindahkan video ke folder `Video`
- Memindahkan dokumen ke folder `Dokumen`
- Memindahkan file APK ke folder `APK`
- Memindahkan file arsip ke folder `Arsip`
- Tidak menimpa file dengan nama yang sama

## Kebutuhan

- Android
- Termux
- Izin akses storage untuk Termux

## Instalasi

Clone repository ini:

```bash
git clone [https://github.com/faturkatir63-creator/termux-file-organizer.git](https://github.com/faturkatir63-creator/termux-file-organizer.git)
cd termux-file-organizer
```

Berikan izin akses storage:

```bash
termux-setup-storage
```

Jalankan script:

## Mode preview

Gunakan mode preview untuk melihat file yang akan dipindahkan tanpa mengubah apa pun:

```bash
./organize.sh --dry-run
```

Jika hasilnya sudah sesuai, jalankan tanpa opsi:

```bash
./organize.sh
```

```bash
chmod +x organize.sh
./organize.sh
```

## Folder hasil

Script akan membuat folder berikut di dalam Download:

```text
Download/
├── Gambar/
├── Video/
├── Dokumen/
├── APK/
└── Arsip/
```

## Jenis file

| Kategori | Ekstensi |
|---|---|
| Gambar | jpg, jpeg, png, gif, webp |
| Video | mp4, mkv, avi, webm |
| Dokumen | pdf, doc, docx, xls, xlsx, ppt, pptx, txt |
| APK | apk |
| Arsip | zip, rar, 7z, tar, gz |

## Catatan

Script hanya memindahkan file yang berada langsung di folder Download. Subfolder yang sudah ada tidak diproses.

Gunakan dengan hati-hati dan cek isi folder Download sebelum menjalankan script.

## Lisensi

MIT License
