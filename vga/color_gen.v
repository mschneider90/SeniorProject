`timescale 1ns / 100ps

module color_gen #(parameter COLOR_DEPTH = 8)
                  (input output_valid,
                   input [COLOR_DEPTH-1:0] pixel,
                   output reg [COLOR_DEPTH-1:0] rgb);

always@(*) begin
	if (output_valid) begin
        rgb <= pixel;
	end
	else begin
		rgb <= 8'bzzzzzzzz;
	end
end


endmodule
