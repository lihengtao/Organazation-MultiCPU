`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:23 06/27/2020 
// Design Name: 
// Module Name:    ADD4b 
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
module ADD4b(
    input [3:0] Ai,
    input [3:0] Bi,
    input C0,
    output [3:0] S,
    output GG,
    output GP
    );

    add add_0(.Ai(Ai[0]), .Bi(Bi[0]), .Ci(C0), .Gi(G0), .Pi(P0), .Si(S[0]), .Co());
	add add_1(.Ai(Ai[1]), .Bi(Bi[1]), .Ci(C1), .Gi(G1), .Pi(P1), .Si(S[1]), .Co());
	add add_2(.Ai(Ai[2]), .Bi(Bi[2]), .Ci(C2), .Gi(G2), .Pi(P2), .Si(S[2]), .Co());
	add add_3(.Ai(Ai[3]), .Bi(Bi[3]), .Ci(C3), .Gi(G3), .Pi(P3), .Si(S[3]), .Co());
	
	CLA CLA_0(.G3(G3), .P3(P3), .G2(G2), .P2(P2), .G1(G1), .P1(P1), .G0(G0), .P0(P0), .CI(C0), .C3(C3), .C2(C2), .C1(C1), .GG(GG), .GP(GP));

endmodule
