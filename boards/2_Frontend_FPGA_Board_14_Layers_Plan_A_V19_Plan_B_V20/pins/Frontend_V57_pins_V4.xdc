# Pin constraints V4, Frontend FPGA XC7A35T-CSG325, schematic V57, board 14 layers V13, pin map V8 (written 19 Nov 2026, 11:35 CST).
# Made by build_pin_map_v8.py from pin file V3 (Frontend_V47_pins_V3.xdc, pin map V6 / V7). Two pin lines differ: D11 is BOARD1_SPI_LATCH (was SPI_LATCH_SHARED) and V14 is BOARD3_SPI_LATCH (was the commented spare). check_pin_map_v8.py compared every PACKAGE_PIN with the net on that U1 ball in the 14 layers V13 board file.
# NOT run in Vivado. Read with tclsh only (every line is valid Tcl). Pin map V8 was approved by Howard on 19 Nov 2026.
# Ball functions and banks: AMD xc7a35tcsg325pkg.txt, https://download.amd.com/adaptive-socs-and-fpgas/developer/adaptive-socs-and-fpgas/package-pinout-files/a7packages/xc7a35tcsg325pkg.txt
# Banks 14, 15 and 34 are fed by VCCO_1V5, so every ASIC line is LVCMOS15.

# ---- 1. Configuration (review item FE-14; schematic V47 note box "U1 configuration" and "U7/U8")
# CFGBVS is tied to GND on the board; bank 0 and the flash run at 1.8 V; bank 14 runs at 1.5 V through translator U8 (FE-35: Vivado has not been asked yet whether it accepts this mix).
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CONFIG_MODE SPIx1 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]
# 3 MHz is the value in the schematic note (and Vivado's default); boot then takes about 5.8 s. FE-14 worked out that 12 is still safe and 16 is not. Not tried on hardware.
set_property BITSTREAM.CONFIG.CONFIGRATE 3 [current_design]

