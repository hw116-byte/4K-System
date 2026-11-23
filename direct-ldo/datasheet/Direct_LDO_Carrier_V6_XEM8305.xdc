# Direct LDO Carrier V6 -> Opal Kelly XEM8305 (XCAU15P-2FFVB676E), Bank 64 at 1.5 V
# Made 23 Nov 2026 from the V6 netlist (J1/MC1, board edited 31 Oct 2026, 20:17 CST) and the Opal Kelly XEM8305 pin list
# (https://pins.opalkelly.com/pin_list/XEM8305). All 23 balls cross-checked.
# Do NOT use the older xem8305_asic_bank64_candidate.xdc (5 Oct 2026): 22 of its 23 balls are wrong for V6.
# Bank 64 VCCO is 1.5 V, made on the carrier by U2 (enabled by XEM8305_PG), so every pin is LVCMOS15.
# Outputs start at low drive and slow slew: the carrier lines are about 55 mm long and unterminated.
# Add the FrontPanel host-interface pins separately (Opal Kelly sample XDC or the Pins site generator).

# ---- ASIC -> FPGA (inputs) ----
set_property -dict {PACKAGE_PIN AF22 IOSTANDARD LVCMOS15} [get_ports asic_d1]   ;# D1, J1.4, MC1.85
set_property -dict {PACKAGE_PIN AE22 IOSTANDARD LVCMOS15} [get_ports asic_d2]   ;# D2, J1.6, MC1.83
set_property -dict {PACKAGE_PIN AE23 IOSTANDARD LVCMOS15} [get_ports asic_d3]   ;# D3, J1.8, MC1.81
set_property -dict {PACKAGE_PIN AD23 IOSTANDARD LVCMOS15} [get_ports asic_d4]   ;# D4, J1.10, MC1.79
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD LVCMOS15} [get_ports asic_sync]   ;# SYNC, J1.34, MC1.51
set_property -dict {PACKAGE_PIN AD21 IOSTANDARD LVCMOS15} [get_ports asic_clk32mhz]   ;# CLK32MHZ, J1.36, MC1.67
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD LVCMOS15} [get_ports asic_d5]   ;# D5, J1.38, MC1.47
set_property -dict {PACKAGE_PIN AC17 IOSTANDARD LVCMOS15} [get_ports asic_d6]   ;# D6, J1.40, MC1.45
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD LVCMOS15} [get_ports asic_d7]   ;# D7, J1.42, MC1.43
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD LVCMOS15} [get_ports asic_d8]   ;# D8, J1.44, MC1.41
set_property -dict {PACKAGE_PIN Y17  IOSTANDARD LVCMOS15} [get_ports asic_read]   ;# READ, J1.46, MC1.39

# ---- FPGA -> ASIC (outputs) ----
set_property -dict {PACKAGE_PIN AC23 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_clkh]   ;# CLKH, J1.12, MC1.77
set_property -dict {PACKAGE_PIN AC22 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_chip_reset]   ;# CHIP_RESET, J1.14, MC1.75
set_property -dict {PACKAGE_PIN AA22 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_imp_test]   ;# IMP_TEST, J1.18, MC1.71
set_property -dict {PACKAGE_PIN AE21 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_fe_reset]   ;# FE_RESET, J1.20, MC1.69
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_spi_clk]   ;# SPI_CLK, J1.22, MC1.49
set_property -dict {PACKAGE_PIN AC21 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_spi_latch]   ;# SPI_LATCH, J1.24, MC1.65
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_spi_dinl]   ;# SPI_DINL, J1.26, MC1.63
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_stim_start]   ;# STIM_START, J1.27, MC1.73
set_property -dict {PACKAGE_PIN Y21  IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_spi_dinr]   ;# SPI_DINR, J1.28, MC1.57
set_property -dict {PACKAGE_PIN Y20  IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_stim_clk]   ;# STIM_CLK, J1.29, MC1.55
set_property -dict {PACKAGE_PIN AB19 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_stim_en]   ;# STIM_EN, J1.31, MC1.53
set_property -dict {PACKAGE_PIN AA18 IOSTANDARD LVCMOS15 DRIVE 4 SLEW SLOW} [get_ports asic_stim_chb]   ;# STIM_CHB, J1.33, MC1.37

# Returned ASIC clock. 31.25 ns = 32 MHz. If CLKH is run at 16 MHz (as the 2026 bench firmware did), use 62.5.
create_clock -period 31.250 -name asic_clk32 [get_ports asic_clk32mhz]
# Input delays of D1-D8/READ/SYNC relative to asic_clk32 are not specified by any source yet; measure, then add
# set_input_delay constraints. Capture on the falling edge of asic_clk32 (see the datasheet, section 8).
