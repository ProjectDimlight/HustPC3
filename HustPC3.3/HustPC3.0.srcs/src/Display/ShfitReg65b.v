`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:28 12/26/2017 
// Design Name: 
// Module Name:    ShfitReg65b 
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
module ShfitReg65b(
		input wire clk,
		input wire S_L,
		input wire [64:0] p_in,
		output wire [64:0] Q
    );
	 wire S_L_bar,A1,B1,C1,or_in1,or_in2;
	 
    assign S_L_bar = ~S_L;

	 FD #( .INIT(1'b0) ) XLXI_1 (.C(clk), 
			.D(C1), 
			 .Q(Q[64]));
	 AND2  And1 (.I0(S_L==1?1'b0:1'b1), 
						 .I1(S_L_bar), 
						 .O(A1));
	 AND2  And2 (.I0(p_in[64]), 
						 .I1(S_L), 
						 .O(B1));
	 OR2  Or1 (.I0(A1), 
						.I1(B1), 
						.O(C1));
	ShfitReg8b m0 (clk, S_L, Q[64],p_in[63:56],Q[63:56]);
	ShfitReg8b m1 (clk, S_L, Q[56],p_in[55:48],Q[55:48]);
	ShfitReg8b m2 (clk, S_L, Q[48],p_in[47:40],Q[47:40]);
	ShfitReg8b m3 (clk, S_L, Q[40],p_in[39:32],Q[39:32]);
	ShfitReg8b m4 (clk, S_L, Q[32],p_in[31:24],Q[31:24]);
	ShfitReg8b m5 (clk, S_L, Q[24],p_in[23:16],Q[23:16]);
	ShfitReg8b m6 (clk, S_L, Q[16],p_in[15:8],Q[15:8]);
	ShfitReg8b m7 (clk, S_L, Q[8],p_in[7:0],Q[7:0]);

endmodule