# ---- 2. The 88 inputs from the ASICs (8 data, READ, SYNC and the returned 32 MHz clock per chip).
# PULLDOWN: the chip pads have no pull resistors (meeting of 12 Nov 2026, answer C2) and a missing or unpowered ASIC board would leave the inputs floating (SYS-77).
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_CLK32MHz_Out}]   ;# J2.59 IO_L13P_T2_MRCC_34, ASIC port J4.45
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA1}]   ;# J2.21 IO_L15P_T2_DQS_34, ASIC port J4.79
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA2}]   ;# J2.64 IO_L2N_T0_34, ASIC port J4.77
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA3}]   ;# J2.62 IO_L3P_T0_DQS_34, ASIC port J4.75
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA4}]   ;# J2.60 IO_L3N_T0_DQS_34, ASIC port J4.73
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA5}]   ;# J2.57 IO_L7N_T1_34, ASIC port J4.43
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA6}]   ;# J2.55 IO_L9P_T1_DQS_34, ASIC port J4.41
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA7}]   ;# J2.53 IO_L9N_T1_DQS_34, ASIC port J4.39
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_DATA8}]   ;# J2.51 IO_L5N_T0_34, ASIC port J4.37
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_READ}]   ;# J2.49 IO_L4N_T0_34, ASIC port J4.35
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC1_SYNC}]   ;# J2.61 IO_L2P_T0_34, ASIC port J4.47
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_CLK32MHz_Out}]   ;# J1.63 IO_L11P_T1_SRCC_15, ASIC port J4.19
set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA1}]   ;# J1.70 IO_L15N_T2_DQS_ADV_B_15, ASIC port J4.33
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA2}]   ;# J1.51 IO_L13P_T2_MRCC_15, ASIC port J4.31
set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA3}]   ;# J1.53 IO_L14N_T2_SRCC_15, ASIC port J4.29
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA4}]   ;# J1.55 IO_L13N_T2_MRCC_15, ASIC port J4.27
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA5}]   ;# J1.65 IO_L10P_T1_AD11P_15, ASIC port J4.17
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA6}]   ;# J1.67 IO_L10N_T1_AD11N_15, ASIC port J4.15
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA7}]   ;# J1.69 IO_L8N_T1_AD10N_15, ASIC port J4.13
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_DATA8}]   ;# J1.38 IO_L23P_T3_FOE_B_15, ASIC port J4.11
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_READ}]   ;# J1.40 IO_L23N_T3_FWE_B_15, ASIC port J4.9
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC2_SYNC}]   ;# J1.61 IO_L9N_T1_DQS_AD3N_15, ASIC port J4.21
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_CLK32MHz_Out}]   ;# J2.25 IO_L12P_T1_MRCC_34, ASIC port J4.62, lane swap on the Frontend: this contact was on ball R7
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA1}]   ;# J2.47 IO_L6P_T0_34, ASIC port J4.80
set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA2}]   ;# J2.45 IO_L8P_T1_34, ASIC port J4.78
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA3}]   ;# J2.43 IO_L11N_T1_SRCC_34, ASIC port J4.76
set_property -dict {PACKAGE_PIN N6 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA4}]   ;# J2.39 IO_L8N_T1_34, ASIC port J4.74
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA5}]   ;# J2.23 IO_L14N_T2_SRCC_34, ASIC port J4.60, V5 name on this wire: ASIC3_READ
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA6}]   ;# J2.42 IO_L2P_T0_AD8P_15, ASIC port J4.58, new wire
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA7}]   ;# J1.39 IO_L12N_T1_MRCC_15, ASIC port J4.32, new wire
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_DATA8}]   ;# J1.43 IO_L21P_T3_DQS_15, ASIC port J4.30, new wire
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_READ}]   ;# J1.45 IO_L22N_T3_A16_15, ASIC port J4.28, new wire
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC3_SYNC}]   ;# J2.29 IO_L17N_T2_34, ASIC port J4.64, V5 name on this wire: ASIC3_DATA7
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_CLK32MHz_Out}]   ;# J1.56 IO_L14P_T2_SRCC_15, ASIC port J4.12
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA1}]   ;# J1.47 IO_L21N_T3_DQS_A18_15, ASIC port J4.26, new wire
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA2}]   ;# J1.49 IO_L12P_T1_MRCC_15, ASIC port J4.24, new wire
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA3}]   ;# J1.44 IO_L19P_T3_A22_15, ASIC port J4.22, V5 name on this wire: ASIC4_DATA1
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA4}]   ;# J1.46 IO_L24P_T3_RS1_15, ASIC port J4.20, V5 name on this wire: ASIC4_DATA2
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA5}]   ;# J1.58 IO_L17N_T2_A25_15, ASIC port J4.10
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA6}]   ;# J1.60 IO_L18N_T2_A23_15, ASIC port J4.8
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA7}]   ;# J1.62 IO_L18P_T2_A24_15, ASIC port J4.6
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_DATA8}]   ;# J1.64 IO_L16N_T2_A27_15, ASIC port J4.4
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_READ}]   ;# J1.68 IO_L15P_T2_DQS_15, ASIC port J4.2
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC4_SYNC}]   ;# J1.54 IO_L17P_T2_A26_15, ASIC port J4.14
set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_CLK32MHz_Out}]   ;# J2.12 IO_L14P_T2_SRCC_34, ASIC port J3.45
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA1}]   ;# J2.5 IO_L18N_T2_34, ASIC port J3.79
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA2}]   ;# J2.7 IO_L15N_T2_DQS_34, ASIC port J3.77
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA3}]   ;# J2.9 IO_L18P_T2_34, ASIC port J3.75
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA4}]   ;# J2.11 IO_L20N_T3_34, ASIC port J3.73
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA5}]   ;# J2.10 IO_L21N_T3_DQS_34, ASIC port J3.43
set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA6}]   ;# J2.8 IO_L17P_T2_34, ASIC port J3.41
set_property -dict {PACKAGE_PIN U6 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA7}]   ;# J2.6 IO_L20P_T3_34, ASIC port J3.39
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_DATA8}]   ;# J2.4 IO_L23P_T3_34, ASIC port J3.37
set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_READ}]   ;# J2.2 IO_L16P_T2_34, ASIC port J3.35
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC5_SYNC}]   ;# J2.3 IO_L16N_T2_34, ASIC port J3.47
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_CLK32MHz_Out}]   ;# J1.16 IO_L14P_T2_SRCC_14, ASIC port J3.19
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA1}]   ;# J1.1 IO_L18P_T2_A12_D28_14, ASIC port J3.33
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA2}]   ;# J1.28 IO_L3N_T0_DQS_EMCCLK_14, ASIC port J3.31
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA3}]   ;# J1.26 IO_L4N_T0_D05_14, ASIC port J3.29
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA4}]   ;# J1.24 IO_L7N_T1_D10_14, ASIC port J3.27
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA5}]   ;# J1.12 IO_L15P_T2_DQS_RDWR_B_14, ASIC port J3.17
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA6}]   ;# J1.10 IO_L14N_T2_SRCC_14, ASIC port J3.15
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA7}]   ;# J1.8 IO_L15N_T2_DQS_DOUT_CSO_B_14, ASIC port J3.13
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_DATA8}]   ;# J1.6 IO_L16P_T2_CSI_B_14, ASIC port J3.11
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_READ}]   ;# J1.4 IO_L16N_T2_A15_D31_14, ASIC port J3.9
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC6_SYNC}]   ;# J1.18 IO_L10N_T1_D15_14, ASIC port J3.21
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_CLK32MHz_Out}]   ;# J2.36 IO_L11P_T1_SRCC_34, ASIC port J3.62, lane swap on the Frontend: this contact was on ball L4
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA1}]   ;# J2.16 IO_L13N_T2_MRCC_34, ASIC port J3.80
set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA2}]   ;# J2.18 IO_25_34, ASIC port J3.78
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA3}]   ;# J2.20 IO_L19N_T3_VREF_34, ASIC port J3.76
set_property -dict {PACKAGE_PIN P6 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA4}]   ;# J2.22 IO_L19P_T3_34, ASIC port J3.74
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA5}]   ;# J2.38 IO_L4P_T0_34, ASIC port J3.60, V5 name on this wire: ASIC7_READ
set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA6}]   ;# J2.40 IO_L24P_T3_A01_D17_14, ASIC port J3.58, new wire
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA7}]   ;# J1.37 IO_L20P_T3_A20_15, ASIC port J3.32, new wire
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_DATA8}]   ;# J1.35 IO_L21N_T3_DQS_A06_D22_14, ASIC port J3.30, new wire
set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_READ}]   ;# J1.33 IO_L22P_T3_A05_D21_14, ASIC port J3.28, new wire
set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC7_SYNC}]   ;# J2.32 IO_L6N_T0_VREF_34, ASIC port J3.64, V5 name on this wire: ASIC7_DATA7
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_CLK32MHz_Out}]   ;# J1.13 IO_L11P_T1_SRCC_14, ASIC port J3.12
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA1}]   ;# J1.31 IO_L22N_T3_A04_D20_14, ASIC port J3.26, new wire
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA2}]   ;# J1.29 IO_L4P_T0_D04_14, ASIC port J3.24, new wire
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA3}]   ;# J1.25 IO_L5N_T0_D07_14, ASIC port J3.22, V5 name on this wire: ASIC8_DATA1
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA4}]   ;# J1.23 IO_0_14, ASIC port J3.20, V5 name on this wire: ASIC8_DATA2
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA5}]   ;# J1.11 IO_L19P_T3_A10_D26_14, ASIC port J3.10
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA6}]   ;# J1.9 IO_L13N_T2_MRCC_14, ASIC port J3.8
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA7}]   ;# J1.7 IO_L20P_T3_A08_D24_14, ASIC port J3.6
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_DATA8}]   ;# J1.5 IO_L17N_T2_A13_D29_14, ASIC port J3.4
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_READ}]   ;# J1.3 IO_L17P_T2_A14_D30_14, ASIC port J3.2
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS15 PULLDOWN true} [get_ports {ASIC8_SYNC}]   ;# J1.17 IO_L11N_T1_SRCC_14, ASIC port J3.14

