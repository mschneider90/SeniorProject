`timescale 1ns / 1ps

module Mux2to1 #(parameter IN_WIDTH = 16,
                 parameter SEL_WIDTH = 1;
                 parameter OUT_WIDTH = 16)
					 (input[IN_WIDTH-1:0] in_A,
					  input[IN-WIDTH-1:0] in_B,
					  input[SEL_WIDTH-1:0] sel,
					  output[OUT_WIDTH-1:0] mux_out);
					  
parameter SEL_A = 0;
parameter SEL_B = 1;

reg[OUT_WIDTH-1:0] out_tmp;
assign #1 mux_out = out_tmp;
					  
always@(*) begin
	case (sel)
		SEL_A: out_tmp <= in_A; 
		SEL_B: out_tmp <= in_B;
		default: out_tmp <= in_A;
	endcase
end

endmodule
