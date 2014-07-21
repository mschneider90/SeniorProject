`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module mux2_4bit( d_in0, 
						d_in1, 
						sel,
						d_out
    );
	 
	input [3:0] d_in0;
	input [3:0] d_in1;
	input sel;
	output reg [3:0] d_out;
	
always@(d_in0, d_in1, sel)
begin
	case (sel)
		1'b0: d_out = d_in0; 
		1'b1: d_out = d_in1;
		default: d_out = d_in0;
	endcase
end


endmodule