# ---- 3. The 33 outputs to the ASICs. DRIVE 8 and SLEW SLOW written out (SYS-51, LDOA-62). The edge rate was not checked in an IBIS run.
# New in V6: each top chip (ASIC3, 4, 7, 8) has its own SPI data pair, and each top board its own SPI clock and latch.
# The 10 k pull-downs for the four SPI latch lines are on FPGA-LDO A, not here (R26, R27 for the top boards; R18 for BOARD1_SPI_LATCH; R28, new in layout V24, for BOARD3_SPI_LATCH).
# New in V8: each bottom board has its own latch too. BOARD1_SPI_LATCH = ASIC1 + 2 (ball D11, was SPI_LATCH_SHARED), BOARD3_SPI_LATCH = ASIC5 + 6 (ball V14, was the spare).
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC3_4_TOP_SPI_CLK}]   ;# J2.37 IO_L12N_T1_MRCC_34, ASIC port J4.72, V5 name on this wire: ASIC3_SYNC
set_property -dict {PACKAGE_PIN R7 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC3_4_TOP_SPI_LATCH}]   ;# J2.35 IO_L22P_T3_34, ASIC port J4.70, lane swap on the Frontend: this contact was on ball P4
set_property -dict {PACKAGE_PIN R5 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC3_SPI_DL}]   ;# J2.33 IO_L21P_T3_DQS_34, ASIC port J4.68, V5 name on this wire: ASIC3_DATA5
set_property -dict {PACKAGE_PIN T7 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC3_SPI_DR}]   ;# J2.31 IO_L22N_T3_34, ASIC port J4.66, V5 name on this wire: ASIC3_DATA6
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC4_SPI_DL}]   ;# J1.48 IO_L19N_T3_A21_VREF_15, ASIC port J4.18, V5 name on this wire: ASIC4_DATA3
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC4_SPI_DR}]   ;# J1.52 IO_L24N_T3_RS0_15, ASIC port J4.16, V5 name on this wire: ASIC4_DATA4
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC7_8_TOP_SPI_CLK}]   ;# J2.24 IO_L10N_T1_34, ASIC port J3.72, V5 name on this wire: ASIC7_SYNC
set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC7_8_TOP_SPI_LATCH}]   ;# J2.26 IO_L5P_T0_34, ASIC port J3.70, lane swap on the Frontend: this contact was on ball N3
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC7_SPI_DL}]   ;# J2.28 IO_L10P_T1_34, ASIC port J3.68, V5 name on this wire: ASIC7_DATA5
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC7_SPI_DR}]   ;# J2.30 IO_L7P_T1_34, ASIC port J3.66, V5 name on this wire: ASIC7_DATA6
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC8_SPI_DL}]   ;# J1.21 IO_L7P_T1_D09_14, ASIC port J3.18, V5 name on this wire: ASIC8_DATA3
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {ASIC8_SPI_DR}]   ;# J1.19 IO_L9P_T1_DQS_14, ASIC port J3.16, V5 name on this wire: ASIC8_DATA4
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD1_CLK}]   ;# J1.42 IO_L20N_T3_A19_15, ASIC port J4.7
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD1_SPI_CLK}]   ;# J2.52 IO_0_15, ASIC port J4.63
set_property -dict {PACKAGE_PIN D11 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD1_SPI_LATCH}]   ;# J2.48 IO_L6P_T0_15, ASIC port J4.61, V7 name on this wire: SPI_LATCH_SHARED (then also J3.61)
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD3_CLK}]   ;# J1.2 IO_L18N_T2_A11_D27_14, ASIC port J3.7
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD3_SPI_CLK}]   ;# J2.13 IO_L24P_T3_34, ASIC port J3.63
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {BOARD3_SPI_LATCH}]   ;# J1.36 IO_L20N_T3_A07_D23_14, ASIC port J3.61, V7 name on this wire: SPARE_J1_36 (the spare)
set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {CHIP_RESET_SHARED}]   ;# J2.58 IO_L2N_T0_AD8N_15, ASIC port J3.71+J4.71
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {FE_RESET_SHARED}]   ;# J2.54 IO_L1P_T0_AD0P_15, ASIC port J3.65+J4.65
set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {IMP_TST_SHARED}]   ;# J2.56 IO_L1N_T0_AD0N_15, ASIC port J3.67+J4.67
set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHB_SHARED}]   ;# J2.1 IO_L24N_T3_A00_D16_14, ASIC port J3.49+J4.49
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP1_SPI_DL}]   ;# J2.46 IO_L4P_T0_15, ASIC port J4.59
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP1_SPI_DR}]   ;# J2.44 IO_L22P_T3_A17_15, ASIC port J4.57
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP2_SPI_DL}]   ;# J1.57 IO_L9P_T1_DQS_AD3P_15, ASIC port J4.25
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP2_SPI_DR}]   ;# J1.59 IO_L16P_T2_A28_15, ASIC port J4.23
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP3_SPI_DL}]   ;# J2.17 IO_L24N_T3_34, ASIC port J3.59
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP3_SPI_DR}]   ;# J2.19 IO_L23N_T3_34, ASIC port J3.57
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP4_SPI_DL}]   ;# J1.22 IO_L9N_T1_DQS_D13_14, ASIC port J3.25
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CHIP4_SPI_DR}]   ;# J1.20 IO_L10P_T1_D14_14, ASIC port J3.23
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_CLK_SHARED}]   ;# J2.65 IO_L4N_T0_15, ASIC port J3.53+J4.53
set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_EN_SHARED}]   ;# J2.63 IO_0_34, ASIC port J3.51+J4.51
set_property -dict {PACKAGE_PIN B10 IOSTANDARD LVCMOS15 DRIVE 8 SLEW SLOW} [get_ports {STIM_START_SHARED}]   ;# J2.67 IO_L5P_T0_AD9P_15, ASIC port J3.55+J4.55

