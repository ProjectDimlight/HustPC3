`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 20:49:45
// Design Name: 
// Module Name: PCPU_SIM
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

module TestIntr;

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
    __r3 = 5'b01100;
    intr = 4'b0000;
    inData = 0;
    inInst = 0;
    #0.5;
    rst = 1'b1;
    #0.5;
    
    // Initialize Inputs
    // Add stimulus here
    inInst = 32'h00000000;
    #1;
    inInst = 32'h00000000;
    #1;
    inInst = 32'h1000FFFF;
    #1;
    inInst = 32'h00000000;
    intr = 4'b0001;  // modify the intr code here
    #1;
    inInst = 32'h1000FFFF;
    intr = 4'b0000;  // modify the intr code here
    #1;
    inInst = 32'h00000000;
    #5;
    inInst = 32'b01000010000000000000000000011000;
    #1;
    inInst = 32'h0;
end

always begin
    clk = 1;
    #0.5;
    clk = 0;
    #0.5;
end

endmodule