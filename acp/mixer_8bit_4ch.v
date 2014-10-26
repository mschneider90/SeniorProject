`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mayzeles
// 
// Create Date:    unknown
// Module Name:    mixer_8bit_4ch: the 4-channel (4-bit wide each) audio mixer with volume control and 8-bit output
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 
// This mixer won't bake your cake. But it might move your buns. 

// This noise
module mixer_8bit_4ch(
	in0,
	in1,
	in2,
	in3,
	vol0,
	vol1,
	vol2,
	vol3,
	out
    );

input [3:0] in0;
input [3:0] in1;
input [3:0] in2;
input [3:0] in3;

input [1:0] vol0;
input [1:0] vol1;
input [1:0] vol2;
input [1:0] vol3;

reg [7:0] ch0;
reg [7:0] ch1;
reg [7:0] ch2;
reg [7:0] ch3;

//reg [7:0] tmpch1;
//reg [7:0] tmpch2;
//reg [7:0] tempresult;


output reg [7:0] out;

always @(in0, in1, in2, in3, ch0, ch1, ch2, ch3, vol0, vol1, vol2, vol3) //should this be a sampling rate? who knows 
begin

ch0 <= in0 << 2;
ch1 <= in1 << 2;
ch2 <= in2 << 2;
ch3 <= in3 << 2;

//volume1: first volume ch. may be used on tri


case (vol0) //1/4, 1/2, 3/4 and full volume. Note ordering of volumes from low to hi: 00, 01, 11, 10. 

2'b00: //routine for caculating volume. 00: 1/4
begin
	ch0 <= in0;
end
2'b01: //01: 1/2
begin
	ch0 <= in0 << 1;
end
2'b10: //10: 3/4 volume 
begin
	ch0 <= (in0) + (in0 << 1);
end
2'b11: //11: full volume 
begin
	ch0 <= in0 << 2;
end
default:
begin
	ch0 <=  in0 << 2; 
end
endcase 

case (vol1) //vol 1: the second square channel  
2'b00: 
begin	
	ch1 <= in1;
end
2'b01: //01: 1/2
begin
	ch1 <= in1 << 1;
end
2'b10: //10: 3/4 volume 
begin
	ch1 <= (in1) + (in1 << 1);
end
2'b11: //11: full volume 
begin
	ch1 <= in1 << 2;
end
default:
begin
	ch1 <=  in1 << 2; 
end
endcase 

case (vol2) //1/4, 1/2, 3/4 and full volume. Note ordering of volumes from low to hi: 00, 01, 11, 10. 
2'b00: //routine for caculating volume. 00: 1/4
begin
	ch2 <= in2;
end
2'b01: //01: 1/2
begin
	ch2 <= in2 << 1;
end
2'b10: //10: 3/4 volume 
begin
	ch2 <= (in2) + (in2 << 1);
end
2'b11: //11: full volume 
begin
	ch2 <= in2 << 2;
end
default:
begin
	ch2 <=  in2 << 2; 
end
endcase 

case (vol3) //1/4, 1/2, 3/4 and full volume. Note ordering of volumes from low to hi: 00, 01, 11, 10. 

2'b00: //routine for caculating volume. 00: 1/4
begin
	
	ch3 <= in3;
end
2'b01: //01: 1/2
begin
	ch3 <= in3 << 1;
end
2'b10: //10: 3/4 volume 
begin
	ch3 <= (in3) + (in3 << 1);
end
2'b11: //11: full volume 
begin
	ch3 <= in3 << 2;
end
default:
begin
	ch3 <=  in3 << 2; 
end
endcase 

//tempresult = (ch1 + ch2 + ch3 + ch4);

//tempresult = tempresult >> 2;

out = ch0 + ch1 + ch2 + ch3;

end

endmodule
