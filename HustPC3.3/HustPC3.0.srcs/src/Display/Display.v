`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:11:21 03/12/2018 
// Design Name: 
// Module Name:    Display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module    Display64(input clk,			//	时钟
						input rst,			//复位
						input Start,		//串行扫描启动
						input Text,			//文本(16进制)/图型(点阵)切换
						input flash,		//七段码闪烁频率
						input[31:0]Hexs,	//32位待显示输入数据
						input[7:0]point,	//七段码小数点：8个
						input[7:0]LES,		//七段码使能：=1时闪烁
						
						output seg_clk,	//串行移位时钟
						output seg_sout,	//七段显示数据(串行输出)
						output SEG_PEN,	//七段码显示刷新使能
						output seg_clrn	//七段码显示汪零
						);
		wire [63:0]SEG_TXT;
		wire [63:0]SEGMENT;
		wire [63:0]Seg_map;
		
		HexTo8SEG SM1(.flash(flash),
						  .Hexs(Hexs),
						  .points(points),
						  .LES(LES),
						  .SEG_TXT(SEG_TXT)
						  );
		
		P2S SM2(.clk(clk),
				  .rst(rst),
				  .Start(Start),
				  .PData(SEGMENT),
				  .sclk(seg_clk),
				  .sout(seg_sout),
				  .EN(SEG_PEN),
				  .sclrn(seg_clrn)
				  );
		
		SegMap SM3(.Disp_num({Hexs[31:0],Hexs[31:0]}),
					  .Seg_map(Seg_map)
					 );
		
		MUX2T1_64 M0(.sel(Text),
					    .a(SEG_TXT),
						 .b(Seg_map),
						 .o(SEGMENT)
						 );
endmodule
