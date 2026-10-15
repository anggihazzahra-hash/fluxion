# Fluxion (Dockerized)

Fluxion adalah website streaming film statis berbasis HTML, CSS, dan JavaScript. Fitur utama: halaman login/registrasi, daftar film dan series, serta halaman nonton per film. Proyek ini dibungkus dengan Docker (Nginx) supaya bisa dijalankan siapa pun tanpa setup manual.

## Prasyarat

- Docker Desktop (atau Docker Engine) yang sedang berjalan
- Git

Versi yang diuji:

| Komponen | Versi |
|---|---|
| Docker Desktop | 4.95.0 |
| Docker Engine | 29.8.2 |
| Docker Compose | v5.6.0 |
| OS / Arsitektur | macOS, arm64 (Apple Silicon) |

## Clone dan konfigurasi

```bash
git clone https://github.com/anggihazzahra-hash/fluxion.git
cd fluxion
git checkout chore/dockerize-project
cp .env.example .env
```

Variabel environment (lihat `.env.example`):

| Variabel | Default | Fungsi |
|---|---|---|
| `HOST_PORT` | `8080` | Port di komputer kamu untuk membuka website |

Tidak ada secret di proyek ini.

## Build dan jalankan

Dengan Docker Compose (disarankan):

```bash
docker compose up --build -d
```

Atau dengan Docker biasa:

```bash
docker build -t group06/fluxion:week6 .
docker run -d --name fluxion-web -p 8080:80 group06/fluxion:week6
```

## URL dan port

| Item | Nilai |
|---|---|
| URL | http://localhost:8080 |
| Port host | 8080 (bisa diubah lewat `HOST_PORT`) |
| Port container | 80 |

## Verifikasi

1. Cek status container:
```bash
   docker compose ps
```
   Hasil yang diharapkan: status `Up ... (healthy)`.
2. Cek respons web:
```bash
   curl -I http://localhost:8080
```
   Hasil yang diharapkan: `HTTP/1.1 200 OK`.
3. Buka http://localhost:8080 di browser, lalu buka halaman movies dan salah satu halaman film. Halaman harus tampil lengkap (gambar, CSS, header, nav, footer).
4. (Opsional) Uji restart:
```bash
   docker compose restart
   docker compose ps
```

## Log dan status

```bash
docker compose ps
docker compose logs
docker compose logs -f
docker inspect fluxion-web
```

Catatan: baris `GET / ... "Wget"` di log setiap 30 detik adalah health check Docker, bukan pengunjung.

## Stop dan bersihkan

```bash
docker compose down
```

Hapus image juga (opsional):

```bash
docker image rm group06/fluxion:week6
```

## Troubleshooting

| Masalah | Penyebab dan solusi |
|---|---|
| `docker build` error `requires 1 argument` | Titik (`.`) di akhir perintah terlewat. Gunakan `docker build -t group06/fluxion:week6 .` |
| Browser tidak bisa membuka localhost:8080 | Cek `docker compose ps` dan pemetaan port. Pastikan Docker Desktop berjalan |
| Port 8080 sudah dipakai | Ubah `HOST_PORT` di `.env` (misalnya 8081), lalu `docker compose up -d` |
| `Cannot connect to the Docker daemon` | Buka Docker Desktop dan tunggu sampai engine running |
| Perubahan file tidak muncul | Jalankan `docker compose up --build -d` |

## Keterbatasan

- Web statis: tidak ada backend dan database, sehingga login dan registrasi hanya tampilan.
- Diuji di macOS arm64. Image `nginx:alpine` mendukung amd64 dan arm64, sehingga seharusnya berjalan juga di Windows/Linux, tetapi belum diuji.

## Tim

Kelompok 6 : Madan Kishin,Naufal fayyaz, Raisyah EKa, dan Anggih Az'zahra.
