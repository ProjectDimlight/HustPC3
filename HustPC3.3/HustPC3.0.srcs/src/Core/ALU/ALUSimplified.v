`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 18:15:07
// Design Name: 
// Module Name: ALUSimplified
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
// 0000: &
// 0001: |
// 0010: +
// 0011: -
// 0100: >> (l)
// 0101: >> (a)
// 0110: <<
// 0111: <
// 1000: ^
// 1001: ~|
// 1010: ?
// 1011: ?
// 1100: >> (lb)
// 1101: >> (ab)
// 1110: << (b)
// 1111: a
//////////////////////////////////////////////////////////////////////////////////

module ALUSimplified(
    input [31:0] a,
    input [31:0] b,
    input [4:0] sft,
    input [4:0] aluOp,
    output [31:0] res,
    output zf,
    output ef
);

wire [31:0] addx, shiftx, shiftv, res0, res1, res2, res3;

Add add(a, b, aluOp[0], addx);
Shift shiftX(b, sft, aluOp[1:0], shiftx);
Shift shiftV(a,   b, aluOp[1:0], shiftv);

wire less = a[31] == b[31] ? (a < b) : ((~b[31]) & a[31]); 

Mux32b8p mux0(a & b, a | b, addx, addx, shiftx, shiftx, shiftx, {31'b0, less}, aluOp[2:0], res0);
Mux32b8p mux1(a ^ b, ~(a | b), 0, 0, shiftv, shiftv, shiftv, a, aluOp[2:0], res1);
Mux32b8p mux2(0, 0, 0, 0, 0, 0, 0, 0, aluOp[2:0], res2);
Mux32b8p mux3(0, 0, 0, 0, 0, 0, 0, 0, aluOp[2:0], res3);
Mux32b4p mux(res0, res1, res2, res3, aluOp[4:3], res);

assign zf = &(~res);
assign ef = 1'b0;

endmodule
