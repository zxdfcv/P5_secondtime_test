`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:36 11/16/2022 
// Design Name: 
// Module Name:    MemOp 
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
module sbgen(
	input [31:0] DMWord,
	input [31:0] RD2, //需要GRF第二个输出
	input [1:0] Byte, //字节选择线
	output reg [31:0] sbData
    );
	integer i;
	always @(*) begin
		sbData[7 : 0] = (Byte == 2'b00) ? RD2[7 : 0] : DMWord[7 : 0];
		sbData[15 : 8] = (Byte == 2'b01) ? RD2[7 : 0] : DMWord[15 : 8];
		sbData[23 : 16] = (Byte == 2'b10) ? RD2[7 : 0] : DMWord[23 : 16];
		sbData[31 : 24] = (Byte == 2'b11) ? RD2[7 : 0] : DMWord[31 : 24];
	end

endmodule

module shgen(
	input [31:0] DMWord,
	input [31:0] RD2, //需要GRF第二个输出
	input Byte_1, //字节选择线
	output reg [31:0] shData
    );
	integer i;
	always @(*) begin
		shData[15 : 0] = (Byte_1 == 1'b0) ? RD2[15 : 0] : DMWord[15 : 0] ;
		shData[31 : 16] = (Byte_1 == 1'b1) ? RD2[15 : 0] : DMWord[31 : 16];
	end
	
endmodule

module lbgen(
	input [31:0] DMWord, //
	input [1:0] Byte, //字节选择线
	output [31:0] lbData
    );
	wire [7:0] low;
	assign low = (Byte == 2'b00) ? DMWord[7:0] : 
						(Byte == 2'b01) ? DMWord[15:8] : 
						(Byte == 2'b10) ? DMWord[23:16] : 
						(Byte == 2'b11) ? DMWord[31:24] : 
					8'h00;//error
	assign lbData = {{24{low[7:7]}}, low};//线路拼接
endmodule

module lbugen(
	input [31:0] DMWord, //
	input [1:0] Byte, //字节选择线
	output [31:0] lbuData
    );
	wire [7:0] low;
	assign low = (Byte == 2'b00) ? DMWord[7:0] : 
						(Byte == 2'b01) ? DMWord[15:8] : 
						(Byte == 2'b10) ? DMWord[23:16] : 
						(Byte == 2'b11) ? DMWord[31:24] : 
					8'h00;//error
	assign lbuData = {24'h00_0000, low};//线路拼接
endmodule

module lhgen(
	input [31:0] DMWord, //
	input Byte_1, //字节选择线
	output [31:0] lhData
    );
	wire [15:0] low;
	assign low = (Byte_1 == 1'b0) ? DMWord[15:0] : 
						(Byte_1 == 1'b1) ? DMWord[31:16] : 
						16'h0000;//error
	assign lhData = {{16{low[15:15]}}, low};//线路拼接
endmodule

module lhugen(
	input [31:0] DMWord, //
	input Byte_1, //字节选择线
	output [31:0] lhuData
   );
	wire [15:0] low;
	assign low = (Byte_1 == 1'b0) ? DMWord[15:0] : 
						(Byte_1 == 1'b1) ? DMWord[31:16] : 
						16'h0000;//error
	assign lhuData = {16'h0000, low};//线路拼接
endmodule