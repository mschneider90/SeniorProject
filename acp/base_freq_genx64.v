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
2: base_freq = 11274;3: base_freq = 10641;4: base_freq = 10044;5: base_freq = 9480;6: base_freq = 8948;7: base_freq = 8446;8: base_freq = 7972;9: base_freq = 7525;10: base_freq = 7102;11: base_freq = 6704;12: base_freq = 6327;13: base_freq = 5972;14: base_freq = 5637;15: base_freq = 5321;16: base_freq = 5022;17: base_freq = 4740;18: base_freq = 4474;19: base_freq = 4223;20: base_freq = 3986;21: base_freq = 3762;22: base_freq = 3551;23: base_freq = 3352;24: base_freq = 3164;25: base_freq = 2986;26: base_freq = 2819;27: base_freq = 2660;28: base_freq = 2511;29: base_freq = 2370;30: base_freq = 2237;31: base_freq = 2112;32: base_freq = 1993;33: base_freq = 1881;34: base_freq = 1776;35: base_freq = 1676;36: base_freq = 1582;37: base_freq = 1493;38: base_freq = 1409;39: base_freq = 1330;40: base_freq = 1256;41: base_freq = 1185;42: base_freq = 1119;43: base_freq = 1056;44: base_freq = 997;45: base_freq = 941;46: base_freq = 888;47: base_freq = 838;48: base_freq = 791;49: base_freq = 747;50: base_freq = 705;51: base_freq = 665;52: base_freq = 628;53: base_freq = 593;54: base_freq = 559;55: base_freq = 528;56: base_freq = 498;57: base_freq = 470;58: base_freq = 444;59: base_freq = 419;60: base_freq = 395;61: base_freq = 373;62: base_freq = 352;63: base_freq = 333;default: base_freq = 0;endcase

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
