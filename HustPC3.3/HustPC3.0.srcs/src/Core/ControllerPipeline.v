`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/30 09:40:12
// Design Name: 
// Module Name: ControllerPipeline
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

module ControllerPipeline(
    input clk,
    input [5:0] op,
    input [5:0] func,
    input [3:0] intr,
    input [4:0] rs,
    input [4:0] rt,
    input abEqual,
    input [4:0] wdEX,
    input mem2RegEX,
    input regWriteEX,
    input [4:0] wdMEM,
    input mem2RegMEM,
    input regWriteMEM,
    output regWrite,
    output mem2Reg,
    output memWrite,
    output jal,
    output [4:0] aluOp,
    output aluImm,
    output shift,
    output regDist,
    output sext,
    output [1:0] aluSrcA,
    output [1:0] aluSrcB,
    output wpcir,
    output [2:0] pcSrc,
    output storeEPC,
    output epcSrc,
    output reg int_stall
);

reg [4:0] aluOp1, aluOp2;

localparam R = 6'b000000;
localparam BEQ = 6'b000100;
localparam BNE = 6'b000101;
localparam JAL = 6'b000011;
localparam J = 6'b000010;
localparam LW = 6'b100011;
localparam SW = 6'b101011;
localparam ADDI = 6'b001000;
localparam SLTI = 6'b001010;
localparam ANDI = 6'b001100;
localparam ORI = 6'b001101;
localparam XORI = 6'b001110;
localparam LUI = 6'b001111;
localparam STOP = 6'b111111;
localparam ERET = 6'b010000; //6'h18

localparam AND = 6'b100100;
localparam OR = 6'b100101;
localparam ADD = 6'b100000;
localparam SUB = 6'b100010;
localparam SRL = 6'b000010;
localparam SRA = 6'b000011;
localparam SLL = 6'b000000;
localparam JR  = 6'b001000;
localparam XOR = 6'b100110;
localparam SLT = 6'b101010;
localparam SYSCALL = 6'b001100;

// Interrupt manager

reg [3:0] stage;
reg [3:0] cnt;
reg goto_intr;
wire int_any = |intr;

initial begin
    stage = 0;
    cnt = 0;
    int_stall = 0;
    goto_intr = 0;
end

always @ (posedge clk)
begin
    case(stage)
    4'h0: begin
        stage = int_any ? 4'h1 : 4'h0;
        cnt = 0;
        int_stall = 1'b0;
        goto_intr = int_any ? 1'b1 : 1'b0;
    end
    4'h1: begin
        goto_intr = 1'b0;
        int_stall = 1'b1;
        stage = cnt < 4 ? stage : 4'h0;
        cnt = cnt + 1; 
    end
    endcase
end

assign storeEPC = goto_intr;

// Normal
assign regWrite = (op == R) | (op == JAL) | (op == LW) | (op == ADDI) | (op == SLTI) | (op == ANDI) | (op == ORI) | (op == XORI) | (op == LUI);

wire   mem2RegT  = (op == LW);
wire   memWriteT = (op == SW);
wire   i_rs = (op != JAL) & (op != LUI);
wire   i_rt = (op == R) | (op == BEQ) | (op == BNE) | (op == SW);
wire   stall = int_stall | regWriteEX & mem2RegEX & (wdEX != 0) & (i_rs & (wdEX == rs) | i_rt & (wdEX == rt));
assign mem2Reg   = mem2RegT  & ~stall;
assign memWrite  = memWriteT & ~stall;

assign jal = (op == JAL);
assign aluOp = (op == R) ? aluOp2 : aluOp1;
assign aluImm = (op == ADDI) | (op == SLTI) | (op == ANDI) | (op == ORI) | (op == XORI) | (op == LW) | (op == SW);
assign shift = (op == LUI);
assign regDist = (op == R);
assign sext = ((op == ANDI) | (op == ORI) | (op == XORI)) ? 1'b0 : 1'b1;

assign wpcir = ~stall;
assign pcSrc = 
    ((goto_intr) ? 3'b100 :
    ((op == ERET) ? 3'b101 :
    (((op == BEQ) & abEqual | (op == BNE) & ~abEqual) ? 3'b001 :
    (((op == R) & (func == JR)) ? 3'b010 :
    (((op == JAL) | (op == J) ) ? 3'b011 :
    3'b000)))));

assign epcSrc =
    ((op == BEQ) | (op == BNE) | (op == JAL) | (op == J) | (op == R) & ((func == JR)))
        ? 1'b1
        : 1'b0;

assign aluSrcA =
    ((regWriteEX  & (wdEX  != 5'b0) & (wdEX  == rs) & ~mem2RegEX ) ? 2'b01 :
    ((regWriteMEM & (wdMEM != 5'b0) & (wdMEM == rs) & ~mem2RegMEM) ? 2'b10 :
    ((regWriteMEM & (wdMEM != 5'b0) & (wdMEM == rs) &  mem2RegMEM) ? 2'b11 :
    2'b00)));
assign aluSrcB =
    ((regWriteEX  & (wdEX  != 5'b0) & (wdEX  == rt) & ~mem2RegEX ) ? 2'b01 :
    ((regWriteMEM & (wdMEM != 5'b0) & (wdMEM == rt) & ~mem2RegMEM) ? 2'b10 :
    ((regWriteMEM & (wdMEM != 5'b0) & (wdMEM == rt) &  mem2RegMEM) ? 2'b11 :
    2'b00)));

initial begin
    aluOp1 = 5'b0;
    aluOp2 = 5'b0;
end

always @ (*)
begin
    case(op)
    R:
        aluOp1 = 5'b00000;
    BEQ:
        aluOp1 = 5'b00000;
    BNE:
        aluOp1 = 5'b00000;
    JAL:
        aluOp1 = 5'b00000;
    LW:
        aluOp1 = 5'b00010;
    SW:
        aluOp1 = 5'b00010;
    ADDI:
        aluOp1 = 5'b00010;
    SLTI:
        aluOp1 = 5'b00111;
    ANDI:
        aluOp1 = 5'b00000;
    ORI:
        aluOp1 = 5'b00001;
    XORI:
        aluOp1 = 5'b01000;
    LUI:
        aluOp1 = 5'b01111;
    STOP:
        aluOp1 = 5'b00000;
    endcase
end

always @ (*)
begin
    case(func)
    AND:
        aluOp2 = 5'b00000;
    OR:
        aluOp2 = 5'b00001;
    ADD:
        aluOp2 = 5'b00010;
    SUB:
        aluOp2 = 5'b00011;
    SRL:
        aluOp2 = 5'b00100;
    SRA:
        aluOp2 = 5'b00101;
    SLL:
        aluOp2 = 5'b00110;
    XOR:
        aluOp2 = 5'b01000;
    SLT:
        aluOp2 = 5'b00111;
    default:
        aluOp2 = 5'b00000;
    endcase
end

endmodule
