module AsciiToSeg(
    input clk,
    input [7:0] code,
    output reg [7:0] segment
);
always @ (posedge clk) begin
	case (code)
		8'h20 : segment = 8'b11111111;		// space
		8'h30 : segment = 8'b11000000;		// 0
		8'h31 : segment = 8'b11111001;		// 1
		8'h32 : segment = 8'b10100100;		// 2
		8'h33 : segment = 8'b10110000;		// 3
		8'h34 : segment = 8'b10011001;		// 4
		8'h35 : segment = 8'b10010010;		// 5
		8'h36 : segment = 8'b10000010;		// 6
		8'h37 : segment = 8'b11111000;		// 7
		8'h38 : segment = 8'b10000000;		// 8
		8'h39 : segment = 8'b10010000;		// 9
		8'h41 : segment = 8'b10001000;		// A
		8'h42 : segment = 8'b10000011;		// b
		8'h43 : segment = 8'b11000110;		// C
		8'h44 : segment = 8'b10100001;		// d
		8'h45 : segment = 8'b10000110;		// E
		8'h46 : segment = 8'b10001110;		// F
		8'h47 : segment = 8'b11000010;		// G
		8'h48 : segment = 8'b10001001;		// H
		8'h49 : segment = 8'b11110000;		// I
		8'h4a : segment = 8'b11100000;		// J
		8'h4b : segment = 8'b10000111;		// K
		8'h4c : segment = 8'b11000111;		// L
		8'h4d : segment = 8'b10001000;		// M
		8'h4e : segment = 8'b10101011;		// N
		8'h4f : segment = 8'b10100011;		// O
		8'h50 : segment = 8'b10001100;		// P
		8'h51 : segment = 8'b10011000;		// Q
		8'h52 : segment = 8'b10101111;		// R
		8'h53: segment = 8'b10010010;		// S
		8'h54 : segment = 8'b10001111;		// T
		8'h55 : segment = 8'b11100011;		// U
		8'h56 : segment = 8'b11100011;		// V
		8'h57 : segment = 8'b10000001;		// W
		8'h58 : segment = 8'b01111111;		// X *
		8'h59 : segment = 8'b10010001;		// Y
		8'h5a : segment = 8'b10100100;		// Z
		default : segment = 8'b01111111;
	endcase
end
    
endmodule

module ToSeg(
	input clk,
	input [3:0] code,
	output reg [7:0] segment
	);
	// ʵǸROM

always @ (posedge clk) begin
	case (code)
		4'b0000 : segment = 8'b11000000;		// 0
		4'b0001 : segment = 8'b11111001;		// 1
		4'b0010 : segment = 8'b10100100;		// 2
		4'b0011 : segment = 8'b10110000;		// 3
		4'b0100 : segment = 8'b10011001;		// 4
		4'b0101 : segment = 8'b10010010;		// 5
		4'b0110 : segment = 8'b10000010;		// 6
		4'b0111 : segment = 8'b11111000;		// 7
		4'b1000 : segment = 8'b10000000;		// 8
		4'b1001 : segment = 8'b10010000;		// 9
		4'b1010 : segment = 8'b10001000;		// A
		4'b1011 : segment = 8'b10000011;		// b
		4'b1100 : segment = 8'b11000110;		// C
		4'b1101 : segment = 8'b10100001;		// d
		4'b1110 : segment = 8'b10000110;		// E
		4'b1111 : segment = 8'b10001110;		// F
		default : segment = 8'b11111111;
	endcase
end
endmodule

module Display4(
	input clk,
	input [31:0] data,
	output reg [3:0] node,
	output reg [7:0] code
	);

reg [15:0] cnt;
	
always @ (negedge clk) begin
	cnt <= cnt + 1;
end
	
always @(posedge clk) begin
	case (cnt[15:14])
		2'b00 : begin
			node <= 4'b1110;			//1st element
			code <= data[7:0];
			end
		2'b01 : begin
			node <= 4'b1101;			//2nd element
			code <= data[15:8];
			end
		2'b10 : begin
			node <= 4'b1011;			//3rd element
			code <= data[23:16];
			end
		2'b11 : begin
			node <= 4'b0111;			//4th element
			code <= data[31:24];
			end
	endcase
end

endmodule

module SEG_DRV(
	input wire start,
	input wire clk,
	input wire [63:0] D,
	output wire finish,
	output wire ser_out
);
	wire S,R;
	wire S_L;
	wire [64:0]Q;
	assign ser_out = Q[0];
	assign finish = &(Q[64:1]);
	assign R = ~finish;
    assign S = start & finish;
    	
	//ShfitReg65b reg1(clk,S_L,{1'b0,D},Q);
	SR_latch sr(.S(S),.R(R),.Q(S_L));
	
	reg [64:0] q;
	assign Q = q;
	
	initial begin
	   q = 0;
	end
	
    always @ (posedge clk)
    begin
        q = S_L ? {1'b0, D} : {1'b1, q[64:1]};
    end

endmodule

module Debug(
	input wire clk_div,
	input wire clk_flush,
	input wire [63:0] code,
	output SEGCLK, 
	output SEGCLR,
	output SEGDT,
	output SEGEN,
	output finish
);

assign SEGCLK = finish | clk_div;
assign SEGCLR = 1'b1;
assign SEGEN = 1'b1;

reg last;
reg tick;
reg cur;

wire [63:0] t;

assign t = {
	code[ 0], code[ 1], code[ 2], code[ 3], code[ 4], code[ 5], code[ 6], code[ 7], code[ 8], code[ 9],
	code[10], code[11], code[12], code[13], code[14], code[15], code[16], code[17], code[18], code[19],
	code[20], code[21], code[22], code[23], code[24], code[25], code[26], code[27], code[28], code[29],
	code[30], code[31], code[32], code[33], code[34], code[35], code[36], code[37], code[38], code[39],
	code[40], code[41], code[42], code[43], code[44], code[45], code[46], code[47], code[48], code[49],
	code[50], code[51], code[52], code[53], code[54], code[55], code[56], code[57], code[58], code[59],
	code[60], code[61], code[62], code[63]
};

initial
begin
	last = 0;
	tick = 0;
	cur = 0;
end

always @ (posedge clk_div)
begin
	tick = ~last & clk_flush;
	cur = (~last & clk_flush) ? 1'b1 : (finish ? 1'b0 : cur);
	last = clk_flush;
end

SEG_DRV m9(.start(tick),.clk(clk_div & cur),.D(t),.finish(finish),.ser_out(SEGDT));

endmodule
