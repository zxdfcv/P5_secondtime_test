//?根据你设计的数据通路架构图以及各个部件模块的输入输出端口，在 datapath.v 中定义一些内部的 wire 型变量，
//利用模块间的逻辑关系，对各个部件模块进行实例化，串接在一起，
//使之成为一个整体，最后预留出控制器信号的输入和输出端口即可。

//这句话相当重要
`include "name.v"

module datapath(
	input clk,
	input reset
);
	
	parameter init = 32'h0000_0000;
	
	wire cmp;//比较结果
	wire [3:0] CMPMode;
	
	wire [31:0] IFPC;
	wire [31:0] IFPC_4;//+4的PC
	wire [31:0] IFPC_8;
	wire [31:0] IFNextPC;
	wire [31:0] IFIR;
	
	wire [31:0] IDPC;
	wire [31:0] IDPC_8;
	wire [31:0] IDIR;
	wire [31:0] IDRD1;
	wire [31:0] IDRD2;
	wire [31:0] IDImm;
	wire [1:0] PCSrc;//控制信号不需要流水前面不加流水线寄存器名称
	wire [1:0] IDRD1Sel;
	wire [1:0] IDRD2Sel;
	//wire [31:0] CMPAF;//选择后的信号
	//wire [31:0] CMPBF;
	wire [1:0] ExtOp;
	//wire [1:0] NPCRD1Sel;
	//wire [31:0] NPCRD1F;
	wire [31:0] IDRD1F;
	wire [31:0] IDRD2F;
	wire IDJUMP;

	
	wire [31:0] EXPC_8;
	wire [31:0] EXPC;
	wire [31:0] EXIR;
	wire [31:0] EXRD1;
	wire [31:0] EXRD2;
	wire [31:0] EXImm;//EX拓展出的立即数
	wire [1:0] ALUSrc;
	wire [3:0] ALUCtrl;
	wire [31:0] ALUB;
	wire [1:0] EXRD1Sel;
	wire [1:0] EXRD2Sel;
	wire [31:0] EXALUOut;
	wire EXRegWrite;
	wire [4:0] EXA3;
	wire [1:0] EXtnew;
	wire [1:0] EXMemtoReg;
	wire [31:0] EXRD1F;
	wire [31:0] EXRD2F;
	wire EXJUMP;
	wire EXlwbti;
	
	wire [31:0] MEMPC_8;
	wire [31:0] MEMPC;
	wire [31:0] MEMIR;
	wire [31:0] MEMRD2;
	wire [1:0] MEMRD2Sel;//写入DM的数据
	wire [31:0] MEMALUOut; //读出的数据要进行流水，加上选择
	wire [31:0] MEMRD;
	wire MemWrite;
	wire MEMRegWrite;
	wire [4:0] MEMA3;
	wire [1:0] MEMtnew;
	wire [1:0] MEMMemtoReg;
	wire [31:0] MEMRD2F;//数据替换成正确的
	wire [3:0] DMMode;
	//最终选择的RD2
	wire MEMJUMP;
	wire MEMlwbti;
	
	wire [31:0] WBPC;
	wire [31:0] WBPC_8;
	wire [31:0] WBIR;//Instr
	wire [31:0] WBALUOut;
	wire [31:0] WBRD;//memdataout
	wire [31:0] WD;//最终写入数据
	wire [4:0] WBA3;
	wire [1:0] WBMemtoReg;
	wire WBRegWrite;
	wire [1:0] WBtnew;
	wire WBJUMP;
	
	wire Stalk; //暂停信号
	wire [1:0] tuse_rs;
	wire [1:0] tuse_rt;
	
	//转发段数据选择
	wire [31:0] EXTRSrc;
	wire [31:0] MEMTRSrc;
	//所以我们转发的目的不应该是仅仅为模块提供正确数据，而应是把 rsOut 和 rtOut 换成正确的
	
	mux4 mux4EXNPCSrc( //选择信号可以用各级的MemtoReg实现
		.x0(init),
		.x1(init),
		.x2(EXPC_8),
		.x3(init),
		.sel(EXMemtoReg),
		.result(EXTRSrc)
	); //提前进行 source的选择
	mux4 mux4MEMNPCSrc(
		.x0(MEMALUOut),
		.x1(init),
		.x2(MEMPC_8),
		.x3(init),
		.sel(MEMMemtoReg),
		.result(MEMTRSrc)//转发段选择
	);
	//mux4 mux4MEMNPCSrc(//可以直接复用WD
	//);

	//IF
	//PCCal~NPC
	//mux4 mux4NPCRD1Sel(
	//.x0(IDRD1),
	//.x1(WD),
	//.x2(MEMTRSrc),//MEM级包含ALUOut和RD
	//.x3(EXTRSrc),
	//.sel(NPCRD1Sel),
	//.result(NPCRD1F)
	//);
	//pipline data is the core
	PCcalculate PCcalculate( //有不确定的情况就三个等号
	.PC(IDPC),
	.Instr(IDIR),
	.order(IFPC_4),
	.Imm(IDImm), 
	.RD1(IDRD1F), //IF级用了ID级的PC
	.cmp(cmp), 
	.PCSrc(PCSrc),
	.NextPC(IFNextPC)
	);//分布式译码控制信号无需流水
	
	pc pc(
	.clk(clk), 
	.reset(reset), 
	.next_pc(IFNextPC), 
	.Stalk(Stalk),
	.pc(IFPC)
	);
	
	adder IFadder_4(
	.A(IFPC),
	.B(32'h0000_0004),
	.out(IFPC_4)
	);//generate IFPC_4
	
	adder IFadder_8(
	.A(IFPC),
	.B(32'h0000_0008),
	.out(IFPC_8)
	);//generate IFPC_8
	
	
	im IM(
	.pc(IFPC),
	.instruct(IFIR)
	);
	//四级流水线寄存器->五级流水线
	
	//ID
	DecodeReg UutDecodeReg(
	.clk(clk),
	.reset(reset),
	.NextIDIR(IFIR),
	.NextIDPC_8(IFPC_8),
	.NextIDPC(IFPC),
	.Stalk(Stalk),
	.IDIR(IDIR),
	.IDPC_8(IDPC_8),//这一阶段的数据最简单 无其他扩展
	.IDPC(IDPC)
	//我们流水线寄存器以其提供数据的流水级的简称命名，如 D 级流水线寄存器的前一级为 F 级，而后一级为 D 级。
    );
	 
	 //GRF单独列出 ->涉及ID和WB
	grf GRF(
	.clk(clk),
	.reset(reset),
	.WE(WBRegWrite),
	.A1(IDIR[25:21]),
	.A2(IDIR[20:16]),
	.A3(WBA3),
	.WD(WD),
	.pc(WBPC),
	.RD1(IDRD1), 
	.RD2(IDRD2)
	);
	
	controller controllerDe(
	.cmp(cmp),
	.Instr(IDIR), //注意是ID级指令
	.PCSrc(PCSrc),
	.ExtOp(ExtOp),
	.CMPMode(CMPMode),
	.Level(`Level_ID),
	.tuse_rs(tuse_rs),
	.tuse_rt(tuse_rt),
	.JUMPOut(IDJUMP)
	);
	
	mux4 mux4IDRD1Sel(
	.x0(IDRD1),
	.x1(WD), //数字越小，优先级越低
	.x2(MEMTRSrc),//MEM级包含ALUOut和RD
	.x3(EXTRSrc),
	.sel(IDRD1Sel),
	.result(IDRD1F)
	);
	

	mux4 mux4IDRD2Sel(
	.x0(IDRD2),
	.x1(WD),
	.x2(MEMTRSrc),//MEM级包含ALUOut和RD
	.x3(EXTRSrc),
	.sel(IDRD2Sel), 
	.result(IDRD2F)
	);
	
	Comparator Comparator(
	.A(IDRD1F), 
	.B(IDRD2F), 
	.CMPMode(CMPMode),
	.cmp(cmp)
	);
	
	extender EXT(
	.Instr(IDIR),
	.IDPC(IDPC), //先用现算（虽然使得时间变慢
	.ExtOp(ExtOp), //Mode 选择
	.out(IDImm) //also u
   );//通用性
	
	//EX
	ExecuteReg UutExecuteReg(
	.clk(clk),
	.reset(reset),
	.NextEXPC(IDPC),
	.NextEXPC_8(IDPC_8),
	.NextEXIR(IDIR),
	
	.NextEXImm(IDImm),
	.NextEXRD1(IDRD1F),
	.NextEXRD2(IDRD2F), //之后都是正确的数据 RD1，RD2千万别写错
	.NextEXJUMP(IDJUMP),
	
	.Stalk(Stalk),
	.EXPC(EXPC),
	.EXPC_8(EXPC_8),
	.EXIR(EXIR), 

	.EXImm(EXImm),
	.EXRD1(EXRD1),
	.EXRD2(EXRD2),
	.EXJUMP(EXJUMP)
   );

	controller controllerEx(
	.JUMP(EXJUMP),
	.cmp(cmp),
	.Instr(EXIR),
	.RegWrite(EXRegWrite),
	.ALUSrc(ALUSrc),
	.ALUCtrl(ALUCtrl),
	.Level(`Level_EX),
	.tnew(EXtnew),
	.A3(EXA3),
	.MemtoReg(EXMemtoReg),
	.lwbti(EXlwbti)
	);
	
	mux4 mux4EXRD1Sel(
	.x0(EXRD1),
	.x1(WD), //和CMP是一样的 but NPC is quite different, need a new type of coding
	.x2(MEMTRSrc), //MEM级包含ALUOut和RD
	.x3(init),
	.sel(EXRD1Sel),
	.result(EXRD1F)
	);
	
	mux4 mux4EXRD2Sel(
	.x0(EXRD2),
	.x1(WD),
	.x2(MEMTRSrc),//MEM级包含ALUOut和RD
	.x3(init),
	.sel(EXRD2Sel),
	.result(EXRD2F)
	);
	
	mux4 mux4_ALUSrc(
	.x0(EXRD2F),
	.x1(EXImm),
	.x2(init),
	.x3(init), //暂时不用
	.sel(ALUSrc),
	.result(ALUB)
	);
	
	alu ALU(
	.A(EXRD1F),
	.B(ALUB),
	.ALUCtrl(ALUCtrl),
	.result(EXALUOut)
	);
	
	//MEM
	MemoryReg UutMemoryReg(
	.clk(clk),
	.reset(reset),
	.NextMEMALUOut(EXALUOut),
	.NextMEMPC_8(EXPC_8),
	.NextMEMPC(EXPC),
	.NextMEMIR(EXIR),
	.NextMEMRD2(EXRD2F),
	.NextMEMJUMP(EXJUMP),
	
	.MEMPC_8(MEMPC_8),
	.MEMPC(MEMPC),
	.MEMIR(MEMIR),
	.MEMRD2(MEMRD2),
	.MEMALUOut(MEMALUOut),
	.MEMJUMP(MEMJUMP)
   );
	
	controller controllerMem(
	.cmp(cmp),
	.JUMP(MEMJUMP),
	.Instr(MEMIR), //IR : Instr
	.RegWrite(MEMRegWrite),
	.MemWrite(MemWrite),
	.Level(`Level_MEM),
	.tnew(MEMtnew),
	.A3(MEMA3),
	.MemtoReg(MEMMemtoReg),
	.DMMode(DMMode),
	.lwbti(MEMlwbti)
	);
	
	mux4 mux4_MEMRD2Sel(//only data in WB will help
	.x0(MEMRD2),
	.x1(WD), //WB//MEM级包含ALUOut和RD
	.x2(IDRD2),
	.x3(init),
	.sel(MEMRD2Sel),
	.result(MEMRD2F)
	);
	
	dm DM(
	.clk(clk),
	.reset(reset),
	.MemWrite(MemWrite),
	.Addr(MEMALUOut), //取出数据地址 ->完整的
	.RD2(MEMRD2F), //输入数据 //GRF RD2(F)
	.PC(MEMPC),
	.DataOut(MEMRD), //输出数据
	.DMMode(DMMode)
	);
	
	//WB
	WriteBackReg UutWriteReg(
	.clk(clk),
	.reset(reset),
	.NextWBIR(MEMIR),
	.NextWBRD(MEMRD),
	.NextWBPC(MEMPC),
	.NextWBPC_8(MEMPC_8),
	.NextWBALUOut(MEMALUOut),
	.NextWBJUMP(MEMJUMP),
	
	.WBIR(WBIR),
	.WBRD(WBRD),
	.WBPC(WBPC),
	.WBPC_8(WBPC_8),
	.WBALUOut(WBALUOut),
	.WBJUMP(WBJUMP)
   );
	controller controllerWB(
	.cmp(cmp),
	.JUMP(WBJUMP),
	.RD(WBRD),
	.Instr(WBIR),
	.RegWrite(WBRegWrite), //WE
	.MemtoReg(WBMemtoReg),//sel
	.A3(WBA3),//WBA3
	.Level(`Level_WB),
	.tnew(WBtnew)
	);
	
	mux4 mux4_MemtoReg( //generateWriteData //modified
	.x0(WBALUOut),
	.x1(WBRD),
	.x2(WBPC_8),
	.x3(init),
	.sel(WBMemtoReg), //回写MemtoReg Selection
	.result(WD)
	);
	
	//GRF单独列出 ->涉及ID和WB
	/*
	grf GRF(
	.clk(clk),
	.reset(reset),
	.WE(WBRegWrite),
	.A1(IDIR[25:21]),
	.A2(IDIR[20:16]),
	.A3(WBA3),
	.WD(WD),
	.pc(WBPC),
	.RD1(IDRD1), 
	.RD2(IDRD2)
	);
	*/
	
	//冒险处理模块：转发和暂停
	Hcontroller Hcontroller(
	.IDInstr(IDIR),
	.EXInstr(EXIR),
	.MEMInstr(MEMIR),
	.WBInstr(WBIR),
	
	.EXRegWrite(EXRegWrite),
	.MEMRegWrite(MEMRegWrite),
	.WBRegWrite(WBRegWrite),
	
	.EXA3(EXA3),
	.MEMA3(MEMA3),
	.WBA3(WBA3),
	
	.EXtnew(EXtnew),
	.MEMtnew(MEMtnew),
	.WBtnew(WBtnew), //tnew = 2'b00马上产生新数据，或者数据没有关联性，或者没有新数据
	.EXlwbti(EXlwbti),
	.MEMlwbti(MEMlwbti),
	
	.IDRD1Sel(IDRD1Sel),
	.IDRD2Sel(IDRD2Sel),
	.EXRD1Sel(EXRD1Sel),
	.EXRD2Sel(EXRD2Sel),
	.MEMRD2Sel(MEMRD2Sel),
	//.NPCRD1Sel(NPCRD1Sel),
	.Stalk(Stalk),
	.tuse_rs(tuse_rs),
	.tuse_rt(tuse_rt)
);
	always @(posedge clk) begin
		//$display("@%h: $%d <= %h", WBPC, WBA3, WD);
		//$display("IFPC is %h, IDPC is %h, EXPC is %h, MEMPC is %h, WBPC is %h", IFPC, IDPC, EXPC, MEMPC, WBPC);
		//$display("IFIR is %h, IDIR is %h, EXIR is %h, MEMIR is %h, WBIR is %h", IFIR, IDIR, EXIR, MEMIR, WBIR);
		//$display("PCSrc is %b", PCSrc);
		//$display("EXALUOut is %h", EXALUOut);
//display("Stalk is %b", Stalk);
		//$display ("pc is %h, next_pc is %h", IFPC, IFNextPC);
	end 
endmodule
