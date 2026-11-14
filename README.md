# Gereja Kabeth Suli — Sitejet asli + GitHub Pages + Supabase

Website publik menggunakan **file HTML, CSS, JavaScript, font dan gambar dari backup `public_html` Sitejet**. Berkas PHP (`api.php`) dan data akun hosting **tidak disertakan**. Halaman CMS (`admin.html`, `konten.html`) memakai Supabase Auth, PostgreSQL dengan RLS, dan Storage.

## 1. Persiapan Supabase

1. Daftar/masuk https://supabase.com/dashboard lalu **New project**.
2. Buka **SQL Editor**, tempel dan jalankan seluruh `supabase/schema.sql`.
3. Buka **Authentication > Users** → **Add user** → Create new user dengan alamat email dan password kuat milik pengurus. Bila opsi tersedia, tandai **email confirmed**.
4. Buka **SQL Editor** lagi; jalankan baris berikut dengan alamat email admin sesungguhnya (ganti contoh):
   ```sql
   insert into public.cms_admins (user_id)
   select id from auth.users where email = 'admin@contoh.org'
   on conflict (user_id) do nothing;
   ```
5. Buka **Project Settings > API / Data API** untuk menyalin **Project URL** dan **publishable key** (atau `anon` key, bukan `service_role` atau secret key).
6. Isi kedua nilai itu pada `site/cms/config.js`, simpan. Nilai publishable/anon memang boleh ada di JavaScript publik; kebijakan keamanan bertumpu pada RLS. **Jangan pernah menaruh service_role/secret key di repository**.
7. Jika menggunakan link konfirmasi email/reset password, atur URL di **Authentication > URL Configuration** ke alamat GitHub Pages Anda; tambahkan URL redirect yang diperlukan.

## 2. Uji localhost

- **Windows:** dua kali klik `JALANKAN-WINDOWS.bat` (perlu Python terpasang).
- **macOS/Linux:** `sh JALANKAN-MAC-LINUX.sh`.
- Website: `http://localhost:5173/en/` dan `http://localhost:5173/id/`.
- Panel admin: `http://localhost:5173/admin.html`.
- Halaman publik konten Supabase: `http://localhost:5173/konten.html`.

**Tidak ada password demo**: login memakai akun Supabase Auth yang dibuat pada langkah 3 dan tercatat di tabel `cms_admins`.

## 3. Deploy GitHub Pages

**Sangat disarankan memakai repository bernama persis `USERNAME.github.io`**, karena template Sitejet memakai URL aset absolut seperti `/css/` dan `/images/`. Situs user Pages akan di-host di root `https://USERNAME.github.io/` sehingga path asli dan efek Sitejet bisa dipertahankan. Bila memakai repository proyek biasa (`https://USERNAME.github.io/NAMA-REPO/`), beberapa aset/animasi Sitejet dapat gagal karena referensi absolut; memindahkan semua aset ke subpath butuh adaptasi terpisah.

1. Buat repository baru `USERNAME.github.io` di GitHub (ganti `USERNAME` dengan username GitHub Anda).
2. Unggah **isi folder paket ini** ke root repository — folder `.github/workflows/pages.yml` harus ikut (folder tersembunyi).
3. Masuk **Settings > Pages > Build and deployment > Source: GitHub Actions**.
4. Push ke branch `main`. Workflow `pages.yml` memublikasikan folder `site/`.
5. Website publik: `https://USERNAME.github.io/en/`; admin: `https://USERNAME.github.io/admin.html`; konten Supabase: `https://USERNAME.github.io/konten.html`.

**Catatan:** GitHub Pages menyajikan file statis. Permintaan server PHP pada fitur Sitejet (seperti form yang mengarah ke `api.php`) tidak berjalan di GitHub Pages dan harus diganti dengan solusi eksternal/Edge Functions jika dibutuhkan. File asli Sitejet dipertahankan, tetapi kesamaan 100% antar browser belum dibuktikan lewat pengujian visual dan beberapa resource pihak ketiga dapat tergantung koneksi internet.

## 4. CMS dan batas integrasi

- Admin: buat/edit/hapus **Artikel, Warta, Galeri, Jadwal, Direktori, Halaman**, draf/terbit, bahasa `id` dan `en`, upload gambar (maks 10MB).
- Semua konten disimpan di `public.cms_entries` (Postgres); gambar di bucket `cms-media`. Kartu konten terbit muncul otomatis di `/konten.html`.
- **Konten Supabase belum disisipkan ke blok Sitejet asli** di halaman `/en/` atau `/id/`. Ini sengaja menjaga tampilan publik 100% seperti export Sitejet. Jika blok dinamis akan diganti konten CMS, perlu pemetaan komponen Sitejet secara khusus.
- Item CMS bertipe `halaman` adalah entri di database, **bukan editor visual Sitejet**; tidak mengubah HTML, CSS atau animasi asli. Jangan menganggap CMS ini sudah dapat mengedit seluruh blok Sitejet.
- Akses edit aman melalui Auth + row level security, tetapi **sebelum produksi** tetap lakukan audit keamanan, kebijakan privasi, backup dan uji dengan akun pengurus.

## 5. Pemeliharaan

- Update file statis Sitejet: ubah file dalam `site/`, commit/push → workflow Pages terbitkan versi baru.
- Update isi CMS: login `/admin.html`, edit konten → Supabase tersimpan segera, tanpa redeploy.
- Backup konten: gunakan fasilitas ekspor database Supabase. Backup media: unduh dari Storage.

Sumber acuan deploy: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site dan https://supabase.com/docs/reference/javascript/installing
