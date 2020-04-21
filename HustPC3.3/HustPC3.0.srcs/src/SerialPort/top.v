`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/24 23:32:34
// Design Name: 
// Module Name: top
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


module top(
    input wire RSTN,
    input wire uart_rx,
    input wire clk_200mhz_p,
    input wire clk_200mhz_n,
    input wire [15:0] SW,
    output reg [7:0] LED,
    output wire SEGCLK,
    output wire SEGDT,
    output wire SEGEN,
    output wire SEGCLR,
    output wire uart_tx
    );
    
    wire [15:0] SW_OK;
    reg former,current,sent;
    initial begin
        LED = 8'b10100101;
        former = 0;
        current = 0;
        sent = 0;
    end
    
    wire clk_200mhz;
    IBUFDS clk_200m_buf (.O(clk_200mhz), .I(clk_200mhz_p), .IB(clk_200mhz_n));
    
    reg clk_100mhz = 0;                
    always @ (posedge clk_200mhz)
        clk_100mhz <= !clk_100mhz;
    
    wire clk_100m;
    wire [31:0] Div,Disp_num;
    clk_div U4(
            .clk(clk_100mhz),
            .rst(),
            .SW2(0),
            .clkdiv(Div),
            .Clk_CPU(clk_100m)
    );
    
        SAnti_jitter U1(.clk(clk_100mhz), 
                    .RSTN(RSTN),
                    .readn(),
                    .Key_y(),
                    .Key_x(),
                    .SW(SW), 
                    .Key_out(),
                    .Key_ready(),
                    .pulse_out(),
                    .BTN_OK(),
                    .SW_OK(SW_OK),
                    .CR(),
                    .rst()
                     );
    wire [31:0] test;
    Display U3(
            .clk(clk_100mhz),
            .rst(~RSTN),
            .Start(Div[10]),
            .Text(1'b1),
            .flash(0),
            .Hexs(Disp_num),
            .point(0),
            .LES(0),
            .segclk(SEGCLK),
            .segsout(SEGDT),
            .SEGEN(SEGEN),
            .segclrn(SEGCLR)
        );
        
        wire H2L;
        
        assign H2L = former & !current;
        
        wire [7:0] rx_out;
        wire [7:0] tx_data;
        wire tx_Enable;
        wire send_Done;
        wire read,write;
        reg last_14,last_13;
        wire[5:0] t_rptr,t_wptr,r_rptr,r_wptr;
        initial begin
            last_14 = 0;
            last_13 = 0;
        end
        always@(posedge clk_100mhz)begin
            last_14 = SW_OK[14];
            last_13 = SW_OK[13]; 
        end
        assign write = ~last_14 & SW_OK[14];
        assign read = ~last_13 & SW_OK[13];
        assign tx_data = SW_OK[12:5];
         wire [7:0] test2;
        assign tx_Enable = SW_OK[15];
        assign Disp_num = SW_OK[1]?test:{2'b00,r_wptr,2'b00, r_rptr,8'h00 ,rx_out};
        
    s_port_r U17_1(
            .clk_100mhz(clk_100mhz),
            .RSTn(1),
            .read(read),
            .EN(tx_Enable),
            .rx_PIN_in(uart_rx),
            .send_Done(send_Done),
            .data_out(rx_out),
            .r_wptr(r_wptr),
            .r_rptr(r_rptr),
            .data_test(test)
        );
        
        s_port_t U17_2(
            .clk_100mhz(clk_100mhz),
            .RSTn(1),
            .data(tx_data),
            .EN(~tx_Enable),
            .write(write),
            .tx_PIN_out(uart_tx),
            .send_Done(send_Done)
            );
       always @ *
            LED <= rx_out;
         
endmodule
