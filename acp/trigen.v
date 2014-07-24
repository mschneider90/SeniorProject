`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module trigen(	base_freq,
					triangle_out,
					en
    );

	
	input base_freq; 
	input en;
	reg [5:0] count; //max value 63
	output reg [3:0] triangle_out;

	initial
	begin
	count = 0;
	triangle_out = 0;
	end

	always@(posedge base_freq)
	begin

	case (count)
	0: triangle_out = 0;
	default: triangle_out = 0;
	endcase

	if(en)
	begin
		count= count + 1;
	end
	else
	begin
		count = 0;
	end 
	
	if (count >= 32)
	begin
		count = 0;
	end

	//if(!en)
	//begin
	//	count = 0;
	//end


end


endmodule