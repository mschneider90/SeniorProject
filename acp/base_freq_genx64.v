`timescale 1ns / 1ns
//this module generates a frequency based on an input note.
//1 is a C2. The frequencies generated are 64x the desired frequency. 
 
module base_freq_genx64(
	note_in,
	clk50mhz,
	freq_out
    );

input clk50mhz;
input [5:0] note_in;
integer base_freq;
reg [15:0] count;
output reg freq_out;

initial
begin
count = 0;
freq_out = 0;
end

always@(posedge clk50mhz)
begin

case(note_in)
	0: base_freq = 0; //having this as zero breaks the enable bit on the generator. 
1: base_freq = 11945;
2: base_freq = 11274;

if(count > base_freq)
begin
	freq_out = ~freq_out; //generate the output frequency
	count = 0;
end

if (base_freq == 0) //don't do anything if our base frequency is zero
begin	
	freq_out = 0;
end

count = count + 1;//increment counter for outputting frequency

end



endmodule