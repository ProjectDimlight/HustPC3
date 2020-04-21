`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2019 09:43:39 PM
// Design Name: 
// Module Name: TestMatrix4x4
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


module TestMatrix4x4(

    );
    
reg clk;
reg ready;
wire finish;
wire [7:0] A [3:0][3:0];
wire [7:0] B [3:0][3:0];
wire [7:0] S [3:0][3:0];

wire [127:0] a = {
    A[3][3], A[3][2], A[3][1], A[3][0],
    A[2][3], A[2][2], A[2][1], A[2][0],
    A[1][3], A[1][2], A[1][1], A[1][0],
    A[0][3], A[0][2], A[0][1], A[0][0]
};

wire [127:0] b = {
    B[3][3], B[3][2], B[3][1], B[3][0],
    B[2][3], B[2][2], B[2][1], B[2][0],
    B[1][3], B[1][2], B[1][1], B[1][0],
    B[0][3], B[0][2], B[0][1], B[0][0]
}; 

assign A[0][0] = 1; assign A[0][1] = 2; assign A[0][2] = 3; assign A[0][3] = 4;
assign A[1][0] = 2; assign A[1][1] = 3; assign A[1][2] = 4; assign A[1][3] = 1;
assign A[2][0] = 3; assign A[2][1] = 4; assign A[2][2] = 1; assign A[2][3] = 2;
assign A[3][0] = 4; assign A[3][1] = 0; assign A[3][2] = 2; assign A[3][3] = 3;

assign B[0][0] = 1; assign B[0][1] = 1; assign B[0][2] = 1; assign B[0][3] = 1;
assign B[1][0] = 1; assign B[1][1] = 1; assign B[1][2] = 1; assign B[1][3] = 1;
assign B[2][0] = 1; assign B[2][1] = 1; assign B[2][2] = 1; assign B[2][3] = 1;
assign B[3][0] = 1; assign B[3][1] = 1; assign B[3][2] = 1; assign B[3][3] = 1; 

wire [127:0] s;
assign S[0][0] = s[  7:  0]; assign S[0][1] = s[ 15:  8]; assign S[0][2] = s[ 23: 16]; assign S[0][3] = s[ 31: 24];
assign S[1][0] = s[ 39: 32]; assign S[1][1] = s[ 47: 40]; assign S[1][2] = s[ 55: 48]; assign S[1][3] = s[ 63: 56];
assign S[2][0] = s[ 71: 64]; assign S[2][1] = s[ 79: 72]; assign S[2][2] = s[ 87: 80]; assign S[2][3] = s[ 95: 88];
assign S[3][0] = s[103: 96]; assign S[3][1] = s[111:104]; assign S[3][2] = s[119:112]; assign S[3][3] = s[127:120];

Matrix4x4Mul mul(clk, a, b, ready, finish, s);

initial begin
    clk = 0;
    ready = 1;
    #1;
    ready = 0;
end

always begin
    clk = 1;
    #0.5;
    clk = 0;
    #0.5;
end
    
endmodule
