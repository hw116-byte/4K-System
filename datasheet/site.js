
(function(){
 const q=document.getElementById('q'), box=document.getElementById('results'); let sel=-1;
 function esc(s){return s.replace(/[&<>]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;'}[c]))}
 function run(){
  const v=q.value.trim().toLowerCase(); sel=-1;
  if(v.length<2){box.style.display='none';return}
  const words=v.split(/\s+/); const hits=[];
  for(const e of (window.SEARCH_INDEX||[])){
   const t=e.t.toLowerCase(), s=e.s.toLowerCase(); if(!words.every(w=>t.includes(w)||s.includes(w))) continue;
   let score=words.reduce((a,w)=>a+(s.includes(w)?5:0)+(t.split(w).length-1),0); hits.push([score,e]);
  }
  hits.sort((a,b)=>b[0]-a[0]);
  box.innerHTML = hits.length ? hits.slice(0,12).map(([_,e])=>{
   const i=e.t.toLowerCase().indexOf(words[0]); const a=Math.max(0,i-60);
   let snip=esc((a?'… ':'')+e.t.slice(a,a+170)+'…');
   for(const w of words){ if(w.length>1) snip=snip.replace(new RegExp('('+w.replace(/[.*+?^${}()|[\]\\]/g,'\\$&')+')','ig'),'<mark>$1</mark>') }
   return `<a href="${e.u}"><b>${esc(e.s)}</b> <small>${esc(e.p)}</small><small>${snip}</small></a>`}).join('')
   : '<div style="padding:10px;color:#6b7178">No matches</div>';
  box.style.display='block';
 }
 q.addEventListener('input',run);
 q.addEventListener('keydown',ev=>{const L=[...box.querySelectorAll('a')]; if(!L.length) return;
  if(ev.key==='ArrowDown'){sel=Math.min(sel+1,L.length-1);ev.preventDefault()} else if(ev.key==='ArrowUp'){sel=Math.max(sel-1,0);ev.preventDefault()}
  else if(ev.key==='Enter'){location.href=(L[Math.max(sel,0)]).href;return} else if(ev.key==='Escape'){box.style.display='none';return} else return;
  L.forEach((a,i)=>a.classList.toggle('sel',i===sel))});
 document.addEventListener('click',e=>{if(!e.target.closest('.search')) box.style.display='none'});
 document.addEventListener('keydown',e=>{if(e.key==='/'&&document.activeElement!==q){e.preventDefault();q.focus()}});
 const t=document.querySelector('.toggle'); if(t) t.addEventListener('click',()=>document.querySelector('.side').classList.toggle('open'));
})();
