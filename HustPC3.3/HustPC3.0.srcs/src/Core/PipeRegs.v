`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/30 12:29:24
// Design Name: 
// Module Name: PipeRegs
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

module RegsPC(
    input clk,
    input rst,
    input [31:0] nextPC,
    input wpcir,
    input [31:0] nextEPC,
    input storeEPC,
    output reg [31:0] pc,
    output reg [31:0] epc
);

initial begin
    pc = 32'b0;
    epc = 32'b0;
end

always @ (posedge clk)
begin
    if (rst) begin
        epc = storeEPC ? nextEPC : epc; 
        pc = wpcir ? nextPC : pc;
    end
    else begin
        pc = 0;
        epc = 0;
    end
end

endmodule

module RegsFD(
    input clk,
    input rst,
    input [31:0] pc4IF,
    input [31:0] irIF,
    input [31:0] pcIF,
    input wpcir,            // Lock of pc / ir
    input int_stall,
    output reg [31:0] pc4ID,
    output reg [31:0] irID,
    output reg [31:0] pcID
);

initial begin
    pc4ID = 32'b0;
     irID = 32'b0;
     pcID = 32'b0;
end

always @ (posedge clk)
begin
    if (rst)
    begin
        pc4ID = wpcir ? pc4IF : pc4ID;
        irID = (int_stall | wpcir) ?  irIF :  irID;
        // irID = irIF;
         pcID = pcIF;
    end
    else
    begin
        pc4ID = 32'b0;
         irID = 32'b0;
         pcID = 32'b0;
    end
end

endmodule

module RegsDE(
    input clk,
    input rst,
    input regWriteID,
    input mem2RegID,
    input memWriteID,
    input [4:0] aluOpID,
    input aluImmID,
    input [31:0] aID,
    input [31:0] bID,
    input [31:0] immID,
    input [4:0] shamtID,
    input [4:0] wdID,
    input shiftID,
    input jalID,
    input [31:0] pc4ID,
    input [31:0] irID,
    input [31:0] pcID,
    output reg regWriteEX,
    output reg mem2RegEX,
    output reg memWriteEX,
    output reg [4:0] aluOpEX,
    output reg aluImmEX,
    output reg [31:0] aEX,
    output reg [31:0] bEX,
    output reg [31:0] immEX,
    output reg [4:0] shamtEX,
    output reg [4:0] wdEX,
    output reg shiftEX,
    output reg jalEX,
    output reg [31:0] pc4EX,
    output reg [31:0] irEX,
    output reg [31:0] pcEX
);

initial begin
    regWriteEX =  1'b0;
     mem2RegEX =  1'b0;
    memWriteEX =  1'b0;
       aluOpEX =  5'b0;
      aluImmEX =  1'b0;
           aEX = 32'b0;
           bEX = 32'b0;
         immEX = 32'b0;
       shamtEX =  5'b0;
          wdEX =  5'b0;
       shiftEX =  1'b0;
         jalEX =  1'b0;
         pc4EX = 32'b0;
          irEX = 32'b0;
          pcEX = 32'b0;
end

always @ (posedge clk)
begin
    if (rst)
    begin
        regWriteEX = regWriteID;
         mem2RegEX =  mem2RegID;
        memWriteEX = memWriteID;
           aluOpEX =    aluOpID;
          aluImmEX =   aluImmID;
               aEX =        aID;
               bEX =        bID;
             immEX =      immID;
           shamtEX =    shamtID;
              wdEX =       wdID;
           shiftEX =    shiftID;
             jalEX =      jalID;
             pc4EX =      pc4ID;
              irEX =       irID;
              pcEX =       pcID;
    end
    else
    begin
        regWriteEX =  1'b0;
         mem2RegEX =  1'b0;
        memWriteEX =  1'b0;
           aluOpEX =  5'b0;
          aluImmEX =  1'b0;
               aEX = 32'b0;
               bEX = 32'b0;
             immEX = 32'b0;
           shamtEX =  5'b0;
              wdEX =  5'b0;
           shiftEX =  1'b0;
             jalEX =  1'b0;
             pc4EX = 32'b0;
              irEX = 32'b0;
              pcEX = 32'b0;
    end
end

endmodule

module RegsEM(
    input clk,
    input rst,
    input regWriteEX,
    input mem2RegEX,
    input memWriteEX,
    input [31:0] aluOutEX,
    input [31:0] bEX,
    input [4:0] wdEX,
    input [31:0] irEX,
    input [31:0] pcEX,
    output reg regWriteMEM,
    output reg mem2RegMEM,
    output reg memWriteMEM,
    output reg [31:0] aluOutMEM,
    output reg [31:0] bMEM,
    output reg [4:0] wdMEM,
    output reg [31:0] irMEM,
    output reg [31:0] pcMEM
);

initial begin
    regWriteMEM =  1'b0;
     mem2RegMEM =  1'b0;
    memWriteMEM =  1'b0;
      aluOutMEM = 32'b0;
           bMEM = 32'b0;
          wdMEM =  5'b0;
          irMEM = 32'b0;
          pcMEM = 32'b0;
end

always @ (posedge clk)
begin
    if (rst)
    begin
        regWriteMEM = regWriteEX;
         mem2RegMEM =  mem2RegEX;
        memWriteMEM = memWriteEX;
          aluOutMEM =   aluOutEX;
               bMEM =        bEX;
              wdMEM =       wdEX;
              irMEM =       irEX;
              pcMEM =       pcEX;
    end
    else
    begin
        regWriteMEM =  1'b0;
         mem2RegMEM =  1'b0;
        memWriteMEM =  1'b0;
          aluOutMEM = 32'b0;
               bMEM = 32'b0;
              wdMEM =  5'b0;
              irMEM = 32'b0;
              pcMEM = 32'b0;
    end
end

endmodule

module RegsMW(
    input clk,
    input rst,
    input regWriteMEM,
    input mem2RegMEM,
    input [31:0] mdrMEM,
    input [31:0] aluOutMEM,
    input [4:0] wdMEM,
    input [31:0] irMEM,
    input [31:0] pcMEM,
    output reg regWriteWB,
    output reg mem2RegWB,
    output reg [31:0] mdrWB,
    output reg [31:0] aluOutWB,
    output reg [4:0] wdWB,
    output reg [31:0] irWB,
    output reg [31:0] pcWB
);

initial begin
    regWriteWB =  1'b0;
     mem2RegWB =  1'b0;
         mdrWB = 32'b0;
      aluOutWB = 32'b0;
          wdWB =  5'b0;
          irWB = 32'b0;
          pcWB = 32'b0;
end

always @ (posedge clk)
begin
    if (rst)
    begin
        regWriteWB = regWriteMEM;
         mem2RegWB =  mem2RegMEM;
             mdrWB =      mdrMEM;
          aluOutWB =   aluOutMEM;
              wdWB =       wdMEM;
              irWB =       irMEM;
              pcWB =       pcMEM;
    end
    else
    begin
        regWriteWB =  1'b0;
         mem2RegWB =  1'b0;
             mdrWB = 32'b0;
          aluOutWB = 32'b0;
              wdWB =  5'b0;
              irWB = 32'b0;
              pcWB = 32'b0;
    end
end

endmodule
