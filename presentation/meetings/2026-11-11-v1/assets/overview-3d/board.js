import * as THREE from 'three';
import {GLTFLoader} from './vendor/GLTFLoader.js';
import {OrbitControls} from './vendor/OrbitControls.js';
import {addPcb5Bodies} from './pcb5.js?v=3';
import {addProbeBodies} from './probe.js?v=1';

const boards = {
 hdmi: ['HDMI Extension Board · V40','hdmi-extension-v40.glb?v=20261123','V39 copper (20 probe pads) with four stocked-part swaps (V40) · nine voltage test holes at J920'],
 frontend: ['Frontend FPGA Board · 14 layers V14 in test frame V4','frontend-test-frame-v4.glb?v=20261123','The board in its break-off test frame, the fab and assembly panel · 2x8 box header C3406 · 14 layers · pin map V8'],
 ldo: ['FPGA-LDO Option A · V24 in test frame V4','fpga-ldo-a-test-frame-v4.glb?v=20261119','The board in its break-off test frame, the fab and assembly panel · 2x10 box header C3405 · pin map V8 · vendor connector models'],
 asic: ['ASIC board · PCB-5','asic-pcb5-real.glb','0.8 mm board · Hirose DF40C-80 connectors · two ASIC dies with probes (probe size illustrative)'],
 asic_top: ['ASIC board · top · V15','asic-top-v15.glb?v=20261119','0.8 mm board · Hirose DF40C-80 connectors · two ASIC dies, each with its SC512 probe'],
 asic_bottom: ['ASIC board · bottom · V15','asic-bottom-v15.glb?v=20261119','0.8 mm board · Hirose DF40C-80 connectors · two ASIC dies, each with its SC512 probe'],
 ldob_router: ['FPGA-LDO Option B · router V2','fpga-ldo-b-router-v2.glb','On the head · J5 (120-pin) has no vendor model yet'],
 ldob_ldo: ['FPGA-LDO Option B · LDO board V2','fpga-ldo-b-ldo-v2.glb','Plug-in board · J5 (120-pin) has no vendor model yet'],
 ldob_router_v3: ['FPGA-LDO Option B · router V3','optb-router-v3-placement.glb?v=202611241613','Stays on the animal · 22.69 × 17.62 mm · J3 top / J4 bottom to the ASIC boards, J6 + J5 DF40C-80DS to the drive board · placement only, not routed'],
 ldob_router_v3_l1: ['Option B Router V3 · layout V1 (routed)','optb-router-v3-layout-v1.glb?v=202611250754','Stays on the animal · 22.69 × 17.62 mm · 6 layers 1+4+1 HDI · all 142 nets routed, DRC 0 · J3 top / J4 bottom to the ASIC boards, J6 + J5 DF40C-80DS to the drive board'],
 ldob_ldo_v3: ['FPGA-LDO Option B · LDO board V3','optb-ldo-board-v3-placement.glb?v=202611241613','Plugs in each session · 22.69 × 40.30 mm · J6 + J5 DF40C-80DP to the router, J1/J2 to the Frontend, regulators on the bottom · placement only, not routed'],
 carrier_v7: ['4K Direct LDO Carrier · V7 layout V2','4k-direct-ldo-carrier-v7-placement.glb?v=202611241955','XEM8305 sockets MC1–MC3 + ASIC-rail regulators + J5/J6 DF40C-80DP to the Option B router on the MC1-edge tongue · 63.85 × 83.05 mm · 203 parts placed, not routed'],
 fe_v17_f7: ['Frontend · 14 layers V17 · test pads Plan A · test frame V7','frontend-v17-test-frame-v7.glb?v=202611241116','Plan A: 67 probe pads on the board + 2x8 header on the break-off test frame · new 4 × 3 mm flash U7 · U12 and Y1 have no 3D model'],
 fe_v18_f8: ['Frontend · 14 layers V18 · test pads Plan B · frame V8','frontend-v18-frame-v8.glb?v=202611241115','Plan B: 9 plated half holes on the south edge + the probe pads · new 4 × 3 mm flash U7 · U12 and Y1 have no 3D model'],
 ldo_v26_f6: ['FPGA-LDO A · layout V26 · test pads Plan B · frame V6','fpga-ldo-a-v26-frame-v6.glb?v=202611231013','Plan B: 15 plated half holes on four edges + the probe pads'],
 hdmi_v41: ['HDMI Extension Board · V41','hdmi-extension-v41.glb?v=202611242142','V40 copper unchanged · 2.00 mm male headers J900–J902, J910, J911 · 2.54 mm rail pins J920–J928 · 12 V fan header J930 on the bottom']
};
const views = {iso:[.8,1.1,1.25],top:[0,1,.001],bottom:[0,-1,.001]};
const key = new URLSearchParams(location.search).get('board');
const config = Object.hasOwn(boards,key) ? boards[key] : boards.hdmi;
const [title,filename,detail] = config;
const loading = document.getElementById('loading');
document.title = title;
document.getElementById('title').textContent = title;
document.getElementById('detail').textContent = detail;

