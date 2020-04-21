`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 14:43:58
// Design Name: 
// Module Name: tx_bps_module
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


module tx_bps_module(
    input CLK,
    input RSTn,
    input Count_sig,
    output BPS_send
    );
    
    reg [13:0] Count_reg;
    
    always @(posedge CLK or negedge RSTn)
        if(!RSTn)
            Count_reg <= 14'd0;
        else if(Count_reg == 14'd10417)   //9600bps 100mhz
            Count_reg <= 0;
        else if(Count_sig)
            Count_reg <= Count_reg + 1'b1;
        else 
            Count_reg <= 0;
    
    assign BPS_send = (Count_reg == 14'd5208)?1'b1:1'b0;
endmodule
