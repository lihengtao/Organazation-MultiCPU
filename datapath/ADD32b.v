`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:10 06/27/2020 
// Design Name: 
// Module Name:    ADD32b 
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
module ADD32b(
    input [31:0] A,
    input [31:0] B,
    input Ci,
    output [31:0] S,
    output Co
    );

    wire C4 = (Ci & GP0) | GG0;
    assign Co = (C4 & GP1) | GG1;
    
    CLA CLA0(.CI(Ci),
             .P0(P0), .G0(G0),
             .P1(P1), .G1(G1),
             .P2(P2), .G2(G2),
             .P3(P3), .G3(G3),
             .GP(GP0),
             .GG(GG0),
             .C1(C1),
             .C2(C2),
             .C3(C3)
             );
             
    CLA CLA1(.CI(C4),
             .P0(P4), .G0(G4),
             .P1(P5), .G1(G5),
             .P2(P6), .G2(G6),
             .P3(P7), .G3(G7),
             .GP(GP1),
             .GG(GG1),
             .C1(C5),
             .C2(C6),
             .C3(C7)
             );
    
    ADD4b ADD4b_0 (.Ai(A[3:0]),   .Bi(B[3:0]),   .C0(Ci), .S(S[3:0]),   .GG(G0), .GP(P0)),
          ADD4b_1 (.Ai(A[7:4]),   .Bi(B[7:4]),   .C0(C1), .S(S[7:4]),   .GG(G1), .GP(P1)),
          ADD4b_2 (.Ai(A[11:8]),  .Bi(B[11:8]),  .C0(C2), .S(S[11:8]),  .GG(G2), .GP(P2)),
          ADD4b_3 (.Ai(A[15:12]), .Bi(B[15:12]), .C0(C3), .S(S[15:12]), .GG(G3), .GP(P3)),
          ADD4b_4 (.Ai(A[19:16]), .Bi(B[19:16]), .C0(C4), .S(S[19:16]), .GG(G4), .GP(P4)),
          ADD4b_5 (.Ai(A[23:20]), .Bi(B[23:20]), .C0(C5), .S(S[23:20]), .GG(G5), .GP(P5)),
          ADD4b_6 (.Ai(A[27:24]), .Bi(B[27:24]), .C0(C6), .S(S[27:24]), .GG(G6), .GP(P6)),
          ADD4b_7 (.Ai(A[31:28]), .Bi(B[31:28]), .C0(C7), .S(S[31:28]), .GG(G7), .GP(P7));
          

endmodule
