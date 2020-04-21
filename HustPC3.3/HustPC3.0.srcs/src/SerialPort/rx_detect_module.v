`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 22:32:08
// Design Name: 
// Module Name: rx_detect_module
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


module rx_detect_module(
    input CLK,
    input RSTn,
    input rx_in,
    output H2L_sig
    );
    
    reg H2L_1,H2L_2;
    always @(posedge CLK or negedge RSTn)
        if(!RSTn) begin
            H2L_1 <= 1'b1;
            H2L_2 <= 1'b1;
        end
        else begin
            H2L_2 <= H2L_1;
            H2L_1 <= rx_in;
        end
        
    assign H2L_sig = !H2L_1 & H2L_2;
endmodule
