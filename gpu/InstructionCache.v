`timescale 1ns / 1ps

module InstructionCache #(parameter DATA_WIDTH = 16,
								  parameter ADDR_WIDTH = 4,
								  parameter DATA_DEPTH = 16)
								 (input[DATA_WIDTH-1:0]  data_in,
								  input[ADDR_WIDTH-1:0]  addr,
								  input                  clk,
								  input                  we,
								  output[DATA_WIDTH-1:0] data_out);

reg[DATA_WIDTH-1:0] data[DATA_DEPTH-1:0];

assign #1 data_out = data_read;
				  
always@(posedge clk) begin
	if (we)
		data[addr] <= data_in;
	else
		data_read <= data[addr];
end


endmodule
