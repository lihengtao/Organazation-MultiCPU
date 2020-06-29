`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:51 06/27/2020 
// Design Name: 
// Module Name:    M_datapath 
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
module M_datapath(input clk,
                  input reset,		  
		          input MIO_ready,		//外部输入=1
		          input IorD,
		          input IRWrite,
		          input [1:0] RegDst,	//预留到2位
	    	      input RegWrite,
	    	      input [1:0] MemtoReg,	//预留到2位
	    	      input ALUSrcA,
	    	      input [2:0] ALUSrcB,
		          input [1:0] PCSource,	//4选1控制
	    	      input PCWrite,
		          input PCWriteCond,	
		          input Branch,
		          input [3:0]ALU_operation,
		          input [31:0]data2CPU,
					  
		          output[31:0]PC_Current,
		          output[31:0]Inst,
		          output[31:0]data_out,
		          output[31:0]M_addr,
		          output zero,
		          output overflow
                  );
    

    wire [31:0] MDR_out, reg_Wt_data, ALU_out, rdata_A, rdata_B, alu_A, alu_B, alu_res, imm_32, PC_Wt_data;
    
    REG32 IR (.clk(clk), .rst(reset),  .CE(IRWrite), .D(data2CPU), .Q(Inst));
    REG32 MDR(.clk(clk), .rst(1'b0),   .CE(1'b1),    .D(data2CPU), .Q(MDR_out) );
    
    
    wire [4:0] reg_Rs_addr_A = Inst[25:21];  //REG Source 1  rs
    wire [4:0] reg_Rt_addr_B = Inst[20:16];  //REG Source 2 or Destination rt
    wire [4:0] reg_Rd_addr   = Inst[15:11];  //REG Destination rd
    wire [4:0] sa = Inst[10:6];              //shift amount
    wire [15:0] imm = Inst[15:0]; 	        //Immediate
    wire [25:0] direct_addr = Inst[25:0];    //Jump addre
    wire [4:0] reg_Wt_addr;
    
    // reg write addr port    RegDst
    MUX4T1_5 MUX0(.I0(reg_Rt_addr_B), 	//reg addr=IR[21:16]
                  .I1(reg_Rd_addr), 	//reg addr=IR[15:11], LW or lui
                  .I2(5'b11111),        //$ra for jal
                  .I3(5'b00000),        // not use
                  .s(RegDst), 
                  .out(reg_Wt_addr)
                  );
    // reg write data port    MemtoReg
    MUX4T1_32 MUX1(.I0(ALU_out), 		//ALU OP
                   .I1(MDR_out), 		//LW 
                   .I2(PC_Current),     //JAL
                   .I3({imm[15:0], 16'h0000}),	// lui
                   .s(MemtoReg), 		
                   .out(reg_Wt_data)
                   );

    
    Regs regs(.clk(clk), 
		      .rst(reset), 
		      .R_addr_A(reg_Rs_addr_A), //Inst(25:21)
		      .R_addr_B(reg_Rt_addr_B), //Inst(20:16)
		      .Wt_addr(reg_Wt_addr), 	    //来自MUX1
		      .Wt_data(reg_Wt_data),	    //来自MUX2
		      .L_S(RegWrite), 	       	//来自控制器
		      .rdata_A(rdata_A), 	    //送MUX4
		      .rdata_B(rdata_B)	        //送MUX3//data_out(31:0)
		    );
            
    assign data_out=rdata_B;
    
    assign imm_32[31:0] = {{16{imm[15]}}, imm[15:0]};
    
    //ALU source A
    MUX2T1_32 MUX2(.I0(rdata_A),        //reg out A
                   .I1(PC_Current), 	// PC
		           .s(ALUSrcA), 
                   .out(alu_A)
                   );
    //ALU source B
    MUX8T1_32 MUX3(.I0(rdata_B), 		//reg out B
                   .I1(32'h2), 		    //for PC+2
                   .I2(imm_32), 		//可扩展imm//Imm_32(31:0)
                   .I3({imm_32[29:0], 2'b00}),		//可扩展offset//Imm_32(29:0),N0,N0
                   .I4({27'h0, sa[4:0]}),   //shift
                   .I5(32'h00000000),   //not use
                   .I6(32'h00000000),   //not use
                   .I7(32'h00000000),   //not use
                   .s(ALUSrcB), 
                   .out(alu_B)
                   );	
    //ALU
    ALU alu(.A(alu_A),
            .B(alu_B),
            .ALU_operation(ALU_operation),
            .res(alu_res),
            .zero(zero),
            .overflow(overflow)
            );
    //ALUOut
    REG32 ALUOut(.clk(clk), .rst(1'b0), .CE(1'b1), .D(alu_res), .Q(ALU_out));

    MUX2T1_32 MUX4(.I0(PC_Current),
                   .I1(ALU_out), 
		           .s(IorD), 
                   .out(M_addr)
                   );

    //PC
    REG32 PC(.clk(clk), .rst(reset), .CE((PCWrite | (PCWriteCond & zero & Branch)) & MIO_ready), .D(PC_Wt_data), .Q(PC_Current));    //debug CE(...&Branch) for beq and bne
    
    MUX4T1_32 MUX5(.I0(alu_res),    //PC+2
                   .I1(ALU_out),    //Branch_PC
                   .I2({PC_Current[31:28], Inst[25:0], 2'b00}), //jump_addr
                   .I3(alu_res),    //not use
                   .s(PCSource), 
                   .out(PC_Wt_data)
                   );	


endmodule
