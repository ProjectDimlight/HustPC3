`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:15:27 04/10/2018 
// Design Name: 
// Module Name:    ClkDiv 
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
module ClkDiv(
	input clk,
	output [63:0] clkdiv
);

reg [62:0] cnt;

assign clkdiv = {cnt, clk};

initial begin
	cnt = 0;
end

always @ (posedge clk)
begin
	cnt = cnt + 1;
end

endmodule
