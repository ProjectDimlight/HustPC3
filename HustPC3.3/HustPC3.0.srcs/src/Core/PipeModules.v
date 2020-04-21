`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/30 12:29:24
// Design Name: 
// Module Name: PipeModules
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

module IFStage(
    input [31:0] pc,
    input [31:0] branchPC,
    input [31:0] jPC,
    input [31:0] aID,                  // JR $ra
    input [31:0] epc,
    input [2:0] pcSrc,
    input [31:0] pcID,
    input epcSrc,
    input [31:0] inInst,
    output [31:0] nextPC,
    output [31:0] nextEPC,
    output [31:0] pc4,
    output [31:0] ir,
    output [31:0] addrInst
);

assign ir = inInst;
assign addrInst = pc;
assign pc4 = pc + 4;

Mux32b8p muxNextPC(
    pc4,
    branchPC,
    aID,
    jPC,
    32'h80000000,
    epc,
    0,
    0,
    pcSrc,
    nextPC    
);

assign nextEPC = epcSrc ? pcID : pc;

endmodule

module IDStage(
    // Interrupt
    input clk,
    input [3:0] intr,
    // PC & IR
    input [31:0] pc4,
    input [31:0] ir,
    // EX
    input [4:0] wdEX,
    input mem2RegEX,
    input regWriteEX,
    input [31:0] aluOutEX,
    // MEM
    input [4:0] wdMEM,
    input mem2RegMEM,
    input regWriteMEM,
    input [31:0] aluOutMEM,
    input [31:0] mdrMEM,
    // RegFile
    input [31:0] regA,
    input [31:0] regB,
    
    // Out
    output [31:0] branchPC,
    output [31:0] jPC,
    output [2:0] pcSrc,
    output wpcir,
    output regWrite,
    output mem2Reg,
    output memWrite,
    output [4:0] aluOp,
    output aluImm,
    output [31:0] a,
    output [31:0] b,
    output [31:0] imm,
    output [4:0] shamt,
    output [4:0] wd,
    output shift,
    output jal,
    output storeEPC,
    output epcSrc,
    
    // RegFile
    output [4:0] na,
    output [4:0] nb,
    output int_stall,
    
    //Debug
    output [1:0] __aluSrcA,
    output [1:0] __aluSrcB
);

// Contoller
wire sext, regDist;
wire [1:0] aluSrcA, aluSrcB;
ControllerPipeline controller(
    .clk(clk),
    .op(ir[31:26]),
    .func(ir[5:0]),
    .intr(intr[3:0]),
    .rs(ir[25:21]),
    .rt(ir[20:16]),
    .abEqual(a == b),
    .wdEX(wdEX),
    .mem2RegEX(mem2RegEX),
    .regWriteEX(regWriteEX),
    .wdMEM(wdMEM),
    .mem2RegMEM(mem2RegMEM),
    .regWriteMEM(regWriteMEM),
    
    .regWrite(regWrite),
    .mem2Reg(mem2Reg),
    .memWrite(memWrite),
    .jal(jal),
    .aluOp(aluOp),
    .aluImm(aluImm),
    .shift(shift),
    .regDist(regDist),
    .sext(sext),
    .aluSrcA(aluSrcA),
    .aluSrcB(aluSrcB),
    .wpcir(wpcir),
    .pcSrc(pcSrc),
    .storeEPC(storeEPC),
    .epcSrc(epcSrc),
    
    .int_stall(int_stall)
);

// Imm
wire [31:0] signImm = {{16{ir[15]}}, ir[15:0]};
assign imm = {{16{ir[15] & sext}}, ir[15:0]};
assign na = ir[25:21];
assign nb = ir[20:16];
wire [4:0] rd = ir[15:11];
assign shamt = ir[10:6];

assign branchPC = {signImm[29:0], 2'b00} + pc4;
assign jPC = {pc4[31:28], ir[25:0], 2'b0};

Mux32b4p muxA(regA, aluOutEX, aluOutMEM, mdrMEM, aluSrcA, a);
Mux32b4p muxB(regB, aluOutEX, aluOutMEM, mdrMEM, aluSrcB, b);
assign wd = regDist ? rd : nb;

assign __aluSrcA = aluSrcA;
assign __aluSrcB = aluSrcB;

endmodule

module EXEStage(
    input [4:0] aluOp,
    input aluImm,
    input [31:0] a,
    input [31:0] b,
    input [4:0] shamt,
    input [31:0] imm,
    input shift,
    input [4:0] wd,
    input [31:0] pc4,
    input jal,
    output [4:0] wdEX,
    output [31:0] aluOut,
    output [31:0] __aluRes
);

wire [31:0] aluA, aluB, aluRes;
Mux32b2p muxA(a, {imm[15:0], 16'b0}, shift, aluA);
Mux32b2p muxB(b, imm, aluImm, aluB);

ALUSimplified alu(
    .a(aluA),
    .b(aluB),
    .sft(shamt),
    .aluOp(aluOp),
    .res(aluRes),
    .zf(),
    .ef()
);
assign __aluRes = aluRes;

wire [31:0] pc8 = pc4 + 4;
Mux32b2p muxAluOut(aluRes, pc8, jal, aluOut);
assign wdEX = jal ? 5'b11111 : wd;

endmodule

module MEMStage(
    input [31:0] aluOut,
    input [31:0] b,
    input [31:0] inData,
    output [31:0] mdr,
    output [31:0] addrData,
    output [31:0] outData
);

assign mdr = inData;
assign addrData = aluOut;
assign outData = b;

endmodule

module WBStage(
    input [31:0] mdr,
    input [31:0] aluOut,
    input mem2Reg,
    output [31:0] wdata
);

Mux32b2p mux(aluOut, mdr, mem2Reg, wdata);

endmodule
