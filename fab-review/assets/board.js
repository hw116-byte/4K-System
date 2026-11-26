// Board fab-review page: tabs, native KiCad schematic (KiCanvas), parts filter.
const $ = s => document.querySelector(s), $$ = s => [...document.querySelectorAll(s)];
const vendor = new URL(window.KICANVAS, location.href).href;
let kicanvasReady = null;

function loadKiCanvas() {
  if (!kicanvasReady) {
    const fonts = document.createElement('link');
    fonts.rel = 'stylesheet'; fonts.href = vendor + 'fonts.css'; document.head.append(fonts);
    kicanvasReady = import(vendor + 'kicanvas.js').then(() => {
      customElements.get('kc-ui-icon').sprites_url = vendor + 'sprites.svg';
    });
  }
  return kicanvasReady;
}

async function showSheet(i) {
  const sheet = window.SHEETS[i];
  for (const b of $$('[data-sheet]')) b.setAttribute('aria-pressed', String(b.dataset.sheet === String(i)));
  await loadKiCanvas();
  const embed = document.createElement('kicanvas-embed');
  embed.setAttribute('src', sheet.src);
  embed.setAttribute('controls', 'full');
  embed.setAttribute('controlslist', 'nooverlay nodownload');
  embed.setAttribute('theme', 'kicad');
  // Use KiCad's own light schematic colours once the document has loaded.
  embed.addEventListener('kicanvas:load', () => {
    const v = inside(embed.shadowRoot, 'kc-schematic-viewer');
    if (!v?.viewer) return;
    v.theme = 'kicad'; v.update_theme(); v.viewer.paint(); v.viewer.draw();
  });
  $('#sch-host').replaceChildren(embed);
}

function inside(root, sel) {
  const m = root?.querySelector(sel); if (m) return m;
  for (const el of root?.querySelectorAll('*') || []) {
    if (el.shadowRoot) { const f = inside(el.shadowRoot, sel); if (f) return f; }
  }
  return null;
}

function openTab(name, push = true) {
  const tab = $(`[data-tab="${name}"]`) ? name : 'sch';
  for (const b of $$('[data-tab]')) b.setAttribute('aria-selected', String(b.dataset.tab === tab));
  for (const p of $$('[data-panel]')) {
    const on = p.dataset.panel === tab;
    p.classList.toggle('active', on);
    const f = p.querySelector('iframe[data-src]');
    if (on && f && !f.src) f.src = f.dataset.src;
  }
  if (push) history.replaceState(null, '', tab === 'sch' ? location.pathname : '#' + tab);
}

for (const b of $$('[data-tab]')) b.onclick = () => openTab(b.dataset.tab);
for (const b of $$('[data-sheet]')) b.onclick = () => showSheet(Number(b.dataset.sheet));
openTab(location.hash.slice(1) || 'sch', false);
window.addEventListener('hashchange', () => openTab(location.hash.slice(1) || 'sch', false));
showSheet(0).catch(e => { $('#sch-host').innerHTML = '<p class="wait">The schematic viewer could not load. Use “Schematic · all pages”.</p>'; console.error(e); });

const filter = $('#bom-filter');
if (filter) filter.oninput = () => {
  const q = filter.value.trim().toLowerCase();
  let n = 0;
  for (const tr of $$('.bom tbody tr')) {
    const show = !q || tr.textContent.toLowerCase().includes(q);
    tr.hidden = !show; if (show) n++;
  }
  $('#bom-count').textContent = `${n} lines`;
};
