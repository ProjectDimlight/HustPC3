`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:52 12/25/2017 
// Design Name: 
// Module Name:    ShfitReg8b 
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
module ShfitReg8b(
    input wire clk, S_L, S_In,
	 input wire [7:0] P_In,
	 output wire [7:0] Q);
	  
	 wire A1, A2, A3, A4, A5, A6, A7, A8;
	 wire B1, B2, B3, B4, B5, B6, B7, B8;
	 wire C1, C2, C3, C4, C5, C6, C7, C8;
	 wire N_S_L;
	 
	 FD #( .INIT(1'b0) ) XLXI_1 (.C(clk), 
			 .D(C1), 
			 .Q(Q[7]));
	 INV  Not (.I(S_L), 
					  .O(N_S_L)); 
	 AND2  And1 (.I0(S_In), 
						 .I1(N_S_L), 
						 .O(A1));
	 AND2  And2 (.I0(P_In[7]), 
						 .I1(S_L), 
						 .O(B1));
	 OR2  Or1 (.I0(A1), 
						.I1(B1), 
						.O(C1));
	//Q[7]
	 FD #( .INIT(1'b0) ) XLXI_2 (.C(clk), 
			 .D(C2), 
			 .Q(Q[6]));
	 AND2  And3 (.I0(Q[7]), 
						 .I1(N_S_L), 
						 .O(A2));
	 AND2  And4 (.I0(P_In[6]), 
						 .I1(S_L), 
						 .O(B2));
	 OR2  Or2  (.I0(A2), 
						.I1(B2), 
						.O(C2));
	//Q[6]
	FD #( .INIT(1'b0) ) XLXI_3 (.C(clk), 
			.D(C3), 
			.Q(Q[5]));
	 AND2  And5 (.I0(Q[6]), 
						 .I1(N_S_L), 
						 .O(A3));
	 AND2  And6 (.I0(P_In[5]), 
						 .I1(S_L), 
						 .O(B3));
	 OR2  Or3 (.I0(A3), 
						.I1(B3), 
						.O(C3));
	//Q[5]
	FD #( .INIT(1'b0) ) XLXI_4 (.C(clk), 
			 .D(C4), 
			 .Q(Q[4]));
	 AND2  And7 (.I0(Q[5]), 
						 .I1(N_S_L), 
						 .O(A4));
	 AND2  And8 (.I0(P_In[4]), 
						 .I1(S_L), 
						 .O(B4));
	 OR2  Or4 (.I0(A4), 
						.I1(B4), 
						.O(C4));
	//Q[4]
	FD #( .INIT(1'b0) ) XLXI_5 (.C(clk), 
			 .D(C5), 
			 .Q(Q[3]));
	 AND2  And9 (.I0(Q[4]), 
						 .I1(N_S_L), 
						 .O(A5));
	 AND2  And10 (.I0(P_In[3]), 
						 .I1(S_L), 
						 .O(B5));
	 OR2  Or5 (.I0(A5), 
						.I1(B5), 
						.O(C5));
	//Q[3]
		FD #( .INIT(1'b0) ) XLXI_6 (.C(clk), 
			 .D(C6), 
			 .Q(Q[2]));
	 AND2  And11 (.I0(Q[3]), 
						 .I1(N_S_L), 
						 .O(A6));
	 AND2  And12 (.I0(P_In[2]), 
						 .I1(S_L), 
						 .O(B6));
	 OR2  Or6 (.I0(A6), 
						.I1(B6), 
						.O(C6));
	//Q[2]
		FD #( .INIT(1'b0) ) XLXI_7 (.C(clk), 
			 .D(C7), 
			 .Q(Q[1]));
	 AND2  And13 (.I0(Q[2]), 
						 .I1(N_S_L), 
						 .O(A7));
	 AND2  And14 (.I0(P_In[1]), 
						 .I1(S_L), 
						 .O(B7));
	 OR2  Or7 (.I0(A7), 
						.I1(B7), 
						.O(C7));
	//Q[1]
		FD #( .INIT(1'b0) ) XLXI_8 (.C(clk), 
			 .D(C8), 
			 .Q(Q[0]));
	 AND2  And15 (.I0(Q[1]), 
						 .I1(N_S_L), 
						 .O(A8));
	 AND2  And16 (.I0(P_In[0]), 
						 .I1(S_L), 
						 .O(B8));
	 OR2  Or8 (.I0(A8), 
						.I1(B8), 
						.O(C8));			
	 
endmodule
