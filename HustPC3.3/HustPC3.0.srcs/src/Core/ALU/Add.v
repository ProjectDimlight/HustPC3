`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 18:37:00
// Design Name: 
// Module Name: Add
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
// TODO: Fake!!!
//////////////////////////////////////////////////////////////////////////////////

module Add(
    input [31:0] a,
    input [31:0] b,
    input s,
    output [31:0] res 
);

assign res = s ? a - b : a + b;

endmodule
