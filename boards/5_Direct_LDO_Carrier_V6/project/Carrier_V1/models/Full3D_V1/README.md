# Carrier_V1 complete 3D models V1

26 October 2026. The native board assigns a visible model to all80 fitted component bodies. Eight copper test pads and four mounting holes are intentionally body-free board features.

New models:

- U3: inherited dimension-derived FTDI FT232HQ QFN48,8x8mm,0.5mm pitch, nominal0.85mm height,6.2mm exposed pad. FTDI DS_FT232H v2.2,p51: https://ftdichip.cn/Support/Documents/DataSheets/ICs/DS_FT232H.pdf . Simplified terminals/marking; not downloaded manufacturer CAD.
- U4-U7: inherited dimension-derived TI SN74AXC1T45 DBV, nominal1.6x2.9mm body,0.95mm pitch,1.45mm maximum height. Package source: https://www.ti.com/lit/ds/symlink/sn74axc1t45.pdf . Models rotate90degrees about localZ to match the imported footprint pad numbering; KiCad handles the back-side flip.
- U8: generic KiCad MSOP8,3x3mm,0.65mm pitch.
- Y1: generic KiCad3225 four-pad crystal,3.2x2.5mm nominal body. Exact populated crystal variant and maximum height remain external assembly checks.
- FB1/FB3/FB4: generic KiCad0603 ferrite/inductor body. FB2: inherited dimension-derived Murata BLM21PG221SN1D nominal2.0x1.25x0.85mm. These are visual package representations.
- D3/D4: actual Kingbright AA1608 manufacturer STEP; both product pages link the same file: https://www.kingbrightusa.com/images/catalog/3D/STEP/AA1608.STEP . `Manufacturer_Registered` uses a rigid translation to the footprint origin, with source colors and scale preserved. Registered bounds are1.6x0.8x0.55mm. The manufacturer model is a valid surface BRep (137faces,0closed solids); no watertight-volume or emitting-color claim is made. The unassigned raw manufacturer file is preserved as source evidence.
- U2: same illustrative maximum body envelope as the existing project-local VRML:1.05x1.05x0.40mm,z0..0.40mm. It is now a millimetre STEP at unit scale, replacing VRML's2.54-unit factor combined with0.3937007874native scale. No contacts were invented. This is an envelope visualization, not manufacturer CAD. Original source file cites TI DQN0004A4215302/E,December2016.
- J4: inherited fuller dimension-derived GCT USB4110-GF-A replaces the simple illustrative shell at the same zero offset/rotation and unit scale. GCT drawingA,10July2019: nominal shell8.94mm wide,7.35mm deep,3.26mm above board. Contacts/stakes/insulator are simplified; no exact mating claim.

The inherited source model set was preserved under2026-10-21_FPGA_Work/19_Carrier_Four_Layer_Clean_Routing_V43/project/models/Complete3D/. Its original model construction review is2026-10-09_FPGA_Work/13_Carrier_Complete_3D_BRK_JTAG/verification/Model_Source_Review.md. Today's delivery contains source hashes, registration comparisons and dimensional receipts in model_mapping/.

Six previously system-library STEP dependencies are bundled unchanged under KiCad/. The model headers and KiCad_3D_License.md retain CC-BY-SA4.0 attribution and the library's design exception. Existing Hirose,Samtec,SameSky and other models keep their prior files and transforms. These local engineering files do not authorize public republication of supplier model assets.

All model paths are project-local or natively embedded; keep this project and its libraries/models folders together. The unassigned raw/staged assets are provenance copies; native PCB model assignments are authoritative. Model coverage and nominal alignment do not qualify toleranced mechanical fit,assembly or electrical/thermal performance.
