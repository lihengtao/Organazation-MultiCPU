`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:11:52 06/28/2020 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input clk,
    input rst,
    input [31:0] Inst_in, // Instruction Input
    input zero,
    input overflow, 
    input MIO_ready, // 0 CPU suspends, 1 CPU running
	 
    output [4:0] state_out, // for test
	
	output reg [3:0] ALU_operation, 
	output reg [2:0] RAMCtrl,
	 
	output reg PCWrite, // 1 write, 0 no write
    output reg PCWriteCond, // 0 unconditional ins, 1 conditional ins
    output reg IorD, // 0 PC_out, 1 ALU_out
	output reg MemRead,
    output reg MemWrite, 
    output reg IRWrite, // 1 write, 0 no write
    output reg [1:0] RegDst, // 00 rt(IR[21:16], 01 rd(IR[15:11]), 10/11 \
    output reg RegWrite, // 1 write, 0 no write
    output reg [1:0] MemtoReg, // 00 ALU_out(ALU ops), 01 MDR_out(lw), 10/11 \
    output reg ALUSrcA, // 0 reg A, 1 PC
    output reg [2:0] ALUSrcB, // 00 reg B, 01 2(for PC + 2), 10 imm32, 11 imm32<<2
    output reg [1:0] PCSource, // 00 alu_res, 01 ALU_out, 10 jump_addr, 11 \
	output reg Branch, // 0 for bne, 1 for beq
	output reg CPU_MIO
    );

`include "mips_parameters.vh"
////////////////////State Control////////////////////
reg [4:0] state;
wire OPCode = Inst_in[31:26];
wire ALU_Func = Inst_in[5:0];

initial begin
	state <= IF;
	state_out = state;
end

// state change
always@(posedge clk or posedge rst)begin
	if(rst == 1)state<=IF;
	else
		case(state)
			IF: 
				ALU_operation = ADD;
				if(MIO_ready) state<=ID;
					else state<=IF;
			ID:
				case(OPCode) // change state due to op code
					OP_R: state<=R_Exe;
					OP_LUi: state<=I_Exe;
					OP_LW, OP_LWx, OP_LH, OP_LHx, OP_LHu, OP_LHux, OP_SW, OP_SWx, OP_SH, OP_SHx : state<=Mem_Acc;
					OP_ADDi, OP_SLTi, OP_SLTiu, OP_ANDi, OP_ORi, OP_XORi: state<=I_Exe;
					OP_BEQ: state<=Beq_Exe;
					OP_BNE: state<=Bne_Exe;
				endcase
			Mem_Acc: 
				case(OPCode)
					OP_LW, OP_LWx, OP_LH, OP_LHx, OP_LHu, OP_LHux: state<=LD_RD;
					OP_SW, OP_SWx, OP_SH, OP_SHx: state<=SV_WB;
				endcase
			LD_RD: 
				case(OPCode)
					OP_LW: RAMCtrl = Full;
					OP_LWx: RAMCtrl = Fullx;
					OP_LH: RAMCtrl = Half;
					OP_LHx: RAMCtrl = Halfx;
					OP_LHu: RAMCtrl = Halfu;
					OP_LHux: RAMCtrl = Halfux;
				endcase
				state <= LD_WB;
			LD_WB:
				case(OPCode)
					OP_LW: RAMCtrl = Full;
					OP_LWx: RAMCtrl = Fullx;
					OP_LH: RAMCtrl = Half;
					OP_LHx: RAMCtrl = Halfx;
					OP_LHu: RAMCtrl = Halfu;
					OP_LHux: RAMCtrl = Halfux;
				endcase
				state <= IF;
			SV_WB: 
				case(OPCode)
					OP_SW: RAMCtrl = Full;
					OP_SWx: RAMCtrl = Fullx;
					OP_SH: RAMCtrl = Half;
					OP_SHx: RAMCtrl = Halfx;
			R_Exe:
				case(ALU_Func)
					ALU_ADD: ALU_operation = ADD;
					ALU_SUB: ALU_operation = SUB;
					ALU_AND: ALU_operation = AND;
					ALU_OR: ALU_operation = OR;
					ALU_NOR: ALU_operation = NOR;
					ALU_SLT: ALU_operation = SLT;
					ALU_SLTu: ALU_operation = SLTu;
					ALU_SRLv: ALU_operation = SRL;
					ALU_SLLv: ALU_operation = SLL;
					ALU_SRAv: ALU_operation = SRA
					ALU_XOR: ALU_operation = XOR;
				endcase
				state<=R_WB;
			R_SA:
				case(ALU_Func)
					ALU_SLL: ALU_operation = SLL;
					ALU_SRL: ALU_operation = SRL;
					ALU_SRA: ALU_operation = SRA;
				endcase
				state<=R_WB;
			R_WB: state<=IF;
			I_Exe:
				case(OPCode)
					OP_ADDi:
						ALU_operation = ADD;
						state <= I_WB;
					OP_SLTi:
						ALU_operation = SLT;
						state <= I_WB;
					OP_SLTiu:
						ALU_operation = SLTu;
						state <= I_WB;
					OP_ANDi:
						ALU_operation = AND;
						state <= I_WB;
					OP_ORi:
						ALU_operation = OR;
						state <= I_WB;
					OP_XORi:
						ALU_operation = XOR;
						state <= I_WB;
					LUi: state <= Lui_WB
				endcase
			I_WB: state<=IF;
			Lui_WB: state<=IF;
			Beq_Exe: 
				ALU_operation = SUB;
				state<=IF;
			Bne_Exe:
				ALU_operation = ADD;
				state<=IF;
			J: state<=IF;
			Jr: state<=IF;
			JAL: state<=IF;
			JALr: state<=IF;
			default: state<=IF;
		endcase
end

////////////////////Datapath control////////////////////
`define Datapath_signals {PCWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,MemtoReg,PCSource,ALUSrcB,ALUSrcA,RegWrite,RegDst,Branch,CPU_MIO}

// assign datapath control
always@*begin
	case(state)
		IF:		`Datapath_signals = value_IF;
		ID:		`Datapath_signals = value_ID;
		Mem_Acc:`Datapath_signals = value_Mem_Acc;
		LD_RD:	`Datapath_signals = value_LD_RD;
		LD_WB:	`Datapath_signals = value_LD_WB;
		SV_WB:	`Datapath_signals = value_SV_WB;
		R_Exe:	`Datapath_signals = value_R_Exe;
		R_SA:	`Datapath_signals = value_R_SA;
		R_WB:	`Datapath_signals = value_R_WB;
		I_Exe:	`Datapath_signals = value_I_Exe;
		I_WB:	`Datapath_signals = value_I_WB;
		Lui_WB:	`Datapath_signals = value_Lui_WB;
		Beq_Exe:`Datapath_signals = value_Beq_Exe;
		Bne_Exe:`Datapath_signals = value_Bne_Exe;
		J:		`Datapath_signals = value_J;
		Jr:		`Datapath_signals = value_Jr;
		JAL:	`Datapath_signals = value_JAL;
		JALr:	`Datapath_signals = value_JALr;
		default:`Datapath_signals = value_IF;
	endcase
end

endmodule
