`timescale 1ns / 1ps

//shift_reg with synchronous reset
//Converts a serial input stream to parallel out
//Reads at negedge of clk

module ShiftReg #(parameter width = 8)
                  (input clk,
				   input d,
				   input en,
			       input reset,
				   output reg [width-1:0] q
			      );
						 
always@(negedge clk) begin
	if (reset)
		q <= 0;
	else begin
		if (en) begin
			q <= q << 1;
			q[0] <= d;
		end
	end
end
						 



endmodule
