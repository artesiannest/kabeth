const $=id=>document.getElementById(id);
const names=window.cmsKinds||{};
async function render(){const root=$('cards');root.innerHTML='<div class="empty">Memuat konten…</div>';
let data=window.KABETH_SAMPLE_DATA||[];let demo=true;
if(window.cmsReady){const {data:records,error}=await cms.from('cms_entries').select('id,kind,lang,title,slug,excerpt,body,image_url,event_date,created_at,status').eq('status','published').order('created_at',{ascending:false}).limit(100);if(!error){data=records||[];demo=false;}else{$('notice').textContent='Koneksi Supabase gagal. Menampilkan data contoh.';}}
if(demo){$('notice').textContent='MODE DEMO: data ini hanya contoh untuk desain. Hubungkan Supabase agar konten berasal dari database.';}else{$('notice').textContent='Konten berasal dari Supabase.';}
data=data.filter(x=>x.lang===$('lang').value&&(!$('kind').value||x.kind===$('kind').value));root.replaceChildren();
if(!data.length){root.innerHTML='<div class="empty">Belum ada konten untuk kategori ini.</div>';return;}
for(const x of data){const a=document.createElement('article');a.className='entry';const symbol=document.createElement('div');symbol.className='entry-art';symbol.textContent=({artikel:'✦',warta:'◈',galeri:'▧',jadwal:'◷',direktori:'♧',halaman:'✧'})[x.kind]||'✦';
if(x.image_url&&/^https:\/\//.test(x.image_url)){const img=document.createElement('img');img.src=x.image_url;img.alt='';img.loading='lazy';symbol.replaceChildren(img);}
const content=document.createElement('div');content.className='entry-content';const tag=document.createElement('div');tag.className='entry-tag';tag.textContent=(names[x.kind]||x.kind)+(x.event_date?' · '+x.event_date:'');const title=document.createElement('h3');title.textContent=x.title;const intro=document.createElement('p');intro.textContent=x.excerpt||'';content.append(tag,title,intro);if(x.body){const details=document.createElement('details');const summary=document.createElement('summary');summary.textContent='Baca selengkapnya';const body=document.createElement('p');body.textContent=x.body;details.append(summary,body);content.append(details);}a.append(symbol,content);root.append(a);}}
$('kind').onchange=render;$('lang').onchange=render;
const q=new URLSearchParams(location.search);if(q.get('jenis'))$('kind').value=q.get('jenis');if(q.get('lang'))$('lang').value=q.get('lang');render();
