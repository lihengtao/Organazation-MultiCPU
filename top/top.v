`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:01 06/29/2020 
// Design Name: 
// Module Name:    top 
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
module top(
    input clk,
    input clk_CPU,
    input rst,
    
    output [31:0] PC,
    output [31:0] Inst,
    output [31:0] Data_write,
    output [31:0] Data_read,
    output [31:0] Addr,
    output mem_w,
    output [4:0] state,
    output [2:0] RAMCtrl
    );
    
    MultiCPU cpu(.clk(clk_CPU),
                 .reset(rst),
                 .inst_out(Inst),
                 .PC_out(PC),
                 .mem_w(mem_w),
                 .Addr_out(Addr),
                 .Data_in(Data_read),
                 .Data_out(Data_write),
                 .state(state),
                 .MIO_ready(1'b1),
                 .RAMCtrl(RAMCtrl)
                );

    RAM ram(.clk(clk),
            .addr(Addr[9:0]),
            .din(Data_write),
            .RAMCtrl(RAMCtrl),
            .we(mem_w),
            .dout(Data_read)
           );


endmodule
