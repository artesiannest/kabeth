# Gereja Kabeth Suli — perbaikan GitHub Pages

**PERBAIKAN:** file website sekarang berada langsung di ROOT repository, bukan di folder `site/`. Saat membuka `https://artesiannest.github.io/kabeth/`, `index.html` mengarahkan ke `/kabeth/id/` dan halaman situs contoh tampil.

## Langkah mengganti repo lama `kabeth`

1. Ekstrak ZIP ini.
2. Di GitHub buka repository `artesiannest/kabeth`. Hapus folder `site` lama (jika ada) dari repo agar tidak membingungkan; jangan hapus repo atau riwayat.
3. Unggah **ISI ZIP** ke ROOT repo, bukan folder ZIP utuh. Pastikan `index.html`, `admin.html`, folder `id`, `en`, `assets`, `cms`, `supabase`, dan `.github` berada di root repo. Jika memakai GitHub web upload dan file `.github` tidak ikut, gunakan Git CLI atau buat workflow melalui editor GitHub.
4. Pada Settings → Pages, pilih Source **GitHub Actions**. Pastikan branch `main`. Buka tab Actions, lihat workflow `Deploy Gereja Kabeth Suli` sukses.
5. Buka `https://artesiannest.github.io/kabeth/`; bila cache lama tetap tampil, lakukan hard-refresh (Ctrl+Shift+R).

## URL
- Beranda: https://artesiannest.github.io/kabeth/
- Indonesia: https://artesiannest.github.io/kabeth/id/
- English: https://artesiannest.github.io/kabeth/en/
- CMS: https://artesiannest.github.io/kabeth/admin.html

## Supabase
- Website berisi data contoh bawaan tanpa konfigurasi Supabase.
- Login admin baru aktif setelah membuat project Supabase, menjalankan `supabase/schema.sql`, `supabase/sample-seed.sql`, menambahkan user admin di tabel `cms_admins`, dan mengisi Project URL serta publishable/anon key pada `cms/config.js`.
- Query `insert into public.cms_admins ...` **dijalankan di SQL Editor Supabase**, bukan ditempelkan pada browser. Ganti `EMAIL_ANDA` dengan email akun Auth yang dibuat.
- Jangan memasukkan Supabase service_role/secret key ke repository publik.

## Localhost
Di folder ini, jalankan `python -m http.server 5173`, lalu buka `http://localhost:5173/`.

Ini starter ringan untuk desain, **bukan salinan Sitejet 100% identik**.
