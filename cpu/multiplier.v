`timescale 1ns / 1ps

module multiplier #(parameter width = 32)
                   (input [width-1:0] in_A,
						  input [width-1:0] in_B,
						  input write_en, 
						  input clk,
						  output [width-1:0] out_hi,
						  output [width-1:0] out_lo);
						  
reg [width-1:0] hi;
reg [width-1:0] lo;

assign out_hi = hi;
assign out_lo = lo;
						  
always@(posedge clk) begin
	if (write_en)
		{hi, lo} = in_A * in_B;
end

endmodule
