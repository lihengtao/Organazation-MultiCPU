`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:07 06/28/2020 
// Design Name: 
// Module Name:    MUX16T1_32 
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
module MUX16T1_32(
    input [3:0] s,
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [31:0] I3,
    input [31:0] I4,
    input [31:0] I5,
    input [31:0] I6,
    input [31:0] I7,
    input [31:0] I8,
    input [31:0] I9,
    input [31:0] I10,
    input [31:0] I11,
    input [31:0] I12,
    input [31:0] I13,
    input [31:0] I14,
    input [31:0] I15,
    output [31:0] out
    );

    wire EN0  = (~s[3]) & (~s[2]) & (~s[1]) & (~s[0]);
    wire EN1  = (~s[3]) & (~s[2]) & (~s[1]) & ( s[0]);
    wire EN2  = (~s[3]) & (~s[2]) & ( s[1]) & (~s[0]);
    wire EN3  = (~s[3]) & (~s[2]) & ( s[1]) & ( s[0]);
    wire EN4  = (~s[3]) & ( s[2]) & (~s[1]) & (~s[0]);
    wire EN5  = (~s[3]) & ( s[2]) & (~s[1]) & ( s[0]);
    wire EN6  = (~s[3]) & ( s[2]) & ( s[1]) & (~s[0]);
    wire EN7  = (~s[3]) & ( s[2]) & ( s[1]) & ( s[0]);
    wire EN8  = ( s[3]) & (~s[2]) & (~s[1]) & (~s[0]);
    wire EN9  = ( s[3]) & (~s[2]) & (~s[1]) & ( s[0]);
    wire EN10 = ( s[3]) & (~s[2]) & ( s[1]) & (~s[0]);
    wire EN11 = ( s[3]) & (~s[2]) & ( s[1]) & ( s[0]);
    wire EN12 = ( s[3]) & ( s[2]) & (~s[1]) & (~s[0]);
    wire EN13 = ( s[3]) & ( s[2]) & (~s[1]) & ( s[0]);
    wire EN14 = ( s[3]) & ( s[2]) & ( s[1]) & (~s[0]);
    wire EN15 = ( s[3]) & ( s[2]) & ( s[1]) & ( s[0]);
    
    
    assign out = ({32{EN0}}  & I0)  | 
                 ({32{EN1}}  & I1)  | 
                 ({32{EN2}}  & I2)  | 
                 ({32{EN3}}  & I3)  |
                 ({32{EN4}}  & I4)  | 
                 ({32{EN5}}  & I5)  | 
                 ({32{EN6}}  & I6)  | 
                 ({32{EN7}}  & I7)  |
                 ({32{EN8}}  & I8)  | 
                 ({32{EN9}}  & I9)  | 
                 ({32{EN10}} & I10) | 
                 ({32{EN11}} & I11) |
                 ({32{EN12}} & I12) | 
                 ({32{EN13}} & I13) | 
                 ({32{EN14}} & I14) | 
                 ({32{EN15}} & I15);
                 
endmodule