# ---- 4. No spare contact is left: J1.36 / ball V14 is BOARD3_SPI_LATCH from pin map V8 (section 3).

# ---- 5. Board clock, cable pairs and GT power enable (unchanged from pin file V2)
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS15} [get_ports {CLK25_PL}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_CLK_P}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_CLK_N}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_CMDSYNC_P}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_CMDSYNC_N}]
set_property -dict {PACKAGE_PIN B9 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_SYNC_P}]
set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVDS_25 DIFF_TERM FALSE} [get_ports {CABLE_SYNC_N}]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS15} [get_ports {EN_GTPWR_1V5}]
# M15 turns on the GT supply. It MUST be driven high in every image. Driven low, the FPGA resets itself and can reboot in a loop (FE-08).
# In an image without this port Vivado's default pull-down fights R58: set BITSTREAM.CONFIG.UNUSEDPIN PULLNONE there (FE-46).

# ---- 6. Transceiver (GTP, quad 216). Locations as wired on the board (FE-14).
set_property PACKAGE_PIN H2 [get_ports {GTP_TX0_P}]   ;# MGTPTXP0_216
set_property PACKAGE_PIN H1 [get_ports {GTP_TX0_N}]   ;# MGTPTXN0_216
set_property PACKAGE_PIN B6 [get_ports {GTP_REFCLK1_P}]   ;# MGTREFCLK1P_216, 125 MHz from Y1
set_property PACKAGE_PIN B5 [get_ports {GTP_REFCLK1_N}]   ;# MGTREFCLK1N_216
# The recording pair is swapped P/N at J3 on purpose (schematic V42 note). Set TXPOLARITY = 1 in the Frontend GT setup (wizard or HDL, not here)
# and RXPOLARITY = 0 on the XEM side (FE-20, SYS-42). Do not invert at both ends.

# ---- 7. Clocks
# Returned 32 MHz clocks, one per chip (31.25 ns). Each is on the P side of a clock-capable pair (MRCC or SRCC).
create_clock -name ASIC8_clk32 -period 31.250 [get_ports {ASIC8_CLK32MHz_Out}]   ;# P15 IO_L11P_T1_SRCC_14, bank 14, J1.13
create_clock -name ASIC6_clk32 -period 31.250 [get_ports {ASIC6_CLK32MHz_Out}]   ;# R16 IO_L14P_T2_SRCC_14, bank 14, J1.16
create_clock -name ASIC4_clk32 -period 31.250 [get_ports {ASIC4_CLK32MHz_Out}]   ;# E16 IO_L14P_T2_SRCC_15, bank 15, J1.56
create_clock -name ASIC2_clk32 -period 31.250 [get_ports {ASIC2_CLK32MHz_Out}]   ;# D13 IO_L11P_T1_SRCC_15, bank 15, J1.63
create_clock -name ASIC5_clk32 -period 31.250 [get_ports {ASIC5_CLK32MHz_Out}]   ;# R3 IO_L14P_T2_SRCC_34, bank 34, J2.12
create_clock -name ASIC3_clk32 -period 31.250 [get_ports {ASIC3_CLK32MHz_Out}]   ;# P4 IO_L12P_T1_MRCC_34, bank 34, J2.25
create_clock -name ASIC7_clk32 -period 31.250 [get_ports {ASIC7_CLK32MHz_Out}]   ;# N3 IO_L11P_T1_SRCC_34, bank 34, J2.36
create_clock -name ASIC1_clk32 -period 31.250 [get_ports {ASIC1_CLK32MHz_Out}]   ;# R2 IO_L13P_T2_MRCC_34, bank 34, J2.59
create_clock -name clk25 -period 40.000 [get_ports {CLK25_PL}]   ;# T14 IO_L13P_T2_MRCC_14, 25 MHz from Y2
create_clock -name cable_clk32 -period 31.250 [get_ports {CABLE_CLK_P}]   ;# P14 IO_L12P_T1_MRCC_14, LVDS 32 MHz from the cable (HDMI pins 6/8)
create_clock -name gtp_refclk -period 8.000 [get_ports {GTP_REFCLK1_P}]   ;# B6, 125 MHz
# How these clocks relate to each other (set_clock_groups) is a firmware decision and is not set here.

