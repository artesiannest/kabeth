# Kabeth Suli — starter ringan (GitHub Pages + Supabase)

**Versi khusus pengembangan tampilan**: menggantikan aset Sitejet besar dengan halaman contoh yang ringan dan mudah dimodifikasi. **Tidak identik dengan website Sitejet asli**. Semua teks/jadwal/direktori adalah data dummy, bukan informasi resmi gereja. Tidak ada file media besar, foto asli, backup hosting atau kredensial.

## Pratinjau tanpa Supabase

1. Windows: jalankan `JALANKAN-WINDOWS.bat`. macOS/Linux: `sh JALANKAN-MAC-LINUX.sh` (Python 3).
2. Buka `http://localhost:5173/id/` atau `/en/`.
3. Data contoh langsung muncul dari `site/cms/sample-data.js`, **tanpa database**. Anda bisa mengubah gaya di `site/assets/site.css`.
4. `/admin.html` memerlukan Supabase sungguhan untuk login dan menyimpan perubahan (tidak ada password demo).

## Menyambungkan Supabase

1. Buat proyek di https://supabase.com/dashboard.
2. SQL Editor: jalankan `supabase/schema.sql`, **lalu** `supabase/sample-seed.sql` untuk mengisi 13 entri contoh di database (bisa dijalankan ulang).
3. Authentication > Users: buat akun administrator dengan email dan sandi kuat.
4. SQL Editor: jalankan `insert into public.cms_admins(user_id) select id from auth.users where email='EMAIL_ANDA' on conflict (user_id) do nothing;` dengan email sebenarnya.
5. Isi `site/cms/config.js` dengan **Project URL** dan **publishable/anon key** (jangan pakai service_role/secret key).
6. Refresh halaman. Bila Supabase terhubung, beranda dan katalog menampilkan `cms_entries` terbit dari database; jika tidak terhubung, contoh lokal tampil. Panel `/admin.html` dapat menambah/mengedit/hapus konten.
7. Atur Supabase Auth URL Configuration sesuai GitHub Pages jika memakai tautan konfirmasi/reset email.

## Deploy GitHub Pages

1. Buat repository `USERNAME.github.io` dan unggah **isi folder paket** termasuk `.github/workflows/pages.yml`.
2. GitHub → Settings → Pages → Source = GitHub Actions. Push branch `main`.
3. Akses `https://USERNAME.github.io/id/`, `/en/`, `/konten.html`, `/admin.html`.
4. Workflow mengunggah `site/`. Semua path relatif untuk memudahkan perubahan desain; hosting di repo proyek juga dapat digunakan dengan pendekatan deployment Pages yang sama.

## Isi contoh

- 13 entri terbit: profil (ID+EN), artikel (ID+EN), warta (ID+EN), galeri (ID+EN), jadwal, direktori.
- Teks contoh bisa diubah lewat CMS setelah Supabase aktif.
- Foto masih memakai ikon placeholder sehingga tidak ada media besar yang perlu diunggah.
- Bersihkan entri dummy sebelum publikasi resmi.

## Penting

GitHub Pages hanya hosting statis; autentikasi, database dan foto dikelola Supabase. `schema.sql` menggunakan RLS sehingga pengunjung hanya melihat konten terbit; admin dapat mengubah data setelah akunnya dimasukkan ke `cms_admins`. Demo ini **belum diaudit untuk produksi**. Konten Sitejet lama tidak termasuk, agar fokus lebih dulu pada redesign.
