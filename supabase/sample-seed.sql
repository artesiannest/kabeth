-- DATA CONTOH. Jalankan SETELAH schema.sql di Supabase SQL Editor.
-- Semua teks di sini dummy, bukan data resmi gereja.
-- Aman dijalankan ulang (upsert berdasarkan kind/lang/slug).
insert into public.cms_entries (kind,lang,title,slug,excerpt,body,event_date,status) values
 ('halaman','id','Selamat Datang di Gereja Kabeth Suli','selamat-datang','Bersama bertumbuh dalam iman, kasih, dan pelayanan.','Ini adalah konten CONTOH untuk pengembangan desain website. Ganti dengan profil gereja setelah tampilan disetujui.',null,'published'),
 ('halaman','en','Welcome to Kabeth Suli Church','welcome','Growing together in faith, love, and service.','This is SAMPLE content for design development. Replace with the official church profile later.',null,'published'),
 ('artikel','id','Renungan: Hidup dalam Kasih','renungan-hidup-dalam-kasih','Renungan singkat mengenai kasih dalam kehidupan sehari-hari.','Konten contoh: Kasih diwujudkan melalui tindakan kecil, saling mendukung, dan perhatian kepada sesama.',null,'published'),
 ('artikel','id','Melayani dengan Sukacita','melayani-dengan-sukacita','Belajar memberi waktu dan talenta dalam pelayanan.','Konten contoh: Setiap orang mempunyai kesempatan untuk melayani sesuai kemampuan yang dimiliki.',null,'published'),
 ('artikel','en','Serving with Joy','serving-with-joy','A short reflection on serving our community.','Sample content: Everyone has a gift to share and an opportunity to serve.',null,'published'),
 ('warta','id','Warta Jemaat — Contoh','warta-jemaat-contoh','Pengumuman contoh untuk pengujian komponen warta jemaat.','Konten contoh, bukan pengumuman gereja yang sebenarnya. Silakan edit melalui panel admin.',null,'published'),
 ('warta','en','Weekly Bulletin — Sample','weekly-bulletin-sample','A placeholder bulletin for design testing.','Sample content only. Replace before publishing the official church website.',null,'published'),
 ('jadwal','id','Ibadah Minggu — Contoh','ibadah-minggu-contoh','Minggu, pukul 09.00 WITA (contoh; bukan jadwal resmi).','Tanggal dan jam ini hanya data dummy untuk pengembangan tampilan.','2026-12-06','published'),
 ('jadwal','id','Latihan Paduan Suara — Contoh','latihan-paduan-suara','Kegiatan contoh untuk uji tampilan jadwal.','Lokasi, jam, dan tanggal bukan informasi resmi.','2026-12-09','published'),
 ('direktori','id','Pelayanan Pemuda — Contoh','pelayanan-pemuda','Informasi direktori pelayanan (contoh).','Kontak dan petugas belum diisi karena ini merupakan data contoh.',null,'published'),
 ('direktori','id','Pelayanan Anak — Contoh','pelayanan-anak','Informasi kelompok pelayanan anak (contoh).','Ganti dengan informasi resmi dari pengurus gereja.',null,'published'),
 ('galeri','id','Galeri Kebersamaan — Contoh','galeri-kebersamaan','Placeholder galeri untuk desain kartu foto.','Foto dan keterangan dapat ditambahkan dari admin setelah Supabase Storage terhubung.',null,'published'),
 ('galeri','en','Community Gallery — Sample','community-gallery','Placeholder gallery card.','Add official photos through the CMS when Supabase Storage is configured.',null,'published')
on conflict (kind,lang,slug) do update set title=excluded.title,excerpt=excluded.excerpt,body=excluded.body,event_date=excluded.event_date,status=excluded.status;
