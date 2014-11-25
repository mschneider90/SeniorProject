`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:47 11/21/2014 
// Design Name: 
// Module Name:    tb_paultest 




/*
module tb_paultest(

    );


input clk, reset,
            output [iwidth-1:0] pc,       //TODO remove pc and instr once we support reading
            input  [iwidth-1:0] instr,    //from ROM over bus interface
            input  [cwidth-1:0] bus_ctrl_in,
            input               bus_ack,
            input  [4:0]        debug_ra4,
            output [cwidth-1:0] bus_ctrl_out,
            output              bus_req,
            output [dwidth-1:0] debug_rd4,
            input  [dwidth-1:0] bus_data_in,
            output [dwidth-1:0] bus_data_out);

///TB_CPU_SLAVE
mips cpu(.clk(clk25MHz),
         //.clk25MHz(clk50MHz),
         .reset(reset),
			//pc
			//instr
         .bus_ctrl_in(ctrl),
         .bus_ack(ack),
			//debug ra4
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(req[7]),
			//debug rd4
         .bus_data_in(bus),
         .bus_data_out(cpu_out));

//TB_CPU_BUS
mips cpu(.clk(clk50MHz),
         .reset(reset),
			//pc - OK!
			//instr - OK!
         .bus_ctrl_in(ctrl),
         .bus_ack(ack[7]),
			//debug ra4
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(req[7]),
			//debug rd4
         .bus_data_in(bus),
         .bus_data_out(cpu_out),
         .pc(pc),
         .instr(instr));

endmodule */

