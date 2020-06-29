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
    output reg [1:0] ALUSrcB, // 00 reg B, 01 2(for PC + 2), 10 imm32, 11 imm32<<2
    output reg [1:0] PCSource, // 00 alu_res, 01 ALU_out, 10 jump_addr, 11 \
	 output reg Branch, // 0 for bne, 1 for beq
	 output reg [3:0] ALU_operation, 
	 output reg CPU_MIO
    );

`include "mips_parameters.vh"
////////////////////State Control////////////////////
reg [3:0] state;

initial begin
	state <= IF;
	state_out = state;
end

// state change
always@(posedge clk or posedge rst)begin
	if(rst == 1)state<=IF;
	else
		case(state)
			IF: if(MIO_ready) state<=ID;
					else state<=IF;
			ID: case(Inst_in[31:26]) // change state due to op code
					6'b000000: state<=R_Exe;
					6'b000000: state<=I_Exe;
					6'b000000: state<=R_Exe;
					6'b000000: state<=R_Exe;
					6'b000000: state<=R_Exe;
				endcase
			Mem_Ex: if(MIO_ready) state<=ID;
					else state<=IF;
			Mem_RD: if(MIO_ready) state<=ID;
					else state<=IF;
			LW_WB: if(MIO_ready) state<=ID;
					else state<=IF;
			Mem_W: if(MIO_ready) state<=ID;
					else state<=IF;
			R_Exe:
				case(Inst_in[5:0])
					6'b100000: ALU_operation = ADD;
					6'b100010: ALU_operation = SUB;
					6'b100100: ALU_operation = AND;
					6'b100101: ALU_operation = OR;
					6'b100111: ALU_operation = NOR;
					6'b101010: ALU_operation = SLT;
					6'b000010: ALU_operation = SRL;
					6'b000000: ALU_operation = SLL;
					6'b100110: ALU_operation = XOR;
				endcase
			R_WB: if(MIO_ready) state<=ID;
					else state<=IF;
			Beq_Exe: if(MIO_ready) state<=ID;
					else state<=IF;
			J: if(MIO_ready) state<=ID;
					else state<=IF;
			I_Exe: if(MIO_ready) state<=ID;
					else state<=IF;
			I_WB: if(MIO_ready) state<=ID;
					else state<=IF;
			Lui_WB: if(MIO_ready) state<=ID;
					else state<=IF;
			Bne_Exe: if(MIO_ready) state<=ID;
					else state<=IF;
			Jr: if(MIO_ready) state<=ID;
					else state<=IF;
			Jal: if(MIO_ready) state<=ID;
					else state<=IF;
			Error: state<=Error;
			default: state<=Error;
		endcase
end

////////////////////Datapath control////////////////////
`define Datapath_signals {PCWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,MemtoReg,PCSource,ALUSrcB,ALUSrcA,RegWrite,RegDst,Branch,CPU_MIO}

// assign datapath control
always@*begin
	case(state)
		IF:		`Datapath_signals = value_IF;
		ID:		`Datapath_signals = value_ID;
		Mem_Ex:	`Datapath_signals = value_Mem_Ex;
		Mem_RD:	`Datapath_signals = value_Mem_RD;
		LW_WB:	`Datapath_signals = value_LW_WB;
		Mem_W:	`Datapath_signals = value_Mem_WD;
		R_Exe:	`Datapath_signals = value_R_Exe;
		R_WB:		`Datapath_signals = value_R_WB;
		Beq_Exe:	`Datapath_signals = value_Beq_Exe;
		J:			`Datapath_signals = value_J;
		I_Exe:	`Datapath_signals = value_I_Exe;
		I_WB:		`Datapath_signals = value_I_WB;
		Lui_WB:	`Datapath_signals = value_Lui_WB;
		Bne_Exe:	`Datapath_signals = value_Bne_Exe;
		Jr:		`Datapath_signals = value_Jr;
		Jal:		`Datapath_signals = value_Jal;
		default:	`Datapath_signals = value_IF;
	endcase
end

endmodule
