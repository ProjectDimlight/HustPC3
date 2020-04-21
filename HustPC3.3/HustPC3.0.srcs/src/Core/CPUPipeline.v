`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 18:15:07
// Design Name: 
// Module Name: CPUPipeline
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

module CPUPipeline(
    input  clk,
    input  rst,
    input  [3:0] intr,
    output [31:0] addrInst,
    input  [31:0] inInst,
    output memReadData,
    output memWriteData,
    output [31:0] addrData,
    input  [31:0] inData,
    output [31:0] outData,
    input [4:0] __r3,
    output [31:0] __d3, 
    output [31:0] __irID,
    output [31:0] __pcID, 
    output [31:0] __irEX,
    output [31:0] __pcEX, 
    output [31:0] __irMEM,
    output [31:0] __pcMEM, 
    output [31:0] __irWB,
    output [31:0] __pcWB,
    output [31:0] __ir,
    output [31:0] __pc,
    output [31:0] __epc,
    output [31:0] __nextPC,
    output [31:0] __a,
    output [31:0] __b,
    output [31:0] __imm,
    output [31:0] __aluOpEX,
    output [31:0] __aluOutEX,
    output [31:0] __aluRes,
    output [1:0] __aluSrcA,
    output [1:0] __aluSrcB,
    output __shiftEX,
    output __aluImmEX,
    output [2:0] __pcSrc,
    output __wpcir,
    output __epcSrc,
    output __storeEPC,
    output [4:0] __wdEX,
    output [4:0] __wdMEM,
    output [4:0] __wdWB,
    output [31:0] __wdataWB,
    output [3:0] __regWriteWB,
    output __mem2RegMEM
);

// Interrupt
reg [31:0] intid;

// PC
wire [31:0] pc, nextPC, epc, nextEPC;
wire [31:0] irID, irEX, irMEM, irWB;
wire [31:0] pcID, pcEX, pcMEM, pcWB;
wire wpcir, storeEPC, epcSrc;
RegsPC regsPC(clk, rst, nextPC, wpcir, nextEPC, storeEPC, pc, epc);
assign __pc = pc;
assign __epc = epc;
assign __wpcir = wpcir;
assign __epcSrc = epcSrc;
assign __storeEPC = storeEPC;
assign __nextPC = nextPC;
// IF Stage
wire [31:0] branchPC, jPC, aID, pc4IF, irIF;
wire [2:0] pcSrc;
IFStage ifStage(
    pc, branchPC, jPC, aID, epc, pcSrc, pcID, epcSrc, inInst, 
    nextPC, nextEPC, pc4IF, irIF, addrInst);
assign __pcSrc = pcSrc;
// FD
wire [31:0] pc4ID;
wire int_stall;
RegsFD regsFD(
    clk, rst, pc4IF, irIF, pc, wpcir, int_stall,
    pc4ID, irID, pcID
);
// ID Stage
wire [4:0] wdEX, wdMEM, aluOpID, shamtID, wdID, na, nb, wdWB;
wire mem2RegEX, regWriteEX, mem2RegMEM, regWriteMEM, regWriteWB;
wire regWriteID, mem2RegID, memWriteID, aluImmID, shiftID, jalID;
wire [31:0] aluOutEX, aluOutMEM, regA, regB, bID, immID, wdataWB, wdEXout, mdrMEM;
IDStage idStage(
    clk, intr, pc4ID, irID, wdEXout, mem2RegEX, regWriteEX, aluOutEX, wdMEM, mem2RegMEM, regWriteMEM, aluOutMEM, mdrMEM, regA, regB,
    branchPC, jPC, pcSrc, wpcir, regWriteID, mem2RegID, memWriteID, aluOpID, aluImmID, aID, bID, immID, shamtID, wdID, shiftID, jalID, storeEPC, epcSrc, na, nb, int_stall,
    __aluSrcA, __aluSrcB
);
RegFile registers(
    ~clk, rst, regWriteWB, na, nb, wdWB, wdataWB,
    regA, regB,
    __r3, __d3
);
assign __ir = irID;
assign __a = aID;
assign __b = bID;
assign __imm = immID;
// DE
wire memWriteEX, shiftEX, jalEX;
wire [4:0] aluOpEX, shamtEX;
wire [31:0] aluImmEX, aEX, bEX, immEX, pc4EX;
RegsDE regsDE(
    clk, rst, regWriteID, mem2RegID, memWriteID, aluOpID, aluImmID, aID, bID, immID, shamtID, wdID, shiftID, jalID, pc4ID, irID, pcID,
    regWriteEX, mem2RegEX, memWriteEX, aluOpEX, aluImmEX, aEX, bEX, immEX, shamtEX, wdEX, shiftEX, jalEX, pc4EX, irEX, pcEX
);
assign __aluImmEX = aluImmEX;
assign __shiftEX = shiftEX;

// EX Stage
EXEStage exeStage(
    aluOpEX, aluImmEX, aEX, bEX, shamtEX, immEX, shiftEX, wdEX, pc4EX, jalEX,
    wdEXout, aluOutEX, __aluRes
);
assign __aluOpEX = aluOpEX;
assign __aluOutEX = aluOutEX;
// EM
wire memWriteMEM;
wire [31:0] bMEM;
RegsEM regsEM(
    clk, rst, regWriteEX, mem2RegEX, memWriteEX, aluOutEX, bEX, wdEXout, irEX, pcEX,
    regWriteMEM, mem2RegMEM, memWriteMEM, aluOutMEM, bMEM, wdMEM, irMEM, pcMEM
);
assign __mem2RegMEM = mem2RegMEM;
// MEM Stage
MEMStage memStage(
    aluOutMEM, bMEM, inData,
    mdrMEM, addrData, outData
);
assign memReadData = mem2RegMEM;
assign memWriteData = memWriteMEM;
// MW
wire mem2RegWB;
wire [31:0] mdrWB, aluOutWB;
RegsMW regsMW(
    clk, rst, regWriteMEM, mem2RegMEM, mdrMEM, aluOutMEM, wdMEM, irMEM, pcMEM, 
    regWriteWB, mem2RegWB, mdrWB, aluOutWB, wdWB, irWB, pcWB
);
// WB Stage
WBStage wbStage(
    mdrWB, aluOutWB, mem2RegWB, wdataWB 
);

assign __wdEX = wdEX;
assign __wdMEM = wdMEM;
assign __wdWB = wdWB;
assign __wdataWB = wdataWB;
assign __regWriteWB = {regWriteID, regWriteEX, regWriteMEM, regWriteWB};

assign __irID = irID;
assign __pcID = pcID;
assign __irEX = irEX;
assign __pcEX = pcEX;
assign __irMEM = irMEM;
assign __pcMEM = pcMEM;
assign __irWB = irWB;
assign __pcWB = pcWB;
endmodule
