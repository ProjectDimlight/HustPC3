`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:47 08/26/2018 
// Design Name: 
// Module Name:    GPU0 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module GPU0(
    input clk,
    input clk_shift,
    input clk_flush,
    input mode,
    input [31:0] displaydata,
    input [63:0] gpudata,
    
    output seg_clk,
    output seg_clrn,
    output seg_sout,
    output seg_pen,
     
    output [63:0] __gpudata
);

assign __gpudata = gpudata;

// Coder

wire [63:0] seg1, seg2;
ToSeg data00(clk, displaydata[ 3: 0], seg1[ 7: 0]);
ToSeg data01(clk, displaydata[ 7: 4], seg1[15: 8]);
ToSeg data02(clk, displaydata[11: 8], seg1[23:16]);
ToSeg data03(clk, displaydata[15:12], seg1[31:24]);
ToSeg data04(clk, displaydata[19:16], seg1[39:32]);
ToSeg data05(clk, displaydata[23:20], seg1[47:40]);
ToSeg data06(clk, displaydata[27:24], seg1[55:48]);
ToSeg data07(clk, displaydata[31:28], seg1[63:56]);

AsciiToSeg data10(clk, gpudata[ 7: 0], seg2[63:56]);
AsciiToSeg data11(clk, gpudata[15: 8], seg2[55:48]);
AsciiToSeg data12(clk, gpudata[23:16], seg2[47:40]);
AsciiToSeg data13(clk, gpudata[31:24], seg2[39:32]);
AsciiToSeg data14(clk, gpudata[39:32], seg2[31:24]);
AsciiToSeg data15(clk, gpudata[47:40], seg2[23:16]);
AsciiToSeg data16(clk, gpudata[55:48], seg2[15: 8]);
AsciiToSeg data17(clk, gpudata[63:56], seg2[ 7: 0]);

Debug out2(
	clk_shift,
	clk_flush,
	mode ? seg1 : seg2,
	seg_clk, seg_clrn, seg_sout, seg_pen,
);

endmodule
