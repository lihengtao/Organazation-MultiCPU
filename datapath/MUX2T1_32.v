`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:19 06/28/2020 
// Design Name: 
// Module Name:    MUX2T1_32 
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
module MUX2T1_32(
    input s,
    input [31:0] I0,
    input [31:0] I1,
    output [31:0] out
    );

    wire EN0 = ~s;
    wire EN1 =  s;
    
    
    assign out = ({32{EN0}} & I0) | ({32{EN1}} & I1);


endmodule
