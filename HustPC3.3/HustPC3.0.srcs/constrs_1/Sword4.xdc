#Clock and reset
set_property -dict {PACKAGE_PIN AC18 IOSTANDARD LVDS} [get_ports clk_200mhz_p]
set_property -dict {IOSTANDARD LVDS} [get_ports clk_200mhz_n]
set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS18} [get_ports rst]

create_generated_clock -name clk14 -source [get_pins clkdiv/clk] -divide_by 16384 [get_pins clkdiv/clkdiv[14]]
create_generated_clock -name clk16 -source [get_pins clkdiv/clk] -divide_by 65536 [get_pins clkdiv/clkdiv[16]]
create_generated_clock -name clk25 -source [get_pins clkdiv/clk] -divide_by 33554432 [get_pins clkdiv/clkdiv[25]]

#Arduino board
set_property -dict {PACKAGE_PIN AA22 IOSTANDARD LVCMOS33} [get_ports {segment[7]}]
set_property -dict {PACKAGE_PIN AC23 IOSTANDARD LVCMOS33} [get_ports {segment[6]}]
set_property -dict {PACKAGE_PIN AC24 IOSTANDARD LVCMOS33} [get_ports {segment[5]}]
set_property -dict {PACKAGE_PIN W20  IOSTANDARD LVCMOS33} [get_ports {segment[4]}]
set_property -dict {PACKAGE_PIN Y21  IOSTANDARD LVCMOS33} [get_ports {segment[3]}]
set_property -dict {PACKAGE_PIN AD23 IOSTANDARD LVCMOS33} [get_ports {segment[2]}]
set_property -dict {PACKAGE_PIN AD24 IOSTANDARD LVCMOS33} [get_ports {segment[1]}]
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports {segment[0]}]

set_property -dict {PACKAGE_PIN AD21 IOSTANDARD LVCMOS33} [get_ports {addr[0]}]
set_property -dict {PACKAGE_PIN AC21 IOSTANDARD LVCMOS33} [get_ports {addr[1]}]
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports {addr[2]}]
set_property -dict {PACKAGE_PIN AC22 IOSTANDARD LVCMOS33} [get_ports {addr[3]}]

set_property -dict {PACKAGE_PIN AF24 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
set_property -dict {PACKAGE_PIN AE21 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN Y22  IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN Y23  IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN AA23 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN Y25  IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN AB26 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN W23  IOSTANDARD LVCMOS33} [get_ports {led[0]}]

#Button, switch, 7-seg, and LED
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_ROW[4]}]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_ROW[3]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_ROW[2]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_ROW[1]}]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_ROW[0]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_COL[3]}]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_COL[2]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_COL[1]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {K_COL[0]}]

#Single row Btn
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {bvcc}]

set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {button[4]}]
set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {button[3]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {button[2]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {button[1]}]
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS18 PULLUP true} [get_ports {button[0]}]

set_property -dict {PACKAGE_PIN AA10 IOSTANDARD LVCMOS15} [get_ports {switch[0]}]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS15} [get_ports {switch[1]}]
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS15} [get_ports {switch[2]}]
set_property -dict {PACKAGE_PIN AA12 IOSTANDARD LVCMOS15} [get_ports {switch[3]}]
set_property -dict {PACKAGE_PIN Y13  IOSTANDARD LVCMOS15} [get_ports {switch[4]}]
set_property -dict {PACKAGE_PIN Y12  IOSTANDARD LVCMOS15} [get_ports {switch[5]}]
set_property -dict {PACKAGE_PIN AD11 IOSTANDARD LVCMOS15} [get_ports {switch[6]}]
set_property -dict {PACKAGE_PIN AD10 IOSTANDARD LVCMOS15} [get_ports {switch[7]}]
set_property -dict {PACKAGE_PIN AE10 IOSTANDARD LVCMOS15} [get_ports {switch[8]}]
set_property -dict {PACKAGE_PIN AE12 IOSTANDARD LVCMOS15} [get_ports {switch[9]}]
set_property -dict {PACKAGE_PIN AF12 IOSTANDARD LVCMOS15} [get_ports {switch[10]}]
set_property -dict {PACKAGE_PIN AE8  IOSTANDARD LVCMOS15} [get_ports {switch[11]}]
set_property -dict {PACKAGE_PIN AF8  IOSTANDARD LVCMOS15} [get_ports {switch[12]}]
set_property -dict {PACKAGE_PIN AE13 IOSTANDARD LVCMOS15} [get_ports {switch[13]}]
set_property -dict {PACKAGE_PIN AF13 IOSTANDARD LVCMOS15} [get_ports {switch[14]}]
set_property -dict {PACKAGE_PIN AF10 IOSTANDARD LVCMOS15} [get_ports {switch[15]}]

set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS33} [get_ports seg_clk]
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS33} [get_ports seg_sout]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports seg_pen]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports seg_clrn]

set_property -dict {PACKAGE_PIN N26 IOSTANDARD LVCMOS33} [get_ports led_clk]
set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports led_dt]
set_property -dict {PACKAGE_PIN N24 IOSTANDARD LVCMOS33} [get_ports led_clr]
set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVCMOS33} [get_ports led_en]

#VGA
set_property -dict {PACKAGE_PIN N21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {r[0]}]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {r[1]}]
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {r[2]}]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {r[3]}]
set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {g[0]}]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {g[1]}]
set_property -dict {PACKAGE_PIN T24 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {g[2]}]
set_property -dict {PACKAGE_PIN T25 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {g[3]}]
set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {b[0]}]
set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {b[1]}]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {b[2]}]
set_property -dict {PACKAGE_PIN T23 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports {b[3]}]
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports vs]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS33 SLEW FAST} [get_ports hs]

# Serial Port

set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS33 PULLUP true} [get_ports uart_rx]
set_property -dict {PACKAGE_PIN P24 IOSTANDARD LVCMOS33 DRIVE 16 SLEW FAST PULLUP true} [get_ports uart_tx]

# PS/2

set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33 PULLUP true} [get_ports ps2_clk]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33 PULLUP true} [get_ports ps2_data]

#Allow
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells gpu0/out2/m9/sr/no1]]
set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets -of_objects [get_cells gpu0/out2/m9/sr/no2]]

set_property SEVERITY {Warning}  [get_drc_checks LUTLP-1]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]