# 4K neural recording system

Current design files, datasheet and overview site for the 4K neural recording system.
This repository holds only the latest version of each board. The earlier site
(HowardWHSrun/FPGA_4K) is offline.

- **Website:** https://hw116-byte.github.io/4K-System/
- **Datasheet and user guide:** [datasheet/](https://hw116-byte.github.io/4K-System/datasheet/) (web) or [System_Datasheet_V1.pdf](System_Datasheet_V1.pdf)
- **Direct LDO carrier page:** [direct-ldo/](https://hw116-byte.github.io/4K-System/direct-ldo/)
- **KiCad projects and fab files:** [boards/](boards/)

## Boards

| Folder | Board | Version | Last edit |
|---|---|---|---|
| [1_HDMI_Extension_Board_V40](boards/1_HDMI_Extension_Board_V40) | HDMI Extension Board (PC side, carries the XEM8310, eight Micro-HDMI ports) | V40 | 20 Nov 2026, 16:13 CST |
| [2_Frontend_FPGA_Board_14_Layers_V14_Test_Frame_V4](boards/2_Frontend_FPGA_Board_14_Layers_V14_Test_Frame_V4) | Frontend FPGA board (head, Artix-7), with its test frame | 14 layers V14, schematic V58, test frame V4 | 20 Nov 2026, 16:26 CST |
| [3_FPGA_LDO_Option_A_Layout_V24_Test_Frame_V4](boards/3_FPGA_LDO_Option_A_Layout_V24_Test_Frame_V4) | FPGA-LDO board (head base, ASIC supplies), with its test frame | layout V24, schematic V43, test frame V4 | 19 Nov 2026, 11:46 CST |
| [4_ASIC_Boards_V15](boards/4_ASIC_Boards_V15) | ASIC top and bottom boards (two chips each) | V15 | 19 Nov 2026, 07:44 CST |
| [5_Direct_LDO_Carrier_V6](boards/5_Direct_LDO_Carrier_V6) | Direct LDO carrier for the XEM8305 (bench board, built) | V6 | 31 Oct 2026, 20:17 CST |

Each folder has the KiCad project, a schematic PDF, a KiCad ZIP and the
fab/assembly files (Gerbers, BOM, placement). Open the `.kicad_pro` file with
**KiCad 10**; libraries and 3D models are inside each project.

The website's board viewers still show the 19 Nov layouts (Frontend V13, HDMI V39).
The KiCad files in `boards/` are the newer Frontend V14 and HDMI V40 (part swaps only).
