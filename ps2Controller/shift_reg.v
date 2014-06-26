`timescale 1ns / 1ps

//shift_reg with synchronous reset
//Converts a serial input stream to parallel out

module shift_reg #(parameter width = 11,
                   parameter parity_width = 4)
                  (input clk,
						 input d,
						 input en,
						 input reset,
						 output reg [width-1:0] q
						);
						
reg [3:0] count;
						 
always@(posedge clk) begin
	if (reset)
		q <= 0;
	else begin
		if (en) begin
			q <= q << 1;
			q[0] <= d;
			if (d == 0)
				count <= count + 1;
		end
	end
end
						 



endmodule
