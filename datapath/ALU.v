`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:53 06/27/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_operation,
    output [31:0] res,
    output zero,
    output overflow
    );
    
    parameter INVALID = 32'hx;
    wire [31:0] res_and,res_or,res_nor,res_slt, res_alu, res_sll, res_srl, res_xor, res_sltu, res_sra, Bin;
    
    assign Bin = (ALU_operation == 3'b110) ? ~B[31:0] : B[31:0];
    wire   sub = (ALU_operation == 3'b110) ? 1 : 0;
    
    assign res_and = A & B;
    assign res_or  = A | B;
    assign res_nor = ~(A | B);
    assign res_slt = ($signed(A) < $signed(B)) ? 32'h00000001 : 32'h00000000;
    assign res_sll = A << B;
    assign res_srl = A >> B;
    assign res_xor = A ^ B;
    assign res_sltu = (A < B) ? 32'h00000001 : 32'h00000000;
    assign res_sra = $signed(A) >>> B;
    
    assign zero = (|res[31:0]) ? 1'b0 : 1'b1;
    
    ADD32b ADD(.A(A),
               .B(Bin),
               .Ci(sub),
               .S(res_alu),
               .Co(overflow)
               );
    
    MUX16T1_32 MUX(.s(ALU_operation),
                   .I0(res_and),
                   .I1(res_or),
                   .I2(res_alu),
                   .I3(res_sll),
                   .I4(res_nor),
                   .I5(res_srl),
                   .I6(res_alu),
                   .I7(res_slt),
                   .I8(res_xor),
                   .I9(res_sltu),
                   .I10(res_sra),
                   .I11(INVALID),
                   .I12(INVALID),
                   .I13(INVALID),
                   .I14(INVALID),
                   .I15(INVALID),
                   .out(res)
                   );
    
    

endmodule
