`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:05:31 10/29/2022 
// Design Name: 
// Module Name:    im 
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
module im(
	input [31:0] pc,
	output [31:0] instruct
);
	reg [31:0] mem[0:4095]; //定义寄存器阵列
	initial begin
		$readmemh("code.txt", mem); //初始化 //实质减去一个差值
		//$display("%h", mem[0]);
		//$display("%h", mem[1]);
		//$display("%h", mem[2]);
		//$display("%h", mem[3]);
	end
	assign instruct = mem[(pc - 32'h0000_3000) >> 2]; //输出结果//存储范围有限，要加入一场处理
	//always@(*) begin
		//$display("mem is %h, pc is %h, pc - 32'h0000_3000 is ", mem[pc - 32'h0000_3000], pc, pc - 32'h0000_3000);
	//end
endmodule 