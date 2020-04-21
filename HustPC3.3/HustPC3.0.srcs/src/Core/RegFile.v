`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 20:19:29
// Design Name: 
// Module Name: RegFile
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

module RegFile(
    input clk,
    input rst,
    input regWrite,
    input [4:0] r1,
    input [4:0] r2,
    input [4:0] wd,
    input [31:0] wdata,
    output [31:0] d1,
    output [31:0] d2,
    input [4:0] __r3,
    output [31:0] __d3
);

reg [31:0] regs [31:0];

assign d1 = regs[r1];
assign d2 = regs[r2];
assign __d3 = regs[__r3];

initial
begin
    regs[ 0] = 0;
    regs[ 1] = 0;
    regs[ 2] = 0;
    regs[ 3] = 0;
    regs[ 4] = 0;
    regs[ 5] = 0;
    regs[ 6] = 0;
    regs[ 7] = 0;
    regs[ 8] = 0;
    regs[ 9] = 0;
    regs[10] = 0;
    regs[11] = 0;
    regs[12] = 0;
    regs[13] = 0;
    regs[14] = 0;
    regs[15] = 0;
    regs[16] = 0;
    regs[17] = 0;
    regs[18] = 0;
    regs[19] = 0;
    regs[20] = 0;
    regs[21] = 0;
    regs[22] = 0;
    regs[23] = 0;
    regs[24] = 0;
    regs[25] = 0;
    regs[26] = 0;
    regs[27] = 0;
    regs[28] = 0;
    regs[29] = 40960;
    regs[30] = 0;
    regs[31] = 0;
end

always @ (posedge clk)
begin
    if (rst)
        regs[wd] = (regWrite & (wd != 0)) ? wdata : regs[wd];
    else
    begin
        regs[ 0] = 0;
        regs[ 1] = 0;
        regs[ 2] = 0;
        regs[ 3] = 0;
        regs[ 4] = 0;
        regs[ 5] = 0;
        regs[ 6] = 0;
        regs[ 7] = 0;
        regs[ 8] = 0;
        regs[ 9] = 0;
        regs[10] = 0;
        regs[11] = 0;
        regs[12] = 0;
        regs[13] = 0;
        regs[14] = 0;
        regs[15] = 0;
        regs[16] = 0;
        regs[17] = 0;
        regs[18] = 0;
        regs[19] = 0;
        regs[20] = 0;
        regs[21] = 0;
        regs[22] = 0;
        regs[23] = 0;
        regs[24] = 0;
        regs[25] = 0;
        regs[26] = 0;
        regs[27] = 0;
        regs[28] = 0;
        regs[29] = 40960;
        regs[30] = 0;
        regs[31] = 0;
    end
end

endmodule
