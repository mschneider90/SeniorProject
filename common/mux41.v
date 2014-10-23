`timescale 1ns / 1ps

module mux_4to1 #(parameter width = 32)
                 (input [width-1:0] in_A,
                  input [width-1:0] in_B,
				  input [width-1:0] in_C,
				  input [width-1:0] in_D,
				  input [1:0] mux_sel,
				  output reg [width-1:0] out);
						
parameter SEL_A = 2'b00;
parameter SEL_B = 2'b01;
parameter SEL_C = 2'b10;
parameter SEL_D = 2'b11;
						
always@(*) begin
	case (mux_sel) 
		SEL_A: out = in_A;
		SEL_B: out = in_B;
		SEL_C: out = in_C;
		SEL_D: out = in_D;
	endcase
end

endmodule
