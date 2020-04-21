`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 18:18:50
// Design Name: 
// Module Name: 
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

module Mux32b2p(
    input [31:0] a0,
    input [31:0] a1,
    input s,
    output [31:0] b
);

assign b = ({32{s}} & a1) | ({32{~s}} & a0);  

endmodule

module Mux32b4p(
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [31:0] a3,
    input [1:0] s,
    output [31:0] b
);

wire [31:0] t01, t23;
Mux32b2p mux01(a0, a1, s[0], t01);
Mux32b2p mux23(a2, a3, s[0], t23);
Mux32b2p muxB(t01, t23, s[1], b);

endmodule

module Mux32b8p(
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [31:0] a3,
    input [31:0] a4,
    input [31:0] a5,
    input [31:0] a6,
    input [31:0] a7,
    input [2:0] s,
    output [31:0] b
);

wire [31:0] t03, t47;
Mux32b4p mux03( a0, a1, a2, a3, s[1:0], t03);
Mux32b4p mux47( a4, a5, a6, a7, s[1:0], t47);
Mux32b2p muxB(t03, t47, s[2], b);

endmodule