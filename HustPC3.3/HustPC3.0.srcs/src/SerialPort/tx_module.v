`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 14:43:19
// Design Name: 
// Module Name: tx_module
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


module tx_module(
    input CLK,
    input RSTn,
    input [7:0] tx_data,
    input tx_En,
    output tx_PIN_out,
    output tx_done
    );
    
    wire BPS_send;
    tx_bps_module tx_bps(CLK,RSTn,tx_En,BPS_send);
    tx_control_module tx_control(CLK,RSTn,tx_En,tx_data,BPS_send,tx_done,tx_PIN_out);
endmodule
