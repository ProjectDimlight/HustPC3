// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Wed Sep  5 15:38:44 2018
// Host        : sol-Lenovo-V1000 running 64-bit Ubuntu 18.04.1 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ Ram1m2p_stub.v
// Design      : Ram1m2p
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[17:0],dina[31:0],douta[31:0],clkb,enb,web[0:0],addrb[17:0],dinb[31:0],doutb[31:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [17:0]addra;
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [17:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
endmodule
