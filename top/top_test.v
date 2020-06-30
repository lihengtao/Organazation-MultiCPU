`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:35:31 06/29/2020
// Design Name:   top
// Module Name:   D:/ISE/Organization/MultiCPU/Code/test/top_test.v
// Project Name:  MultiCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_test;

	// Inputs
	reg clk;
	reg clk_CPU;
	reg rst;

	// Outputs
	wire [31:0] PC;
	wire [31:0] Inst;
	wire [31:0] Data_write;
	wire [31:0] Data_read;
	wire [31:0] Addr;
	wire mem_w;
	wire [4:0] state;
	wire [2:0] RAMCtrl;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.clk_CPU(clk_CPU), 
		.rst(rst), 
		.PC(PC), 
		.Inst(Inst), 
		.Data_write(Data_write), 
		.Data_read(Data_read), 
		.Addr(Addr), 
		.mem_w(mem_w), 
		.state(state), 
		.RAMCtrl(RAMCtrl)
	);

	initial begin
		rst = 0;
        clk = 0;
        clk_CPU = 1;
        fork
            forever begin
                #10 clk = ~clk;
                clk_CPU = ~clk_CPU;
            end
            
            begin
                #50;
                rst = 1;
                #50;
                rst = 0;
            end
        join

	end
      
endmodule

