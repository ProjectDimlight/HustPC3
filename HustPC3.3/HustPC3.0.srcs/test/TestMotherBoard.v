`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/31 16:18:00
// Design Name: 
// Module Name: TestMotherBoard
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

module TestMotherBoard;

    reg clk1;
	reg clk2;
    reg rst;
    reg [15:0] switch;
    reg [3:0] button;
    //reg clkx;
    wire bvcc;
    wire seg_clk;
    wire seg_clrn;
    wire seg_sout;
    wire seg_pen;
    wire [7:0] segment;
    wire [3:0] addr;
	wire [7:0] led;
	reg [4:0] __r3;
	wire [31:0] __d3;
	
    wire [31:0] __irID;
    wire [31:0] __pcID;
    wire [31:0] __irEX;
    wire [31:0] __pcEX;
    wire [31:0] __irMEM;
    wire [31:0] __pcMEM;
    wire [31:0] __irWB;
    wire [31:0] __pcWB;
        
	wire [31:0] __addrInst;
    wire [31:0] __inInst;
    wire [31:0] __addrData;
    wire [31:0] __outData;
    wire [31:0] __inData;
    wire __memWrite, __clk;
    wire [3:0] r, g, b;
    wire hs, vs;
    wire [31:0] __addrGraphics, __inGraphics;
    wire __read;
    wire __mode;
    wire [31:0] __inText;
    wire [15:0] __quwei;
    wire uart_rx = 1'b0;
    wire uart_tx;

MotherBoard motherBoard(
    clk1,
    clk2,
    rst,
    clk1,
    1'b0,
    switch,
    button,
    uart_rx,
    uart_tx,
    bvcc,
    seg_clk,
    seg_clrn,
    seg_sout,
    seg_pen,
    segment,
    addr,
    led,
    r, g, b,
    hs, vs,
    __r3,
    __d3,
    
    
    __irID,
    __pcID,
    __irEX,
    __pcEX,
    __irMEM,
    __pcMEM,
    __irWB,
    __pcWB,
        
    
    __addrInst,
    __inInst,
    __addrData,
    __outData,
    __inData,
    __memWrite,
    __clk,
    __addrGraphics,
    __inGraphics,
    __read,
    __mode,
    __inText,
    __quwei
);

initial begin
    clk1 = 0;
    clk2 = 0;
    rst = 1'b0;
    #2;
    rst = 1'b1;
    __r3 = 5'b01000;
    switch[15] = 1'b1;
    switch[14] = 1'b0;
end

always begin
    clk1 = 1;
    #0.5;
    clk2 = 1;
    #0.5;
    clk1 = 0;
    #0.5;
    clk2 = 0;
    #0.5;
end

endmodule
