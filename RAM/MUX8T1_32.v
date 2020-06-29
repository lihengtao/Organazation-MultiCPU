`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:11 06/27/2020 
// Design Name: 
// Module Name:    MUX8T1_32 
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
module MUX8T1_32(
    input [2:0] s,
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [31:0] I3,
    input [31:0] I4,
    input [31:0] I5,
    input [31:0] I6,
    input [31:0] I7,
    output [31:0] out
    );

    wire EN0 = (~s[2]) & (~s[1]) & (~s[0]);
    wire EN1 = (~s[2]) & (~s[1]) & ( s[0]);
    wire EN2 = (~s[2]) & ( s[1]) & (~s[0]);
    wire EN3 = (~s[2]) & ( s[1]) & ( s[0]);
    wire EN4 = ( s[2]) & (~s[1]) & (~s[0]);
    wire EN5 = ( s[2]) & (~s[1]) & ( s[0]);
    wire EN6 = ( s[2]) & ( s[1]) & (~s[0]);
    wire EN7 = ( s[2]) & ( s[1]) & ( s[0]);
    
    
    assign out = ({32{EN0}} & I0) | 
                 ({32{EN1}} & I1) | 
                 ({32{EN2}} & I2) | 
                 ({32{EN3}} & I3) |
                 ({32{EN4}} & I4) | 
                 ({32{EN5}} & I5) | 
                 ({32{EN6}} & I6) | 
                 ({32{EN7}} & I7);


endmodule
