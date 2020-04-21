`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 18:37:00
// Design Name: 
// Module Name: Shift
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
// 00: SRL 
// 01: SRA
// 1X: SL
//////////////////////////////////////////////////////////////////////////////////

module Shift(
    input [31:0] a,
    input [4:0] b,
    input [1:0] s,
    output [31:0] res 
);

wire [31:0] srl0, srl1, srl2, srl3, srl4;
wire [31:0] sra0, sra1, sra2, sra3, sra4;
wire [31:0] sl0, sl1, sl2, sl3, sl4;

// Shift Right Logical
Mux32b2p srl_0(   a, { 1'b0,    a[31: 1]}, b[0], srl0);
Mux32b2p srl_1(srl0, { 2'b0, srl0[31: 2]}, b[1], srl1);
Mux32b2p srl_2(srl1, { 4'b0, srl1[31: 4]}, b[2], srl2);
Mux32b2p srl_3(srl2, { 8'b0, srl2[31: 8]}, b[3], srl3);
Mux32b2p srl_4(srl3, {16'b0, srl3[31:16]}, b[4], srl4);

// Shift Right Arithmatic
Mux32b2p sra_0(   a, {{ 1{a[31]}},    a[31: 1]}, b[0], sra0);
Mux32b2p sra_1(sra0, {{ 2{a[31]}}, sra0[31: 2]}, b[1], sra1);
Mux32b2p sra_2(sra1, {{ 4{a[31]}}, sra1[31: 4]}, b[2], sra2);
Mux32b2p sra_3(sra2, {{ 8{a[31]}}, sra2[31: 8]}, b[3], sra3);
Mux32b2p sra_4(sra3, {{16{a[31]}}, sra3[31:16]}, b[4], sra4);

// Shift Left
Mux32b2p sl_0(  a, {  a[30:0],  1'b0}, b[0], sl0);
Mux32b2p sl_1(sl0, {sl0[29:0],  2'b0}, b[1], sl1);
Mux32b2p sl_2(sl1, {sl1[27:0],  4'b0}, b[2], sl2);
Mux32b2p sl_3(sl2, {sl2[23:0],  8'b0}, b[3], sl3);
Mux32b2p sl_4(sl3, {sl3[15:0], 16'b0}, b[4], sl4);

Mux32b4p mux(srl4, sra4, sl4, sl4, s, res);

endmodule
