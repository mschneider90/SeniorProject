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
	0: triangle_out = 0;	1: triangle_out = 1;	2: triangle_out = 2;	3: triangle_out = 3;	4: triangle_out = 4;	5: triangle_out = 5;	6: triangle_out = 6;	7: triangle_out = 7;	8: triangle_out = 8;	9: triangle_out = 9;	10: triangle_out = 10;	11: triangle_out = 11;	12: triangle_out = 12;	13: triangle_out = 13;	14: triangle_out = 14;	15: triangle_out = 15;	16: triangle_out = 15;	17: triangle_out = 14;	18: triangle_out = 13;	19: triangle_out = 12;	20: triangle_out = 11;	21: triangle_out = 10;	22: triangle_out = 9;	23: triangle_out = 8;	24: triangle_out = 7;	25: triangle_out = 6;	26: triangle_out = 5;	27: triangle_out = 4;	28: triangle_out = 3;	29: triangle_out = 2;	30: triangle_out = 1;	31: triangle_out = 0;
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
