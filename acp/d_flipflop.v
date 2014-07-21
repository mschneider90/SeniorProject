//d_flipflop.v
//N-input d-flipflop w/o enable

`timescale 1ns / 1ps

module d_flipflop #(parameter width = 8)
                   (input      [width-1:0] d_in, 
						  input       clk, 
						  output reg [width-1:0] q_out);

initial begin
	q_out <= 0;
end

always@(clk) begin
	 q_out <= d_in;
end

endmodule
