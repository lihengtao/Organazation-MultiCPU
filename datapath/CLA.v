`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:15:21 06/27/2020 
// Design Name: 
// Module Name:    CLA 
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
module CLA(
    input G3,
    input P3,
    input G2,
    input P2,
    input G1,
    input P1,
    input G0,
    input P0,
    input CI,
    output C3,
    output C2,
    output C1,
    output GG,
    output GP
    );

	assign C1 = G0 | (P0 & CI);
	assign C2 = G1 | (P1 & G0) | (P1 & P0 & CI);
	assign C3 = G2 | (P2 & G1) | (P2 & P1 & G0) | (P2 & P1 & P0 & CI);
	assign GG = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0);
	assign GP = P3 & P2 & P1 & P0;

endmodule
