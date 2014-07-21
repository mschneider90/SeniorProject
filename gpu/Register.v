`timescale 1ns / 1ps

module Register #(parameter REG_WIDTH = 8)
                 (input[REG_WIDTH-1:0]      write_data,
					   input                     write_enable,
						input                     clk,
						input                     reset,
						output reg[REG_WIDTH-1:0] read_data);
						
reg[REG_WIDTH-1:0] data;

assign read_data = data;
						
always@(posedge clk) begin
	if (reset)
		data <= 0;
	else begin
		if (writeEnable) begin
			data <= write_data;
		end
		else begin
			data <= data;
		end
	end
end

endmodule
