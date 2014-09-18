`timescale 1ns / 1ns
//SQUAREGEN: Generates a square wave at 64x the input frequency. 
module square_gen(
	base_freq,
	square_out,
	en
    );

//input en;
input base_freq;
input en;
reg [5:0] count; //max value 63
output reg [3:0] square_out;

initial
begin
count = 0;
square_out = 4'b0000;
end

always@(posedge base_freq)
begin

/*
if (count >= 16)
begin
	if (square_out == 4'b0000)
		begin
			square_out = 4'b1111;
		end
	else
		begin
			square_out = 4'b0000;
		end
	count = 0;
end
*/

	case (count)
	0: square_out = 0;	1: square_out = 0;	2: square_out = 0;	3: square_out = 0;	4: square_out = 0;	5: square_out = 0;	6: square_out = 0;	7: square_out = 0;	8: square_out = 0;	9: square_out = 0;	10: square_out = 0;	11: square_out = 0;	12: square_out = 0;	13: square_out = 0;	14: square_out = 0;	15: square_out = 0;	16: square_out = 15;	17: square_out = 15;	18: square_out = 15;	19: square_out = 15;	20: square_out = 15;	21: square_out = 15;	22: square_out = 15;	23: square_out = 15;	24: square_out = 15;	25: square_out = 15;	26: square_out = 15;	27: square_out = 15;	28: square_out = 15;	29: square_out = 15;	30: square_out = 15;	31: square_out = 15;
	default: square_out = 0;
	endcase


	if (count >= 32)
	begin
		count = 0;
	end


	if (en) 
	begin
		count = count + 1;
	end
	else
	begin
		count = 0;
		square_out = 4'b0000;
	end



end


endmodule
