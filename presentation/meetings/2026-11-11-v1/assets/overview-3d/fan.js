import * as THREE from 'three';
// 60 x 60 x 15 mm 12 V fan (e.g. Noctua NF-A6x15 FLX) for HDMI Extension Board V41 fan header J930.
// Simple illustrative body in mm: origin at the fan centre, thickness along +y. Position under the board is illustrative (no mount designed).
export const FAN = {size: 60, thick: 15, centre: [182, 100], j930: [134.6, 51.2]}; // KiCad mm: centred under the XEM8310 (MC1-MC3); J930 pins
export function makeFan(){
 const g = new THREE.Group();
 const frameMat = new THREE.MeshStandardMaterial({color:0x2e3236, roughness:.7});
 const bladeMat = new THREE.MeshStandardMaterial({color:0x4a5056, roughness:.6, side:THREE.DoubleSide});
 const s = FAN.size/2, sh = new THREE.Shape();
 sh.moveTo(-s,-s); sh.lineTo(s,-s); sh.lineTo(s,s); sh.lineTo(-s,s); sh.closePath();
 const hole = new THREE.Path(); hole.absarc(0,0,28.5,0,Math.PI*2,true); sh.holes.push(hole);
 for(const [x,z] of [[-25,-25],[25,-25],[25,25],[-25,25]]){const h=new THREE.Path();h.absarc(x,z,2.2,0,Math.PI*2,true);sh.holes.push(h)}
 const frame = new THREE.Mesh(new THREE.ExtrudeGeometry(sh,{depth:FAN.thick,bevelEnabled:false,curveSegments:32}), frameMat);
 frame.rotation.x = -Math.PI/2; g.add(frame);
 const hub = new THREE.Mesh(new THREE.CylinderGeometry(11,11,FAN.thick-2,32), frameMat); hub.position.y = FAN.thick/2; g.add(hub);
 for(let k=0;k<7;k++){const b=new THREE.Mesh(new THREE.BoxGeometry(17,.8,11),bladeMat);const p=new THREE.Group();b.position.x=19;b.rotation.x=.45;p.add(b);p.rotation.y=k*Math.PI*2/7;p.position.y=FAN.thick/2;g.add(p)}
 return g;
}
// Cable from the fan's edge to the J930 plug (points in the same frame as the fan's parent, mm).
// J930 is a right-angle KK 254 header on the bottom; the 3-pin housing enters from the south (+KiCad y), so a plug body is drawn there.
export function makeFanCable(a, b){
 const g = new THREE.Group(), dark = new THREE.MeshStandardMaterial({color:0x1d1f21, roughness:.8});
 const plug = new THREE.Mesh(new THREE.BoxGeometry(7.6, 5.0, 10.0), new THREE.MeshStandardMaterial({color:0xe9e4d4, roughness:.7}));
 plug.position.set(b.x, b.y, b.z + 4.5 + 5.0); g.add(plug);              // header mouth about 4.5 mm south of the pins
 const end = new THREE.Vector3(b.x, b.y, b.z + 4.5 + 10.0);
 const mid = a.clone().lerp(end,.5); mid.y = Math.min(a.y, end.y) - 6;
 const c = new THREE.CatmullRomCurve3([a, a.clone().add(new THREE.Vector3(0,-3,0)), mid, end.clone().add(new THREE.Vector3(0,-2,6)), end]);
 g.add(new THREE.Mesh(new THREE.TubeGeometry(c,48,.9,8,false), dark));
 return g;
}
