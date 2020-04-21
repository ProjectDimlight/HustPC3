`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:57:35 03/30/2018 
// Design Name: 
// Module Name:    Debounce 
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
module Debounce(
	input clk,
	input btn,
	output reg dbtn
);

reg [7:0] cnt;

initial dbtn = 1'b0;

always @ (posedge clk)
begin
	cnt = {cnt[6:0], btn};
	dbtn = (&cnt & 1) | (|cnt & dbtn);
end

endmodule
