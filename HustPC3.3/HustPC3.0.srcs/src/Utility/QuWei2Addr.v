`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 05:22:34 AM
// Design Name: 
// Module Name: QuWei2Addr
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


module QuWei2Addr(
    input [7:0] qu,
    input [7:0] wei,
    output [31:0] addr
);

//wire [31:0] zb = 32'h2000 + (qu-1) * 94 + (wei-1);
//assign addr =  (zb & 32'hE000) == 0 ? zb : 
//              ((zb & 32'h8000) == 0 ? (zb - 32'h2000 + 256) : 32'b0);

wire [31:0] tmp = ({24'b0, qu}-1);
wire [31:0] t1 = {tmp[30:0], 1'b0}; 
wire [31:0] t2 = {tmp[29:0], 2'b0};
wire [31:0] t3 = {tmp[28:0], 3'b0};
wire [31:0] t4 = {tmp[27:0], 4'b0};
wire [31:0] t6 = {tmp[25:0], 6'b0};

assign addr = (qu == 0 ? {24'b0, wei} : (t1 + t2 + t3 + t4 + t6 + {24'b0, wei} + 255));

endmodule
