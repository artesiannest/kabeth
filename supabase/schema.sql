-- Jalankan sekali di Supabase > SQL Editor. Setelah itu tambahkan admin melalui auth.users.
create extension if not exists pgcrypto;
create table if not exists public.cms_admins (
 user_id uuid primary key references auth.users(id) on delete cascade,
 added_at timestamptz not null default now()
);
create table if not exists public.cms_entries (
 id uuid primary key default gen_random_uuid(),
 kind text not null check (kind in ('artikel','warta','galeri','jadwal','direktori','halaman')),
 lang text not null default 'id' check (lang in ('id','en')),
 title text not null,
 slug text not null,
 excerpt text not null default '',
 body text not null default '',
 image_url text,
 event_date date,
 status text not null default 'draft' check (status in ('draft','published')),
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 unique(kind,lang,slug)
);
create index if not exists cms_entries_public_idx on public.cms_entries(kind,lang,status,created_at desc);
create or replace function public.cms_is_admin() returns boolean language sql stable security definer set search_path = '' as $$
 select exists (select 1 from public.cms_admins where user_id = (select auth.uid()));
$$;
revoke all on function public.cms_is_admin() from public;
grant execute on function public.cms_is_admin() to anon,authenticated;
alter table public.cms_admins enable row level security;
alter table public.cms_entries enable row level security;
drop policy if exists cms_admins_self on public.cms_admins;
create policy cms_admins_self on public.cms_admins for select to authenticated using (user_id = (select auth.uid()));
drop policy if exists cms_entries_public_read on public.cms_entries;
create policy cms_entries_public_read on public.cms_entries for select to anon,authenticated using (status = 'published' or public.cms_is_admin());
drop policy if exists cms_entries_admin_insert on public.cms_entries;
create policy cms_entries_admin_insert on public.cms_entries for insert to authenticated with check (public.cms_is_admin());
drop policy if exists cms_entries_admin_update on public.cms_entries;
create policy cms_entries_admin_update on public.cms_entries for update to authenticated using (public.cms_is_admin()) with check (public.cms_is_admin());
drop policy if exists cms_entries_admin_delete on public.cms_entries;
create policy cms_entries_admin_delete on public.cms_entries for delete to authenticated using (public.cms_is_admin());
-- Supabase Storage: nama bucket `cms-media`. File yang terunggah dapat dibaca pengunjung.
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('cms-media','cms-media',true,10485760,array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true, file_size_limit = 10485760, allowed_mime_types = excluded.allowed_mime_types;
drop policy if exists cms_media_public_read on storage.objects;
create policy cms_media_public_read on storage.objects for select to anon,authenticated using (bucket_id='cms-media');
drop policy if exists cms_media_admin_insert on storage.objects;
create policy cms_media_admin_insert on storage.objects for insert to authenticated with check (bucket_id='cms-media' and public.cms_is_admin());
drop policy if exists cms_media_admin_update on storage.objects;
create policy cms_media_admin_update on storage.objects for update to authenticated using (bucket_id='cms-media' and public.cms_is_admin()) with check (bucket_id='cms-media' and public.cms_is_admin());
drop policy if exists cms_media_admin_delete on storage.objects;
create policy cms_media_admin_delete on storage.objects for delete to authenticated using (bucket_id='cms-media' and public.cms_is_admin());
-- Setelah buat user di Authentication > Users, ganti EMAIL_ADMIN:
-- insert into public.cms_admins(user_id) select id from auth.users where email = 'EMAIL_ADMIN';
