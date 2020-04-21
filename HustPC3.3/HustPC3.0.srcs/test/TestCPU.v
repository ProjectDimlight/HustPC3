`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/31 00:34:54
// Design Name: 
// Module Name: TestCPU
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

module TestCPU;

reg clk;
reg rst;
reg [31:0] inInst;
reg [31:0] inData;
reg [4:0] __r3;
reg [3:0] intr;

wire [31:0] addrInst;
wire [31:0] addrData;
wire [31:0] outData;
wire [31:0] __d3;
wire [31:0] __ir, __pc, __epc, __nextPC, __a, __b, __imm, __aluOpEX, __aluOutEX, __aluRes;
wire [1:0] __aluSrcA, __aluSrcB;
wire __shiftEX, __aluImmEX;
wire [2:0] __pcSrc;
wire __wpcir;
wire __storeEPC;
wire __epcSrc;
wire [4:0] __wdEX, __wdMEM, __wdWB;
wire [31:0] __wdataWB;
wire [3:0] __regWrite;
wire __mem2RegMEM;

wire memReadData;
wire memWriteData;

CPUPipeline cpu(
    clk,
    rst,
    intr,
    addrInst,
    inInst,
    memReadData,
    memWriteData,
    addrData,
    inData,
    outData,
    __r3,
    __d3,
    __ir,
    __pc,
    __epc,
    __nextPC,
    __a,
    __b,
    __imm,
    __aluOpEX,
    __aluOutEX,
    __aluRes,
    __aluSrcA,
    __aluSrcB,
    __shiftEX,
    __aluImmEX,
    __pcSrc,
    __wpcir,
    __epcSrc,
    __storeEPC,
    __wdEX,
    __wdMEM,
    __wdWB,
    __wdataWB,
    __regWrite,
    __mem2RegMEM
);

initial begin
    rst = 1'b0;
    intr = 0;
    __r3 = 5'b01010;
    #0.5;
    rst = 1'b1;
    #0.5;
    // ADDI $t0, $zero, 1
    inInst = 32'h2008FFFF;
    #1;
    // ADDI $t1, $zero, 1
    inInst = 32'h2009000A;
    #1;
    inInst = 32'h0109502A;
    
    /*
    // ADD  $t2, $t0, $t1
    inInst = 32'b000000_01000_01001_01010_00000_100000;
    #1;
    // ADD  $t3, $t1, $t2
    inInst = 32'b000000_01001_01010_01011_00000_100000;
    #1;
    // ADD  $t4, $t2, $t3
    inInst = 32'b000000_01010_01011_01100_00000_100000;
    #1;
    // BEQ  $t4, $t4, 10
    inInst = 32'b000100_01100_01100_00000000_00001010;
    #1;
    // ADD  $t5, $t3, $t4
    inInst = 32'b000000_01011_01100_01101_00000_100000;
    #1;
    // ADD  $t5, $t3, $t4
    inInst = 32'b000000_01101_01101_01101_00000_100000;
    #1;
    // NOP
    inInst = 32'b0;
    #1;
    // 
    __r3 = 5'b01101;
    #1;
    */
end

always begin
    clk = 1;
    #0.5;
    clk = 0;
    #0.5;
end

endmodule
