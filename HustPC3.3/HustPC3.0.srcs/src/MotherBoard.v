`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/31 14:46:15
// Design Name: 
// Module Name: MotherBoard
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

module MotherBoard(
    input clk_200mhz_p,
	input clk_200mhz_n,
    input rst,
    input ps2_clk,
    input ps2_data,
    input [15:0] switch,
    input [3:0] button,
    input uart_rx,
    output uart_tx,
    output bvcc,
    output seg_clk,
    output seg_clrn,
    output seg_sout,
    output seg_pen,
    output [7:0] segment,
    output [3:0] addr,
	output [7:0] led,
	output [3:0] r,
	output [3:0] g,
	output [3:0] b,
	output hs,
	output vs
	/*
	,
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
	
	output [31:0] __addrInst,
    output [31:0] __inInst,
    output [31:0] __addrData,
    output [31:0] __outData,
    output [31:0] __inData,
    output __memWrite,
    output __clk,
    output [31:0] __addrGraphics,
    output [31:0] __inGraphics,
    output __vgaRead,
    output __mode,
    output [31:0] __inText,
    output [15:0] __quwei
    */
);

// Clock
wire clk, clkVGA, clkCPU, clkKey, clk14, clk16, clk25;
IBUFDS clk_200m_buf (.O(clk), .I(clk_200mhz_p), .IB(clk_200mhz_n));
ClkGen clkGen(clkCPU, clkVGA, clkKey, rst, , clk);
assign __clk = clk;

// ClkDiv
wire [63:0] clkDiv;
ClkDiv clkdiv(clk, clkDiv);
assign clk14 = clkDiv[14]; 
assign clk16 = clkDiv[16];
assign clk25 = clkDiv[25];

// Button
wire [3:0] btn;
assign bvcc = 1'b0;
Debounce debounce0(clk16, ~button[0], btn[0]);
Debounce debounce1(clk16, ~button[1], btn[1]);
Debounce debounce2(clk16, ~button[2], btn[2]);
Debounce debounce3(clk16, ~button[3], btn[3]);

reg [3:0] down, last;
initial begin
    down = 0;
    last = 0;
end
always @ (negedge clkCPU)
begin
	down = (~last) & btn;
	last = btn;
end

// Memory
wire [31:0] addrInst, inInst1, inInst0, inInst, addrData, addrSeg, phyAddr, addrGraphics, addrText, outData;
wire [31:0] inData, inData0, inData1, inData2, inData3, inData4, inSeg, inGraphics, inText;
wire memRead, memWrite;

assign __addrInst = addrInst;
assign __inInst = inInst;
assign __addrData = addrData;
assign __outData = outData;
assign __inData = inData;

ROM8k rom(
    clk,
    1'b1,
    1'b0,
    {2'b0, addrInst[31:2]},
    32'b0,
    inInst0,
    clk,
    1'b1,
    memWrite & (0 <= phyAddr) & (phyAddr < 2048),
    {2'b0, addrData[31:2]},
    outData,
    inData0
);

InterruptManageROM imrom(
    clk, 
    1'b1,
    {2'b0, ~addrInst[31], addrInst[30:2]},
    inInst1
);

assign inInst = addrInst[31] ? inInst1 : inInst0;

assign phyAddr = {2'b0, addrData[31:2]};
assign addrSeg = 32'b0; 
 
RAM16k2p ram(
    // Port1
    clk,
    1'b1,
    memWrite & (2048 <= phyAddr) & (phyAddr < 10240),
    phyAddr - 2048,
    outData,
    inData1,
    // Port2
    clk,
    1'b1,
    1'b0,
    addrSeg,
    32'bZ,
    inSeg
);

Ram1m2p vram(
    // Port1
    clk,
    1'b1,
    memWrite & (10240 <= phyAddr) & (phyAddr < 256000),
    phyAddr - 10240,
    outData,
    inData2,
    // Port2
    clk,
    1'b1,
    1'b0,
    addrGraphics,
    32'bZ,
    inGraphics
);

Ram2k2p tram(
    // Port1
    clk,
    1'b1,
    memWrite & (256000 <= phyAddr) & (phyAddr < 257920),
    phyAddr - 256000,
    outData,
    inData3,
    // Port2
    clk,
    1'b1,
    1'b0,
    addrText,
    32'bZ,
    inText
);

// CPU

wire [4:0] __r3 = switch[4:0];
wire [31:0] __d3;
wire [31:0] irID, pcID, irEX, pcEX, irMEM, pcMEM, irWB, pcWB;
wire [31:0] __ir, __pc;

wire clkCPUx = clkCPU & (switch[15] | down[0]);
CPUPipeline cpu(
    clkCPUx,
    rst,
    //{down[0], clkDiv[29:1] == 29'b1111_1111_1111_1111_1111_1111_11, 2'b0},  // 23
    4'b0,
    addrInst,
    inInst,
    memRead,
    memWrite,
    addrData,
    inData,
    outData,
    __r3,
    __d3,
    
    irID,
    pcID, 
    irEX,
    pcEX, 
    irMEM,
    pcMEM, 
    irWB,
    pcWB,
    
    __ir,
    __pc
);
assign __memWrite = memWrite;

assign __irID = irID;
assign __pcID = pcID;
assign __irEX = irEX;
assign __pcEX = pcEX;
assign __irMEM = irMEM;
assign __pcMEM = pcMEM;
assign __irWB = irWB;
assign __pcWB = pcWB;

// Display 0 (Seg)

reg [31:0] counter;

// assign led = counter[7:0];

initial
begin
    counter = 0;
end

always @ (posedge clk)
begin
    counter = (phyAddr == 32'h00500001 ? outData : counter);
end

// Display 1 (VGA)

wire [8:0] row;
wire [9:0] col;
wire vgaRead;

assign addrGraphics = {14'b0, row, col[9:1]};

// Text mode

assign addrText = {row[8:4], col[9:4]}; 

wire [7:0] qu;
wire [7:0] wei;
wire [31:0] addrZB;
wire [15:0] pix;
wire [15:0] color;

assign qu = inText[15:8];
assign wei = inText[7:0];

QuWei2Addr qwa(
    qu,
    wei,
    addrZB
);

ZBMem zbmem(
    clk,
    1'b1,
    {addrZB, row[3:0]},
    pix
);

assign color = pix[col[3:0] ^ 4'b0111] ? inText[31:16] : 16'h000F;

// Mode switcher  

reg mode;

initial
begin
    mode = 1'b1;
end

always @ (posedge clk)
begin
    //mode = (phyAddr == 257920 ? outData[0] : mode);
    mode = 1'b1;
end

wire [11:0] textGraphics;
//assign textGraphics = switch[14] ? 12'hff0 : (mode ? color[15:4] : (col[0] ? inGraphics[31:20] : inGraphics[15:4]));
assign textGraphics = switch[14] ? 12'hff0 : color[15:4];

VGAManager display1(
    clkVGA,
    rst,
    textGraphics, 
    row,
    col,
    vgaRead,
    
    r,g,b,
    hs,vs
);

assign __inGraphics = inGraphics;
assign __addrGraphics = addrGraphics;
assign __vgaRead = vgaRead;

// ps2 keyboard

wire keybufReady, keybufOverflow;

ps2_keyboard keyboard(
    clkCPU,
    rst,
    ps2_clk,
    ps2_data,
    ~(memRead & (phyAddr == 32'h02000000)),
    inData4[7:0],
    keybufReady,
    keybufOverflow
);

// serial port
reg tx_en;
// Input
wire [15:0] rx_data_out; 
wire [7:0] tx_data_in;
wire rx_en = ~tx_en;
wire send_Done;
wire read = memRead && (phyAddr == 32'h02000005);
wire write = memWrite && (phyAddr == 32'h02000005);

assign tx_data_in = outData;

s_port_r spr(
    .clk_100mhz(clkCPU),
    .RSTn(rst),
    .read(read),
    .EN(rx_en),
    .rx_PIN_in(uart_rx),
    .send_Done(send_Done),
    .data_out(rx_data_out)
);

// Output

s_port_t spt(
    .clk_100mhz(clkCPU),
    .RSTn(rst),
    .data(tx_data_in),
    .EN(tx_en),
    .write(write),
    .tx_PIN_out(uart_tx),
    .send_Done(send_Done)
);

initial begin
    tx_en = 0;
end

always @ (posedge clk) begin
    tx_en = memWrite && (phyAddr == 32'h02000004) ? outData[0] : tx_en;
end 

// In Data

assign inData = phyAddr < 2048 ? inData0 : (
                phyAddr < 10240 ? inData1 : (
                phyAddr < 256000 ? inData2 : (
                phyAddr < 257920 ? inData3 : (
                phyAddr == 257920 ? {31'b0, mode} : (
                phyAddr == 32'h02000000 ? {~keybufReady, 23'b0, inData4[7:0]} : (
                //phyAddr == 32'h02000004 ? {31'b0, spr_ready} : (
                phyAddr == 32'h02000005 ? {16'b0, rx_data_out} : (
                phyAddr == 32'h00500001 ? counter : (
                phyAddr == 32'h02000006 ? {31'h0,send_Done} : (          
                32'b0
                )))))))));

assign led[7] = tx_en;
assign led[6] = send_Done;

// Debug

reg [31:0] displaydata;
wire [31:0] __IR, __PC;

Mux32b4p pickIR(irID, irEX, irMEM, irWB, switch[1:0], __IR);
Mux32b4p pickPC(pcID, pcEX, pcMEM, pcWB, switch[1:0], __PC);

always @ (posedge clk)
    displaydata = switch[13]
        ? switch[12]
            ? __d3
            : (switch[11] ? __IR : __PC)
        : switch[12]
            ? ((inGraphics != 0) ? addrGraphics : displaydata) 
            : ((addrGraphics == 32'h0001e0a0) ? inGraphics : displaydata); 

GPU0 gpu0(
    .clk(clk),
    .clk_shift(clk14),
    .clk_flush(clk25),
    .mode(switch[10]),
    .displaydata(displaydata),
    .gpudata(64'h41_42_43_44_45_46_47_48),
    
    .seg_clk(seg_clk),
    .seg_clrn(seg_clrn),
    .seg_sout(seg_sout),
    .seg_pen(seg_pen),
    
    .__gpudata(gpudata)
);

/*
Display display(
    .clk(clkCPU),
    .rst(rst),
    .Start(clkDiv[14]),
    .Text(switch[9]),
    .flash(clkDiv[25]),
    .Hexs(displaydata),
    .point({8{switch[8]}}),
    .LES({8{switch[7]}}),
    .segclk(seg_clk),
    .segsout(seg_sout),
    .SEGEN(seg_pen),
    .segclrn(seg_clrn)
);
*/

// Debug

assign __mode = mode;
assign __inText = inText;
assign __quwei = {qu, wei};

wire [31:0] segx;
ToSeg swt0(clkCPU, __pc[ 5: 2], segx[ 7: 0]);
ToSeg swt1(clkCPU, __pc[ 9: 6], segx[15: 8]);
ToSeg swt2(clkCPU, inData4[ 3: 0], segx[23:16]);
ToSeg swt3(clkCPU, inData4[ 7: 4], segx[31:24]);

Display4 out1(
	clkCPU,
	segx,
	addr,
	segment
);

endmodule
