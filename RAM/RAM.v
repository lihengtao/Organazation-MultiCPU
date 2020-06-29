`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:47:28 06/28/2020 
// Design Name: 
// Module Name:    RAM
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
module RAM(
    input clk,
    input [9:0] addr,
    input [2:0] RAMCtrl,
    input [31:0] din,
    input we,
    output [31:0] dout
    );
    
    wire [15:0] dina, dinb;
	wire [9:0] addra, addrb;
	wire [15:0] da, db;
    wire wea, web;
    wire [15:0] half;
    
    RAM_16_1024_A RAM_A(.clka(clk), .wea(wea), .addra(addra), .dina(dina), .douta(da));
    RAM_16_1024_B RAM_B(.clka(clk), .wea(web), .addra(addrb), .dina(dinb), .douta(db));
    
    assign addra = (~addr[2] & ~addr[1]) ? ((addr + 10'b1) >> 1) : (addr >> 1);
    assign addrb = addr >> 1;
    assign wea = RAMCtrl[2] ? (we & ~addr[0]) : we;
    assign web = RAMCtrl[2] ? (we &  addr[0]) : we;
    
    
                   
    MUX8T1_16 MUX0(.s(RAMCtrl),
                   .I0(din[31:16]),
                   .I1(din[15:0]),
                   .I2(addr[0] ? din[15:0] : din[31:16]),
                   .I3(addr[0] ? din[31:16] : din[15:0]),
                   .I4({din[7:0], din[15:8]}),
                   .I5(din[15:0]),
                   .I6(din[15:0]),
                   .I7({din[7:0], din[15:8]}),
                   .out(dina)
                   );
    
    MUX8T1_16 MUX1(.s(RAMCtrl),
                   .I0(din[15:0]),
                   .I1(din[31:16]),
                   .I2(addr[0] ? din[31:16] : din[15:0]),
                   .I3(addr[0] ? din[15:0] : din[31:16]),
                   .I4({din[7:0], din[15:8]}),
                   .I5(din[15:0]),
                   .I6({din[7:0], din[15:8]}),
                   .I7(din[15:0]),
                   .out(dinb)
                   );
    
    MUX8T1_32 MUX3(.s(RAMCtrl),
                   .I0({da[15:0], db[15:0]}),
                   .I1({db[15:0], da[15:0]}),
                   .I2(addr[0] ? {db[15:0], da[15:0]} : {da[15:0], db[15:0]}),
                   .I3(addr[0] ? {da[15:0], db[15:0]} : {db[15:0], da[15:0]}),
                   .I4({16'h0000, half[15:0]}),
                   .I5({16'h0000, half[15:0]}),
                   .I6({{16{half[15]}}, half[15:0]}),
                   .I7({{16{half[15]}}, half[15:0]}),
                   .out(dout)
                   );

    assign half = RAMCtrl[0] ? 
                 ((da[15:0] & {16{~addr[0]}} | (db[15:0] & {16{addr[0]}}))) : 
                 (({da[7:0], da[15:8]}) & {16{~addr[0]}} | ({db[7:0], db[15:8]} & {16{addr[0]}}));
    

endmodule
