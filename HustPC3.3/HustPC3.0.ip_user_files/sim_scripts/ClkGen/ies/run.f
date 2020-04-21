-makelib ies_lib/xil_defaultlib -sv \
  "/home/sol/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/sol/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/sol/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../HustPC3.0.srcs/sources_1/ip/ClkGen/ClkGen_clk_wiz.v" \
  "../../../../HustPC3.0.srcs/sources_1/ip/ClkGen/ClkGen.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

