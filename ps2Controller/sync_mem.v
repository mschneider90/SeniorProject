//sync_mem.v
//Synchronous memory with write enable
//output disabled when write enable asserted

`timescale 1ns/1ps

module sync_mem #(parameter data_width = 8,
                  parameter addr_width = 3,
						parameter data_depth = 8)
						
					  (input       [addr_width-1:0] addr,
					   input       [data_width-1:0] data_in,
                  input                        write_en,
                  input                        clk,
					   output reg  [data_width-1:0] data_out);

reg [data_width-1:0] data[data_depth-1:0];

always@(posedge clk) begin
	if (write_en) begin
		#1 data[addr] <= data_in;
		#1 data_out <= 16'bz;
	end
	else 
		#1 data_out <= data[addr];
end

endmodule
