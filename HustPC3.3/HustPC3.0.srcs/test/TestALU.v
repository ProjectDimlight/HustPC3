`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/03 20:05:23
// Design Name: 
// Module Name: TestALU
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


module TestALU;

wire [31:0] res;

ALUSimplified alu(
    58,
    55,
    0,
    4'b0111,
    res
);

endmodule
