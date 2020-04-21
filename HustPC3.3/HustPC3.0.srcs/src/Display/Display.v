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
module    Display64(input clk,			//	ʱ��
						input rst,			//��λ
						input Start,		//����ɨ������
						input Text,			//�ı�(16����)/ͼ��(����)�л�
						input flash,		//�߶�����˸Ƶ��
						input[31:0]Hexs,	//32λ����ʾ��������
						input[7:0]point,	//�߶���С���㣺8��
						input[7:0]LES,		//�߶���ʹ�ܣ�=1ʱ��˸
						
						output seg_clk,	//������λʱ��
						output seg_sout,	//�߶���ʾ����(�������)
						output SEG_PEN,	//�߶�����ʾˢ��ʹ��
						output seg_clrn	//�߶�����ʾ����
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
