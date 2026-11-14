(function(){
const url=window.KABETH_SUPABASE_URL, key=window.KABETH_SUPABASE_KEY;
const ready=url && key && !url.startsWith('ISI_') && !key.startsWith('ISI_') && window.supabase;
window.cmsReady=Boolean(ready);
window.cms = ready ? window.supabase.createClient(url,key) : null;
window.cmsKinds={artikel:'Artikel & Renungan',warta:'Warta Jemaat',galeri:'Galeri Foto',jadwal:'Jadwal Ibadah',direktori:'Direktori',halaman:'Halaman & Profil'};
window.cmsEsc=(s)=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
window.cmsBase=()=>location.pathname.includes('/cms/')?'../':'';
})();
