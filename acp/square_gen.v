`timescale 1ns / 1ns
//SQUAREGEN: Generates a square wave at 64x the input frequency. 
module square_gen(
	base_freq,
	square_out//,
	//en
    );

//input en;
input base_freq;
reg [5:0] count; //max value 63
output reg [3:0] square_out;

initial
begin
count = 0;
square_out = 4'b0000;
end

always@(posedge base_freq)
begin


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
count = count + 1;


end


endmodule
