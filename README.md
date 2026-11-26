# 4K neural recording system

Current design files, datasheet and overview site for the 4K neural recording system.
This repository holds only the latest version of each board. The earlier site
(HowardWHSrun/FPGA_4K) is offline.

- **Website:** https://hw116-byte.github.io/4K-System/
- **Datasheet and user guide:** [datasheet/](https://hw116-byte.github.io/4K-System/datasheet/) (web) or [System_Datasheet_V1.pdf](System_Datasheet_V1.pdf)
- **Direct LDO carrier page:** [direct-ldo/](https://hw116-byte.github.io/4K-System/direct-ldo/)
- **Direct LDO carrier datasheet and programming guide** (XEM8305 pin map, XDC, power-up): [direct-ldo/datasheet/](https://hw116-byte.github.io/4K-System/direct-ldo/datasheet/) · [XDC](direct-ldo/datasheet/Direct_LDO_Carrier_V6_XEM8305.xdc)
- **Boards for fab review (schematic + PCB in the browser):** [fab-review/](https://hw116-byte.github.io/4K-System/fab-review/)
- **KiCad projects and fab files:** [boards/](boards/)
- **24 Nov 2026 overview update:** HDMI Extension Board V41 (male test pins, 12 V fan header), Option B router V3 + LDO board V3 (placement, routing in progress) on 4 of the 8 head stages, G-chip Direct LDO Carrier V6 and the new 4K Direct LDO Carrier V7 (layout placement), printable models set V5, weekly deck [2026-11-25-v9](presentation/meetings/2026-11-25-v9/)
- **25 Nov 2026 weekly deck V11:** adds test-pad slides: Frontend Plan A (V17, frame header) vs Plan B (V18, edge half holes), both with the new 4 × 3 mm flash; FPGA-LDO Plan A (V24) vs Plan B (V26). [Deck](presentation/meetings/2026-11-25-v11/).
- **25 Nov 2026 weekly deck V10:** Option B router V3 routed (layout V1, 6 layers, DRC 0), new schematics for router V3, LDO board V3 and 4K Direct LDO Carrier V7 (schematic V4); LDO board V3 and Carrier V7 routing in progress. [Deck](presentation/meetings/2026-11-25-v10/).

## Boards

**Review page: [Boards for fab review](https://hw116-byte.github.io/4K-System/fab-review/)** opens every board's native KiCad schematic
(all sheets) and PCB in the browser, with the parts list and every file.

`boards/` is a copy of the workspace's Final Versions folder (26 Nov 2026): the latest version of every board with its order files.
Its [START_HERE.md](boards/START_HERE.md) lists versions, order files and open points per board.

| Folder | Board | Version |
|---|---|---|
| [1_HDMI_Extension_Board_V42](boards/1_HDMI_Extension_Board_V42) | HDMI Extension Board | V42 · order_V4 |
| [2_Frontend_FPGA_Board_14_Layers_Plan_A_V19_Plan_B_V20](boards/2_Frontend_FPGA_Board_14_Layers_Plan_A_V19_Plan_B_V20) | Frontend FPGA Board, Test Pad Plan A and Plan B | 14 layers V19 + test frame V9 / V20 + frame V10 |
| [3_FPGA_LDO_Option_A_Plan_A_V24_Plan_B_V26](boards/3_FPGA_LDO_Option_A_Plan_A_V24_Plan_B_V26) | FPGA-LDO PCB Option A, Plan A and Plan B | layout V24 + test frame V4 / V26 + frame V6 |
| [4_ASIC_Boards_V15](boards/4_ASIC_Boards_V15) | ASIC top and bottom boards (PCBWay) | V15 |
| [5_Direct_LDO_Carrier_V6](boards/5_Direct_LDO_Carrier_V6) | G-chip Direct LDO Carrier (built) | V6 |
| [6_Option_B_Router_V3_and_LDO_Board_V3](boards/6_Option_B_Router_V3_and_LDO_Board_V3) | Option B router and LDO board (Plan A and Plan B) | router V3 layout V1 · LDO board V3 layout V6 |
| [7_4K_Direct_LDO_Carrier_V7_Layout_V9](boards/7_4K_Direct_LDO_Carrier_V7_Layout_V9) | 4K Direct LDO Carrier | V7 · layout V9 |
| [8_Frontend_Breakout_Board_V1](boards/8_Frontend_Breakout_Board_V1) | Frontend Breakout Board | V1 · order_V2 |

Each folder has the KiCad project, a schematic PDF, a KiCad ZIP and the
fab/assembly files (Gerbers, BOM, placement). Open the `.kicad_pro` file with
**KiCad 10**; libraries and 3D models are inside each project.

The fab-review pages read the files in `boards/` directly. The overview page's 3D views and card
downloads, the datasheet text and the design review were made against earlier revisions and were not
refreshed in this update.
