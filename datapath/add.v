`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:28 06/27/2020 
// Design Name: 
// Module Name:    add 
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
module add(
    input Ai,
    input Bi,
    input Ci,
    output Si,
    output Co,
    output Gi,
    output Pi
    );
	
	assign Si = Pi ^ Ci;
	assign Co = (Pi & Ci) | Gi;
	assign Gi = Ai & Bi;
	assign Pi = Ai ^ Bi;

endmodule
