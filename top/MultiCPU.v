`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:43 06/29/2020 
// Design Name: 
// Module Name:    MultiCPU 
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
module MultiCPU(
    input clk,
    input reset,
    input MIO_ready,
    input INT,
    input [31:0] Data_in,
    
    output mem_w,
    output [2:0] RAMCtrl,
    output [31:0] PC_out,
    output [31:0] inst_out,
    output [31:0] Data_out,
    output [31:0] Addr_out,
    output CPU_MIO,
    output [4:0] state
    );
    
    wire [1:0] RegDst, MemtoReg, PCSource;
    wire [2:0] ALUSrcB;
    wire [3:0] ALU_operation;
    wire MemRead,MemWrite;
    
    assign mem_w = (~MemRead) & MemWrite;
    
    Controller controller(.clk(clk),
                          .rst(reset),
                          .MIO_ready(MIO_ready),
                          .zero(zero),
                          .overflow(overflow),
                          .Inst_in(inst_out),
                          .MemRead(MemRead),
                          .MemWrite(MemWrite),
                          .CPU_MIO(CPU_MIO),
                          .IorD(IorD),
                          .IRWrite(IRWrite),
                          .RegWrite(RegWrite),
                          .ALUSrcA(ALUSrcA),
                          .PCWrite(PCWrite),
                          .PCWriteCond(PCWriteCond),
                          .Branch(Branch),
                          .RegDst(RegDst),
                          .MemtoReg(MemtoReg),
                          .ALUSrcB(ALUSrcB),
                          .PCSource(PCSource),
                          .ALU_operation(ALU_operation),
                          .RAMCtrl(RAMCtrl),
                          .state_out(state)
                          );
    
    M_datapath datapath(.clk(clk),
                        .reset(reset),
                        .MIO_ready(MIO_ready),
                        .IorD(IorD),
                        .IRWrite(IRWrite),
                        .RegWrite(RegWrite),
                        .ALUSrcA(ALUSrcA),
                        .PCWrite(PCWrite),
                        .PCWriteCond(PCWriteCond),
                        .Branch(Branch),
                        .RegDst(RegDst),
                        .MemtoReg(MemtoReg),
                        .ALUSrcB(ALUSrcB),
                        .PCSource(PCSource),
                        .ALU_operation(ALU_operation),
                        .data2CPU(Data_in),
                        .zero(zero),
                        .overflow(overflow),
                        .PC_Current(PC_out),
                        .Inst(inst_out),
                        .data_out(Data_out),
                        .M_addr(Addr_out)
                        );


endmodule
