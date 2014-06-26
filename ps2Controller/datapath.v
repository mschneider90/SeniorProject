`timescale 1ns / 1ps

module datapath(input clk,
                input data,
					 input shift_left,
					 input [3:0] addr,
					 input we,
					 output frame_valid,
					 output equal,
					 output parity_ok);
					 
wire [10:0] data_parallel;
wire [7:0] scancode_out;
wire [4:0] even_count;

shift_reg sreg(.clk(clk), .d(data), .en(shift_left), .q(data_parallel), .even_count(even_count);

//Check start and stop bits
assign frame_valid = data_parallel[0] & (~data_parallel[10]);


endmodule
