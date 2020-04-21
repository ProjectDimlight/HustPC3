`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 22:32:08
// Design Name: 
// Module Name: rx_control_module
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


module rx_control_module(
    input CLK,
    input RSTn,
    input rx_En,
    input BPS_sampling,
    input rx_PIN_in,
    input H2L_sig,
    
    output Count_sig,
    output[7:0] rx_out,
    output rx_done
    );
    
    reg [3:0] i;
    reg [7:0] rData;
    reg isDone,isCount;
    
    initial begin
        i <= 0;
        isDone <= 0;
        isCount <= 0;
        rData <= 0;
    end
    
    always@(posedge CLK or negedge RSTn)
        if (!RSTn)begin
            isCount <= 1'b0;
            isDone  <= 1'b0;
            rData <= 8'd0;
            i <= 4'd0;
        end
        else if (rx_En)
            case(i)
            4'd0:
                if (H2L_sig) begin i <= i+1'b1; isCount <= 1'b1; end
            4'd1:
                if ( BPS_sampling) begin i <= i+1'b1;end
            4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
                 if( BPS_sampling ) begin i <= i+1'b1; rData[i-2] <= rx_PIN_in; end
            4'd10:
                if(BPS_sampling) begin i <= i + 1'b1; end  //parity bit
            4'd11: 
                if (BPS_sampling) begin i <= i + 1'b1; end      //end bit
            4'd12:
                begin i <= i + 1'b1; isCount = 1'b0; isDone <= 1'b1; end
            4'd13:
                begin i <= 0; isDone <= 1'b0; end
            endcase
        
        assign Count_sig = isCount;
        assign rx_out = rData;
        assign rx_done = isDone;

endmodule