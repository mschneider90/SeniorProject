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
wire parity_valid;

shift_reg sreg(.clk(clk), .d(data), .en(shift_left), .q(data_parallel), .reset(reset));
odd_parity_check pcheck(.clk(clk), .serial_in(data), .reset(reset), .parity_valid(parity_valid));

//Check start and stop bits
assign frame_valid = data_parallel[0] & (~data_parallel[10]) & parity_valid;

endmodule
