`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/08 16:22:36
// Design Name: 
// Module Name: s_port_t
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


module s_port_t(
        input clk_100mhz,
        input RSTn,
        input [7:0] data,
        input EN,
        input write,
        output tx_PIN_out,
        output send_Done
    );
    reg tx_En;
    wire done;
    reg [7:0] FIFO[31:0];
    reg [4:0]w_ptr,r_ptr;
    reg [7:0]tx_in_data;
    reg can_send;
    
    tx_module tx(
        .CLK(clk_100mhz),
        .RSTn(RSTn),
        .tx_data(tx_in_data),
        .tx_En(tx_En),
        .tx_PIN_out(tx_PIN_out),
        .tx_done(done)
        );
        
    initial begin
        w_ptr = 0;
        r_ptr = 0;
        can_send = 1;
    end    
        
    always@(posedge clk_100mhz) begin
        if(RSTn==0)begin
            w_ptr <= 0;
            r_ptr <= 0;
            can_send = 1;
        end
        if(write && EN)begin
            FIFO[w_ptr] <= data;
            w_ptr <= w_ptr + 5'd1;
        end
        if(done)
            can_send <= 1;
        if(((done && (w_ptr == r_ptr))) || (done && (EN == 0)))begin
           tx_En <= 0; 
        end
        if(can_send && EN && (w_ptr!=r_ptr))begin
            tx_in_data <= FIFO[r_ptr];
            r_ptr <= r_ptr + 5'd1;
            tx_En <= 1;
            can_send <= 0;
        end
    end    
  
    assign send_Done = w_ptr == r_ptr;
    assign t_wptr = w_ptr;
    assign t_rptr = r_ptr;
    assign wt_data = {FIFO[0],FIFO[1],FIFO[2],FIFO[3]};
    assign sd_data = tx_in_data;
endmodule
