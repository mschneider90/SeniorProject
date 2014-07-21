`timescale 1ns / 1ps

module SpriteCache #(parameter DATA_WIDTH = 32,
						   parameter ADDR_WIDTH = 8,
						   parameter DATA_DEPTH = 256)
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
