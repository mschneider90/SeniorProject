`timescale 1ns / 100ps

module color_gen(row, col, output_valid, rgb);

input [10:0] col;
input [10:0] row; 
input output_valid;

output reg [7:0] rgb;

reg [10:0] i;
reg [10:0] j;

always@(row, col) begin
	if (output_valid) begin
		if (col < 213)
			rgb <= 8'b11100000;
		else begin
			if (col < 426)
				rgb <= 8'b00011100;
			else
				rgb <= 8'b00000011;
		end
	end
	else begin
		rgb <= 8'bzzzzzzzz;
	end
end


endmodule
