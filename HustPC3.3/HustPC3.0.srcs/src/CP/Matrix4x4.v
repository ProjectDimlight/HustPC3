// Systolic 脉动阵列矩阵乘法
module Matrix4x4Mul(
    input clk,
    input [127:0] a,
    input [127:0] b,
    input ready,
    output reg finish,
    output [127:0] s
);

reg [1:0] state;
reg [7:0] cnt;

wire [7:0] A [3:0][3:0];
wire [7:0] B [3:0][3:0];
reg  [7:0] S [3:0][3:0];

// 输入格式转换
// 目前的Verilog不支持数组式输入
// 故转化为 4*4*8=128 位排线

assign A[0][0] = a[  7:  0]; assign A[0][1] = a[ 15:  8]; assign A[0][2] = a[ 23: 16]; assign A[0][3] = a[ 31: 24];
assign A[1][0] = a[ 39: 32]; assign A[1][1] = a[ 47: 40]; assign A[1][2] = a[ 55: 48]; assign A[1][3] = a[ 63: 56];
assign A[2][0] = a[ 71: 64]; assign A[2][1] = a[ 79: 72]; assign A[2][2] = a[ 87: 80]; assign A[2][3] = a[ 95: 88];
assign A[3][0] = a[103: 96]; assign A[3][1] = a[111:104]; assign A[3][2] = a[119:112]; assign A[3][3] = a[127:120];

assign B[0][0] = b[  7:  0]; assign B[0][1] = b[ 15:  8]; assign B[0][2] = b[ 23: 16]; assign B[0][3] = b[ 31: 24];
assign B[1][0] = b[ 39: 32]; assign B[1][1] = b[ 47: 40]; assign B[1][2] = b[ 55: 48]; assign B[1][3] = b[ 63: 56];
assign B[2][0] = b[ 71: 64]; assign B[2][1] = b[ 79: 72]; assign B[2][2] = b[ 87: 80]; assign B[2][3] = b[ 95: 88];
assign B[3][0] = b[103: 96]; assign B[3][1] = b[111:104]; assign B[3][2] = b[119:112]; assign B[3][3] = b[127:120];

// 输出格式转换
assign s = {
    S[3][3], S[3][2], S[3][1], S[3][0],
    S[2][3], S[2][2], S[2][1], S[2][0],
    S[1][3], S[1][2], S[1][1], S[1][0],
    S[0][3], S[0][2], S[0][1], S[0][0]
};

// 使用了MUX选择每一次计算采用的输入，而非串联寄存器“流”
// 是因为MUX的实现成本比寄存器低

// 寄存器组需要 (10  +  7)  × 4   /2 × 2 = 68 个寄存器。
//             上底   下底    高      行/列

// 而本方案只需要4×4×2 = 32个4路MUX。

integer i, j;

initial begin
    state = 2'b10;
    finish = 1'b1;
end

always @ (posedge clk)
begin
    case (state)
    2'b00: begin
        // 初始化
        for (i = 0; i < 4; i = i + 1)
            for (j = 0; j < 4; j = j + 1)
                S[i][j] = 0;
        cnt = 4'd0;
        state = 2'b01;
    end
    2'b01: begin
        // 执行更新
        for (i = 0; i < 4; i = i + 1)
            for (j = 0; j < 4; j = j + 1)
                S[i][j] = S[i][j] + (
                    // 判断是否在边界内
                    // 使用MUX选择当前周期应该算哪个位置
                    (0 <= cnt - i - j) && (cnt - i - j < 4)
                        ? A[i][cnt - i - j] * B[cnt - i - j][j]  // 单周期阵列乘法
                        : 0
                );
        
        // 状态跳转
        // 一共需要运算12个时钟周期，才能使得整个矩阵“通过”阵列
        state = state + (cnt == 4'd11);
        cnt = cnt + 4'd1;
    end
    2'b10: begin
        // 待机
        state = ready ? 2'b00 : state;
        finish = ready ? 1'b0 : 1'b1;
    end 
    endcase
end

endmodule