# Capture groups. Six chips have all 11 inputs in the bank of their own returned clock:
#   ASIC1: clock in bank 34, 11 of 11 inputs in that bank
#   ASIC2: clock in bank 15, 11 of 11 inputs in that bank
#   ASIC3: clock in bank 34, 7 of 11 inputs in that bank; elsewhere: bank 15: ASIC3_DATA6, ASIC3_DATA7, ASIC3_DATA8, ASIC3_READ
#   ASIC4: clock in bank 15, 11 of 11 inputs in that bank
#   ASIC5: clock in bank 34, 11 of 11 inputs in that bank
#   ASIC6: clock in bank 14, 11 of 11 inputs in that bank
#   ASIC7: clock in bank 34, 7 of 11 inputs in that bank; elsewhere: bank 14: ASIC7_DATA6, ASIC7_DATA8, ASIC7_READ; bank 15: ASIC7_DATA7
#   ASIC8: clock in bank 14, 11 of 11 inputs in that bank
# ASIC3 and ASIC7 therefore cannot use a clock buffer that serves one bank only (BUFIO / BUFR). Capture all 11 inputs of each on a global
# buffer (BUFG, or an MMCM) fed from P4 / N3 and close timing in Vivado (SYS-64, SYS-73). No copper change is needed for that.
# Have firmware check each returned clock's frequency before using that chip's data (SYS-77).
#
# Input delays. The ASIC data timing (bit order, READ and SYNC against the returned clock) is still open with the ASIC designer, so no number can be
# written honestly. The lines below show the form; put the real values in and take the "#" away. Board delay ball to contact is 0 to 0.15 ns
# (lane lengths 0 to 21.5 mm at about 6.9 ps/mm), the same order as the unknowns.
# set_input_delay -clock ASIC1_clk32 -max <ns> [get_ports {ASIC1_DATA* ASIC1_READ ASIC1_SYNC}] ; set_input_delay -clock ASIC1_clk32 -min <ns> [get_ports {ASIC1_DATA* ASIC1_READ ASIC1_SYNC}]
# set_input_delay -clock ASIC2_clk32 -max <ns> [get_ports {ASIC2_DATA* ASIC2_READ ASIC2_SYNC}] ; set_input_delay -clock ASIC2_clk32 -min <ns> [get_ports {ASIC2_DATA* ASIC2_READ ASIC2_SYNC}]
# set_input_delay -clock ASIC3_clk32 -max <ns> [get_ports {ASIC3_DATA* ASIC3_READ ASIC3_SYNC}] ; set_input_delay -clock ASIC3_clk32 -min <ns> [get_ports {ASIC3_DATA* ASIC3_READ ASIC3_SYNC}]
# set_input_delay -clock ASIC4_clk32 -max <ns> [get_ports {ASIC4_DATA* ASIC4_READ ASIC4_SYNC}] ; set_input_delay -clock ASIC4_clk32 -min <ns> [get_ports {ASIC4_DATA* ASIC4_READ ASIC4_SYNC}]
# set_input_delay -clock ASIC5_clk32 -max <ns> [get_ports {ASIC5_DATA* ASIC5_READ ASIC5_SYNC}] ; set_input_delay -clock ASIC5_clk32 -min <ns> [get_ports {ASIC5_DATA* ASIC5_READ ASIC5_SYNC}]
# set_input_delay -clock ASIC6_clk32 -max <ns> [get_ports {ASIC6_DATA* ASIC6_READ ASIC6_SYNC}] ; set_input_delay -clock ASIC6_clk32 -min <ns> [get_ports {ASIC6_DATA* ASIC6_READ ASIC6_SYNC}]
# set_input_delay -clock ASIC7_clk32 -max <ns> [get_ports {ASIC7_DATA* ASIC7_READ ASIC7_SYNC}] ; set_input_delay -clock ASIC7_clk32 -min <ns> [get_ports {ASIC7_DATA* ASIC7_READ ASIC7_SYNC}]
# set_input_delay -clock ASIC8_clk32 -max <ns> [get_ports {ASIC8_DATA* ASIC8_READ ASIC8_SYNC}] ; set_input_delay -clock ASIC8_clk32 -min <ns> [get_ports {ASIC8_DATA* ASIC8_READ ASIC8_SYNC}]

