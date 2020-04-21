`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 22:31:47
// Design Name: 
// Module Name: rx_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rx_module(
    input clk_100mhz,
    input RSTn,
    input rx_PIN_in,
    input rx_En,
    output rx_done,
    output[7:0] rx_out
    );
    wire H2L_sig, Count_sig,BPS_sampling;
    rx_detect_module detect(.CLK(clk_100mhz), .RSTn(RSTn), .rx_in(rx_PIN_in),.H2L_sig(H2L_sig));
    rx_control_module control(.CLK(clk_100mhz), .RSTn(RSTn), .rx_En(rx_En), .BPS_sampling(BPS_sampling), .rx_PIN_in(rx_PIN_in), .H2L_sig(H2L_sig), .Count_sig(Count_sig), .rx_out(rx_out), .rx_done(rx_done));
    rx_bps_module bps(.CLK(clk_100mhz),.RSTn(RSTn),.Count_sig(Count_sig),.BPS_sampling(BPS_sampling));
endmodule
