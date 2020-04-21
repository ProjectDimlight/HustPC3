`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:26:50 12/25/2017 
// Design Name: 
// Module Name:    SR_latch 
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
module SR_latch(
	input wire S,
	input wire R,
	output wire Q
    );
	wire a1,a2;
	
	NOR2 no1(.I0(S),.I1(a2),.O(a1));
	NOR2 no2(.I0(R),.I1(a1),.O(a2));
	assign Q = a2;

endmodule
