import * as THREE from 'three';
import {GLTFLoader} from './vendor/GLTFLoader.js';
import {OrbitControls} from './vendor/OrbitControls.js';

// Break-off test frame view (18 Nov 2026): the board in its test frame, as in the ONIX NRIC1384 test-board photo.
// The model is the KiCad 3D export of the saved frame project; the pin table comes from its HEADER_PINS.csv.
const $ = id => document.getElementById(id);
const V = '?v=20261119-f5';
const key = new URLSearchParams(location.search).get('board') || 'frontend';
if (new URLSearchParams(location.search).get('embed') === '1') document.documentElement.classList.add('embedded');
const canvas = $('canvas'), stage = $('stage');
let data, model, activeView = 'iso', mode = '3d';
const renderer = new THREE.WebGLRenderer({canvas, antialias: true, alpha: true});
renderer.setPixelRatio(Math.min(devicePixelRatio, 1.5));
renderer.toneMapping = THREE.ACESFilmicToneMapping;
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(35, 1, .05, 5000);
const controls = new OrbitControls(camera, canvas);
renderer.toneMappingExposure = .85;
scene.add(new THREE.HemisphereLight(0xffffff, 0x7d8c92, 1.1));
for (const [p, i] of [[[75, 120, 80], 1.5], [[-45, -90, -60], .5]]) { const l = new THREE.DirectionalLight(0xffffff, i); l.position.set(...p); scene.add(l); }
const render = () => renderer.render(scene, camera);
controls.addEventListener('change', render);
const VIEWS = {iso: [-.55, 1.0, 1.15], top: [0, 1, .001], bottom: [0, -1, .001]};
function fit(view) {
 activeView = view; if (!model) return;
 const sphere = new THREE.Box3().setFromObject(model).getBoundingSphere(new THREE.Sphere());
 const half = THREE.MathUtils.degToRad(camera.fov / 2), lim = Math.min(half, Math.atan(Math.tan(half) * camera.aspect));
 camera.near = Math.max(.02, sphere.radius / 400); camera.far = sphere.radius * 40 + 500; camera.updateProjectionMatrix();
 controls.target.copy(sphere.center);
 camera.position.copy(sphere.center).add(new THREE.Vector3(...VIEWS[view]).normalize().multiplyScalar(sphere.radius / Math.sin(lim) * 1.02));
 controls.update(); render();
 document.querySelectorAll('[data-view]').forEach(b => b.setAttribute('aria-pressed', String(b.dataset.view === view)));
}
function resize() { const {width, height} = stage.getBoundingClientRect(); if (width < 1 || height < 1) return; renderer.setSize(width, height, false); camera.aspect = width / height; camera.updateProjectionMatrix(); fit(activeView); }
function setMode(m) {
 mode = m; $('photo').hidden = m !== 'photo'; canvas.style.visibility = m === 'photo' ? 'hidden' : 'visible';
 document.querySelectorAll('[data-mode]').forEach(b => b.setAttribute('aria-pressed', String(b.dataset.mode === m)));
 document.querySelectorAll('[data-view]').forEach(b => b.disabled = m === 'photo');
}
async function build() {
 data = await (await fetch('frame/' + key + '.json' + V)).json();
 document.title = data.title + ' · test frame';
 $('title').textContent = data.title + ' · test frame';
 $('detail').textContent = data.detail;
 $('summary').innerHTML = data.summary;
 const tb = $('pins').querySelector('tbody');
 for (const p of data.pins) {
  const tr = document.createElement('tr'); if (/^(A|D)?GND/i.test(p.net)) tr.className = 'gnd';
  const a = document.createElement('td'); a.textContent = p.pin; const b = document.createElement('td'); b.innerHTML = '<b></b><small></small>'; b.querySelector('b').textContent = p.label || p.net; b.querySelector('small').textContent = p.label && p.label !== p.net ? p.net : ''; const c = document.createElement('td'); c.textContent = p.fn || ''; tr.append(a, b, c);
  tb.append(tr);
 }
 $('files').innerHTML = data.files.map(f => '<a href="' + f.href + '" target="_blank" rel="noopener"' + (f.dl ? ' download=""' : '') + '>' + f.label + '</a>').join('');
 if (data.render) { $('photo').src = data.render; $('photo').alt = data.title + ' in its test frame, KiCad render'; } else document.querySelector('[data-mode="photo"]').hidden = true;
 if (data.render) setMode('photo');
 const gltf = await new GLTFLoader().loadAsync('assets/' + data.glb + V);
 model = gltf.scene; model.scale.setScalar(1000); scene.add(model);
 resize(); $('loading').hidden = true; document.body.dataset.ready = 'true';
}
new ResizeObserver(resize).observe(stage);
document.querySelectorAll('[data-view]').forEach(b => b.onclick = () => fit(b.dataset.view));
document.querySelectorAll('[data-mode]').forEach(b => b.onclick = () => setMode(b.dataset.mode));
window.frameViewer = {state: () => ({key, ready: !!model, pins: data?.pins.length, calls: renderer.info.render.calls})};
build().catch(e => { $('loading').textContent = 'Unable to load the 3D model.'; console.error(e); });
