`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 14:43:38
// Design Name: 
// Module Name: tx_control_module
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


module tx_control_module(
    input CLK,
    input RSTn,
    input tx_En,
    input [7:0] tx_data,
    input BPS_send,
    output tx_done,
    output tx_PIN_out
    );
    
    reg [3:0] i;
    reg rTX;
    reg isDone;
    initial begin
        i = 0;isDone = 0; rTX = 0;
        
    end
    
    always @ (posedge CLK or negedge RSTn)
        if(!RSTn) begin
            rTX <= 1'b0;
            i <= 4'd0;
            isDone <= 1'b0;
        end
        else if (tx_En)
            case(i)
                4'd0:
                    if(BPS_send) begin  rTX <= 1'b0;i <= i + 1'b1; end  //begin bit
                4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8:
                    if(BPS_send) begin rTX <= tx_data[i-1];i <= i + 1'b1;  end
                4'd9:
                    if(BPS_send) begin  rTX<=1'b1;i<=i+1'b1; end //parity bit
                4'd10:
                    if(BPS_send) begin  rTX <= 1'b1;i<=i+1'b1;end
                4'd11:
                    begin  isDone <= 1'b1;i<=i+1'b1;end    
                4'd12:
                    begin i<=4'd0; isDone <= 1'b0; end
           endcase
              
    assign tx_PIN_out = rTX;
    assign tx_done = isDone;  
endmodule
