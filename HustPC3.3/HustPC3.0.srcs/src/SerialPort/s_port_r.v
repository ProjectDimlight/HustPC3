`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/08 15:33:16
// Design Name: 
// Module Name: s_port_r
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


module s_port_r(
    input clk_100mhz,
    input RSTn,
    input read,
    input EN,
    input rx_PIN_in,
    input send_Done,
    output [15:0]data_out,
    output [31:0] data_test,
    output [4:0]r_wptr,
    output [4:0]r_rptr
    );
    reg [15:0] data;
    reg rx_EN;
    wire rx_done;
    wire[7:0] rx_out;
    reg [4:0]w_ptr,r_ptr;
    reg[7:0] FIFO[32:0];
    wire ready,full;
    
  rx_module rx(
        .clk_100mhz(clk_100mhz),
        .RSTn(RSTn),
        .rx_PIN_in(rx_PIN_in),
        .rx_En(rx_EN),
        .rx_done(rx_done),
        .rx_out(rx_out)
        );
        
    initial begin
        r_ptr = 0;
        w_ptr = 0;
    end
    
    always@(posedge clk_100mhz) begin
        rx_EN = EN;
        if(RSTn == 0) begin
            w_ptr <= 0;
            r_ptr <= 0;
        end 
        if(read)begin
            data <= ready?{FIFO[r_ptr+1],FIFO[r_ptr]}:16'h0000;
            r_ptr <= ready?r_ptr + 5'd2:r_ptr;
        end
        if(rx_done && (w_ptr + 1'b1 != r_ptr) && (w_ptr + 2'd2 != r_ptr)) begin
            FIFO[w_ptr] <= rx_out;
            w_ptr <= w_ptr + 5'd1;
        end
         
    end
  
    assign ready = (r_ptr != w_ptr) && (r_ptr + 1 != w_ptr);     
    assign data_out = data;
    assign data_test = {FIFO[3],FIFO[2],FIFO[1],FIFO[0]};
    assign r_wptr = w_ptr;
    assign r_rptr = r_ptr;
endmodule
