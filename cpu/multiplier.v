`timescale 1ns / 1ps

module multiplier #(parameter width = 16,
                    parameter out_width = 32)
                   (input [width-1:0] in_A,
						  input [width-1:0] in_B,
						  input write_en, 
						  input clk,
						  output [out_width-1:0] out_hi,
						  output [out_width-1:0] out_lo);
						  
reg [out_width-1:0] hi;
reg [out_width-1:0] lo;

assign out_hi = hi;
assign out_lo = lo;
						  
always@(posedge clk) begin
	if (write_en) begin
        hi <= in_A * in_B;
        lo <= in_A * in_B;
    end
end

endmodule
