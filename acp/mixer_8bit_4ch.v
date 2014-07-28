`timescale 1ns / 1ns

module mixer_8bit_4ch(
	in1,
	in2,
	in3,
	in4,
	vol1,
//	vol2,
//	vol3,
//	vol4,
	out
    );

input [3:0] in1;
input [3:0] in2;
input [3:0] in3;
input [3:0] in4;

input [1:0] vol1;

reg [7:0] ch1;
reg [7:0] ch2;
reg [7:0] ch3;
reg [7:0] ch4;

reg [7:0] tmpch1;
reg [7:0] tempresult;


output reg [7:0] out;

always @(in1, in2, in3, in4) //should this be a sampling rate? who knows 
begin


ch1 <= in1 << 2;
ch2 <= in2 << 2;
ch3 <= in3 << 2;
tmpch1 <= in4 << 2;

//volume1: first volume ch. may be used on tri

case (vol1) //1/4, 1/2, 3/4 and full volume. Note ordering of volumes from low to hi: 00, 01, 11, 10. 

2'b00: //routine for caculating volume. 00: 1/4
begin
	
	ch4 <= tmpch1 >> 2;
end
2'b01: //01: 1/2
begin
	ch4 <= tmpch1 >> 1;
end
2'b11: //11: 3/4
begin
	ch4 <= (tmpch1 >> 1) + (tmpch1 >> 2);
end
2'b10: //10: full volume 
begin
	ch4 <= tmpch1;
end
default:
begin
	ch4 <= tmpch1; 
end
endcase 





tempresult = (ch1 + ch2 + ch3 + ch4);

//tempresult = tempresult >> 2;

out = tempresult[7:0];

end

endmodule