# ---- 8. Firmware map for pin map V8 (replaces the map in review item R2S-09). Read from pin_map_v8.json; one line per ASIC port pin that reaches the FPGA.
# Port J4 of FPGA-LDO A carries ASIC1 to ASIC4, port J3 carries ASIC5 to ASIC8. Bottom chips: ASIC1, 2, 5, 6. Top chips: ASIC3, 4, 7, 8.
# CLKH: BOARD1_CLK drives ASIC1 to 4, BOARD3_CLK drives ASIC5 to 8 (two lines per head).
# Bottom chips: SPI data STIM_CHIP1 = ASIC1, STIM_CHIP2 = ASIC2, STIM_CHIP3 = ASIC5, STIM_CHIP4 = ASIC6 (stream number and chip number differ for 3 and 4);
#   SPI clock BOARD1_SPI_CLK = ASIC1 + 2, BOARD3_SPI_CLK = ASIC5 + 6; latch BOARD1_SPI_LATCH = ASIC1 + 2, BOARD3_SPI_LATCH = ASIC5 + 6 (V8: one latch per ASIC board).
# Top chips: SPI data ASICn_SPI_DL / DR per chip; clock and latch ASIC3_4_TOP_SPI_CLK / LATCH and ASIC7_8_TOP_SPI_CLK / LATCH.
# DISC_OUT is not connected. Data bit order and timing are still open with the ASIC designer.
#   port.pin  pin name on the ASIC board   chip(s)                   signal                      dir  contact  ball  bank
#   J3.2      T_READ(2)                    ASIC8                     ASIC8_READ                  in   J1.3     U15   14
#   J3.4      T_D<8>(2)                    ASIC8                     ASIC8_DATA8                 in   J1.5     U16   14
#   J3.6      T_D<7>(2)                    ASIC8                     ASIC8_DATA7                 in   J1.7     U14   14
#   J3.7      CLKH                         ASIC5 ASIC6 ASIC7 ASIC8   BOARD3_CLK                  out  J1.2     V17   14
#   J3.8      T_D<6>(2)                    ASIC8                     ASIC8_DATA6                 in   J1.9     T15   14
#   J3.9      READ(2)                      ASIC6                     ASIC6_READ                  in   J1.4     U17   14
#   J3.10     T_D<5>(2)                    ASIC8                     ASIC8_DATA5                 in   J1.11    R13   14
#   J3.11     D<8>(2)                      ASIC6                     ASIC6_DATA8                 in   J1.6     T17   14
#   J3.12     T_CLK32MHZ(2)                ASIC8                     ASIC8_CLK32MHz_Out          in   J1.13    P15   14
#   J3.13     D<7>(2)                      ASIC6                     ASIC6_DATA7                 in   J1.8     T18   14
#   J3.14     T_SYNC(2)                    ASIC8                     ASIC8_SYNC                  in   J1.17    P16   14
#   J3.15     D<6>(2)                      ASIC6                     ASIC6_DATA6                 in   J1.10    R17   14
#   J3.16     T_SPI_DINR(2)                ASIC8                     ASIC8_SPI_DR                out  J1.19    N16   14
#   J3.17     D<5>(2)                      ASIC6                     ASIC6_DATA5                 in   J1.12    R18   14
#   J3.18     T_SPI_DINL(2)                ASIC8                     ASIC8_SPI_DL                out  J1.21    M16   14
#   J3.19     CLK32MHZ(2)                  ASIC6                     ASIC6_CLK32MHz_Out          in   J1.16    R16   14
#   J3.20     T_D<4>(2)                    ASIC8                     ASIC8_DATA4                 in   J1.23    L14   14
#   J3.21     SYNC(2)                      ASIC6                     ASIC6_SYNC                  in   J1.18    P18   14
#   J3.22     T_D<3>(2)                    ASIC8                     ASIC8_DATA3                 in   J1.25    K15   14
#   J3.23     SPI_DINR(2)                  ASIC6                     STIM_CHIP4_SPI_DR           out  J1.20    N18   14
#   J3.24     T_D<2>(2)                    ASIC8                     ASIC8_DATA2                 in   J1.29    K17   14
#   J3.25     SPI_DINL(2)                  ASIC6                     STIM_CHIP4_SPI_DL           out  J1.22    N17   14
#   J3.26     T_D<1>(2)                    ASIC8                     ASIC8_DATA1                 in   J1.31    U12   14
#   J3.27     D<4>(2)                      ASIC6                     ASIC6_DATA4                 in   J1.24    M17   14
#   J3.28     T_READ                       ASIC7                     ASIC7_READ                  in   J1.33    T12   14
#   J3.29     D<3>(2)                      ASIC6                     ASIC6_DATA3                 in   J1.26    L18   14
#   J3.30     T_D<8>                       ASIC7                     ASIC7_DATA8                 in   J1.35    V13   14
#   J3.31     D<2>(2)                      ASIC6                     ASIC6_DATA2                 in   J1.28    K18   14
#   J3.32     T_D<7>                       ASIC7                     ASIC7_DATA7                 in   J1.37    H16   15
#   J3.33     D<1>(2)                      ASIC6                     ASIC6_DATA1                 in   J1.1     V16   14
#   J3.35     READ                         ASIC5                     ASIC5_READ                  in   J2.2     V3    34
#   J3.37     D<8>                         ASIC5                     ASIC5_DATA8                 in   J2.4     U7    34
#   J3.39     D<7>                         ASIC5                     ASIC5_DATA7                 in   J2.6     U6    34
#   J3.41     D<6>                         ASIC5                     ASIC5_DATA6                 in   J2.8     T4    34
#   J3.43     D<5>                         ASIC5                     ASIC5_DATA5                 in   J2.10    T5    34
#   J3.45     CLK32MHZ                     ASIC5                     ASIC5_CLK32MHz_Out          in   J2.12    R3    34
#   J3.47     SYNC                         ASIC5                     ASIC5_SYNC                  in   J2.3     V2    34
#   J3.49     STIM_CHB                     ASIC5 ASIC6 ASIC7 ASIC8   STIM_CHB_SHARED             out  J2.1     V9    14
#   J3.51     STIM_EN                      ASIC5 ASIC6 ASIC7 ASIC8   STIM_EN_SHARED              out  J2.63    J6    34
#   J3.53     STIM_CLK                     ASIC5 ASIC6 ASIC7 ASIC8   STIM_CLK_SHARED             out  J2.65    B11   15
#   J3.55     STIM_START                   ASIC5 ASIC6 ASIC7 ASIC8   STIM_START_SHARED           out  J2.67    B10   15
#   J3.57     SPI_DINR                     ASIC5                     STIM_CHIP3_SPI_DR           out  J2.19    V6    34
#   J3.58     T_D<6>                       ASIC7                     ASIC7_DATA6                 in   J2.40    U9    14
#   J3.59     SPI_DINL                     ASIC5                     STIM_CHIP3_SPI_DL           out  J2.17    V7    34
#   J3.60     T_D<5>                       ASIC7                     ASIC7_DATA5                 in   J2.38    K3    34
#   J3.61     SPI_LATCH                    ASIC5 ASIC6               BOARD3_SPI_LATCH            out  J1.36    V14   14
#   J3.62     T_CLK32MHZ                   ASIC7                     ASIC7_CLK32MHz_Out          in   J2.36    N3    34
#   J3.63     SPI_CLK                      ASIC5 ASIC6               BOARD3_SPI_CLK              out  J2.13    V8    34
#   J3.64     T_SYNC                       ASIC7                     ASIC7_SYNC                  in   J2.32    M5    34
#   J3.65     FE_RESET                     ASIC5 ASIC6 ASIC7 ASIC8   FE_RESET_SHARED             out  J2.54    D8    15
#   J3.66     T_SPI_DINR                   ASIC7                     ASIC7_SPI_DR                out  J2.30    M2    34
#   J3.67     IMP_TEST                     ASIC5 ASIC6 ASIC7 ASIC8   IMP_TST_SHARED              out  J2.56    C8    15
#   J3.68     T_SPI_DINL                   ASIC7                     ASIC7_SPI_DL                out  J2.28    M4    34
#   J3.70     T_SPI_LATCH                  ASIC7 ASIC8               ASIC7_8_TOP_SPI_LATCH       out  J2.26    L4    34
#   J3.71     CHIP_RESET                   ASIC5 ASIC6 ASIC7 ASIC8   CHIP_RESET_SHARED           out  J2.58    C9    15
#   J3.72     T_SPI_CLK                    ASIC7 ASIC8               ASIC7_8_TOP_SPI_CLK         out  J2.24    N4    34
#   J3.73     D<4>                         ASIC5                     ASIC5_DATA4                 in   J2.11    U5    34
#   J3.74     T_D<4>                       ASIC7                     ASIC7_DATA4                 in   J2.22    P6    34
#   J3.75     D<3>                         ASIC5                     ASIC5_DATA3                 in   J2.9     U4    34
#   J3.76     T_D<3>                       ASIC7                     ASIC7_DATA3                 in   J2.20    P5    34
#   J3.77     D<2>                         ASIC5                     ASIC5_DATA2                 in   J2.7     U1    34
#   J3.78     T_D<2>                       ASIC7                     ASIC7_DATA2                 in   J2.18    R6    34
#   J3.79     D<1>                         ASIC5                     ASIC5_DATA1                 in   J2.5     V4    34
#   J3.80     T_D<1>                       ASIC7                     ASIC7_DATA1                 in   J2.16    R1    34
#   J4.2      T_READ(2)                    ASIC4                     ASIC4_READ                  in   J1.68    B16   15
#   J4.4      T_D<8>(2)                    ASIC4                     ASIC4_DATA8                 in   J1.64    B17   15
#   J4.6      T_D<7>(2)                    ASIC4                     ASIC4_DATA7                 in   J1.62    C17   15
#   J4.7      CLKH                         ASIC1 ASIC2 ASIC3 ASIC4   BOARD1_CLK                  out  J1.42    G16   15
#   J4.8      T_D<6>(2)                    ASIC4                     ASIC4_DATA6                 in   J1.60    C18   15
#   J4.9      READ(2)                      ASIC2                     ASIC2_READ                  in   J1.40    H18   15
#   J4.10     T_D<5>(2)                    ASIC4                     ASIC4_DATA5                 in   J1.58    D18   15
#   J4.11     D<8>(2)                      ASIC2                     ASIC2_DATA8                 in   J1.38    H17   15
#   J4.12     T_CLK32MHZ(2)                ASIC4                     ASIC4_CLK32MHz_Out          in   J1.56    E16   15
#   J4.13     D<7>(2)                      ASIC2                     ASIC2_DATA7                 in   J1.69    A14   15
#   J4.14     T_SYNC(2)                    ASIC4                     ASIC4_SYNC                  in   J1.54    E17   15
#   J4.15     D<6>(2)                      ASIC2                     ASIC2_DATA6                 in   J1.67    A15   15
#   J4.16     T_SPI_DINR(2)                ASIC4                     ASIC4_SPI_DR                out  J1.52    E18   15
#   J4.17     D<5>(2)                      ASIC2                     ASIC2_DATA5                 in   J1.65    B14   15
#   J4.18     T_SPI_DINL(2)                ASIC4                     ASIC4_SPI_DL                out  J1.48    F18   15
#   J4.19     CLK32MHZ(2)                  ASIC2                     ASIC2_CLK32MHz_Out          in   J1.63    D13   15
#   J4.20     T_D<4>(2)                    ASIC4                     ASIC4_DATA4                 in   J1.46    F17   15
#   J4.21     SYNC(2)                      ASIC2                     ASIC2_SYNC                  in   J1.61    B15   15
#   J4.22     T_D<3>(2)                    ASIC4                     ASIC4_DATA3                 in   J1.44    G17   15
#   J4.23     SPI_DINR(2)                  ASIC2                     STIM_CHIP2_SPI_DR           out  J1.59    C16   15
#   J4.24     T_D<2>(2)                    ASIC4                     ASIC4_DATA2                 in   J1.49    E13   15
#   J4.25     SPI_DINL(2)                  ASIC2                     STIM_CHIP2_SPI_DL           out  J1.57    C14   15
#   J4.26     T_D<1>(2)                    ASIC4                     ASIC4_DATA1                 in   J1.47    F15   15
#   J4.27     D<4>(2)                      ASIC2                     ASIC2_DATA4                 in   J1.55    D15   15
#   J4.28     T_READ                       ASIC3                     ASIC3_READ                  in   J1.45    F14   15
#   J4.29     D<3>(2)                      ASIC2                     ASIC2_DATA3                 in   J1.53    D16   15
#   J4.30     T_D<8>                       ASIC3                     ASIC3_DATA8                 in   J1.43    G15   15
#   J4.31     D<2>(2)                      ASIC2                     ASIC2_DATA2                 in   J1.51    E15   15
#   J4.32     T_D<7>                       ASIC3                     ASIC3_DATA7                 in   J1.39    D14   15
#   J4.33     D<1>(2)                      ASIC2                     ASIC2_DATA1                 in   J1.70    A17   15
#   J4.35     READ                         ASIC1                     ASIC1_READ                  in   J2.49    L2    34
#   J4.37     D<8>                         ASIC1                     ASIC1_DATA8                 in   J2.51    L3    34
#   J4.39     D<7>                         ASIC1                     ASIC1_DATA7                 in   J2.53    P1    34
#   J4.41     D<6>                         ASIC1                     ASIC1_DATA6                 in   J2.55    N1    34
#   J4.43     D<5>                         ASIC1                     ASIC1_DATA5                 in   J2.57    M1    34
#   J4.45     CLK32MHZ                     ASIC1                     ASIC1_CLK32MHz_Out          in   J2.59    R2    34
#   J4.47     SYNC                         ASIC1                     ASIC1_SYNC                  in   J2.61    J5    34
#   J4.49     STIM_CHB                     ASIC1 ASIC2 ASIC3 ASIC4   STIM_CHB_SHARED             out  J2.1     V9    14
#   J4.51     STIM_EN                      ASIC1 ASIC2 ASIC3 ASIC4   STIM_EN_SHARED              out  J2.63    J6    34
#   J4.53     STIM_CLK                     ASIC1 ASIC2 ASIC3 ASIC4   STIM_CLK_SHARED             out  J2.65    B11   15
#   J4.55     STIM_START                   ASIC1 ASIC2 ASIC3 ASIC4   STIM_START_SHARED           out  J2.67    B10   15
#   J4.57     SPI_DINR                     ASIC1                     STIM_CHIP1_SPI_DR           out  J2.44    G14   15
#   J4.58     T_D<6>                       ASIC3                     ASIC3_DATA6                 in   J2.42    D9    15
#   J4.59     SPI_DINL                     ASIC1                     STIM_CHIP1_SPI_DL           out  J2.46    C11   15
#   J4.60     T_D<5>                       ASIC3                     ASIC3_DATA5                 in   J2.23    T2    34
#   J4.61     SPI_LATCH                    ASIC1 ASIC2               BOARD1_SPI_LATCH            out  J2.48    D11   15
#   J4.62     T_CLK32MHZ                   ASIC3                     ASIC3_CLK32MHz_Out          in   J2.25    P4    34
#   J4.63     SPI_CLK                      ASIC1 ASIC2               BOARD1_SPI_CLK              out  J2.52    D10   15
#   J4.64     T_SYNC                       ASIC3                     ASIC3_SYNC                  in   J2.29    T3    34
#   J4.65     FE_RESET                     ASIC1 ASIC2 ASIC3 ASIC4   FE_RESET_SHARED             out  J2.54    D8    15
#   J4.66     T_SPI_DINR                   ASIC3                     ASIC3_SPI_DR                out  J2.31    T7    34
#   J4.67     IMP_TEST                     ASIC1 ASIC2 ASIC3 ASIC4   IMP_TST_SHARED              out  J2.56    C8    15
#   J4.68     T_SPI_DINL                   ASIC3                     ASIC3_SPI_DL                out  J2.33    R5    34
#   J4.70     T_SPI_LATCH                  ASIC3 ASIC4               ASIC3_4_TOP_SPI_LATCH       out  J2.35    R7    34
#   J4.71     CHIP_RESET                   ASIC1 ASIC2 ASIC3 ASIC4   CHIP_RESET_SHARED           out  J2.58    C9    15
#   J4.72     T_SPI_CLK                    ASIC3 ASIC4               ASIC3_4_TOP_SPI_CLK         out  J2.37    P3    34
#   J4.73     D<4>                         ASIC1                     ASIC1_DATA4                 in   J2.60    K1    34
#   J4.74     T_D<4>                       ASIC3                     ASIC3_DATA4                 in   J2.39    N6    34
#   J4.75     D<3>                         ASIC1                     ASIC1_DATA3                 in   J2.62    K2    34
#   J4.76     T_D<3>                       ASIC3                     ASIC3_DATA3                 in   J2.43    N2    34
#   J4.77     D<2>                         ASIC1                     ASIC1_DATA2                 in   J2.64    J4    34
#   J4.78     T_D<2>                       ASIC3                     ASIC3_DATA2                 in   J2.45    M6    34
#   J4.79     D<1>                         ASIC1                     ASIC1_DATA1                 in   J2.21    U2    34
#   J4.80     T_D<1>                       ASIC3                     ASIC3_DATA1                 in   J2.47    L5    34

# Not constrained here (dedicated or configuration balls): JTAG (F8, R8, T8, T9), PROGRAM_B P10, INIT_B T10, DONE F12, CCLK E8, PUDC_B J18,
# flash DQ0 K16 / DQ1 L17 / CS L15, MGTRREF A6. Free user balls after V6: J14, H14, K5, K6 (no legal via position), J15, J16 (flash D02 / D03),
# T13, U10, U11, V11, V12, A10, A12, A13, B12, C12, C13.
