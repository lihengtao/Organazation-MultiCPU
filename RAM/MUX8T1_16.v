`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:38 06/29/2020 
// Design Name: 
// Module Name:    MUX8T1_16 
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
module MUX8T1_16(
    input [2:0] s,
    input [15:0] I0,
    input [15:0] I1,
    input [15:0] I2,
    input [15:0] I3,
    input [15:0] I4,
    input [15:0] I5,
    input [15:0] I6,
    input [15:0] I7,
    output [15:0] out
    );

    wire EN0 = (~s[2]) & (~s[1]) & (~s[0]);
    wire EN1 = (~s[2]) & (~s[1]) & ( s[0]);
    wire EN2 = (~s[2]) & ( s[1]) & (~s[0]);
    wire EN3 = (~s[2]) & ( s[1]) & ( s[0]);
    wire EN4 = ( s[2]) & (~s[1]) & (~s[0]);
    wire EN5 = ( s[2]) & (~s[1]) & ( s[0]);
    wire EN6 = ( s[2]) & ( s[1]) & (~s[0]);
    wire EN7 = ( s[2]) & ( s[1]) & ( s[0]);
    
    
    assign out = ({16{EN0}} & I0) | 
                 ({16{EN1}} & I1) | 
                 ({16{EN2}} & I2) | 
                 ({16{EN3}} & I3) |
                 ({16{EN4}} & I4) | 
                 ({16{EN5}} & I5) | 
                 ({16{EN6}} & I6) | 
                 ({16{EN7}} & I7);


endmodule