async function showBoard(){
 const canvas = document.getElementById('canvas');
 const stage = document.getElementById('stage');
 const renderer = new THREE.WebGLRenderer({canvas,antialias:true,alpha:true});
 renderer.setPixelRatio(Math.min(devicePixelRatio,1.5));
 renderer.toneMapping = THREE.ACESFilmicToneMapping;
 const scene = new THREE.Scene();
 const camera = new THREE.PerspectiveCamera(35,1,.01,10000);
 const controls = new OrbitControls(camera,canvas);
 const render = () => renderer.render(scene,camera);
 controls.addEventListener('change',render);
 scene.add(new THREE.HemisphereLight(0xffffff,0xa6b8c3,2.3));
 for(const position of [[75,120,80],[-45,-90,-60]]){
  const light = new THREE.DirectionalLight(0xffffff,1.8);
  light.position.set(...position);
  scene.add(light);
 }
 const gltf = await new GLTFLoader().loadAsync('assets/'+filename);
 const board = gltf.scene;
 if(key==='asic') addPcb5Bodies(board);
 if(key==='asic_top'||key==='asic_bottom') addProbeBodies(board);  // SC512 probe per ASIC (14 Nov 2026)  // V7 files are 0.8 mm (V4 files were 1.6 mm, lift 0.8)
 board.scale.setScalar(1000);
 scene.add(board);
 const bounds = new THREE.Box3().setFromObject(board);
 const sphere = bounds.getBoundingSphere(new THREE.Sphere());
 let activeView = 'iso';
 function fit(view){
  activeView = view;
  const halfFov = THREE.MathUtils.degToRad(camera.fov/2);
  const limiting = Math.min(halfFov,Math.atan(Math.tan(halfFov)*camera.aspect));
  const offset = new THREE.Vector3(...(view==='iso' && key==='ldo' && !/test-frame/.test(filename) ? [.8,-1.1,1.25] : views[view])).normalize().multiplyScalar(sphere.radius / Math.sin(limiting) * 1.08);
  controls.target.copy(sphere.center);
  camera.position.copy(sphere.center).add(offset);
  controls.update();
  render();
  document.querySelectorAll('[data-view]').forEach(button => button.setAttribute('aria-pressed',String(button.dataset.view===view)));
 }
 function resize(){
  const {width,height} = stage.getBoundingClientRect();
  if(width<1 || height<1) return;
  renderer.setSize(width,height,false);
  camera.aspect = width/height;
  camera.updateProjectionMatrix();
  fit(activeView);
 }
 new ResizeObserver(resize).observe(stage);
 document.querySelectorAll('[data-view]').forEach(button => button.onclick = () => fit(button.dataset.view));
 resize();
 loading.hidden = true;
 document.body.dataset.ready = 'true';
}
showBoard().catch(error => {
 loading.textContent = 'Unable to load the 3D model. Open the deck through its local launcher.';
 console.error(error);
});
