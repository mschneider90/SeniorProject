`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module sqgendemo(clk,
							butt_1, butt_2, butt_3, butt_4,
							oct,
							//wavesel,
							audio_out
    );


input clk;
input butt_1, butt_2, butt_3, butt_4;

//input wavesel;
reg wavesel;
input [5:0] oct;
//wire [3:0] tri_out;
//wire [3:0] sq_out; 
output wire [7:0] audio_out;
wire freq;
wire freq2;
wire basefreq2;

reg [5:0] note_in;
reg [5:0] note_in2;
reg [5:0] note_in3;
reg [5:0] note_in4;

wire [3:0] tr1;
wire [3:0] tr2;
wire [3:0] sq1;
wire [3:0] sq2;



reg [9:0] counter;
integer note_1;
integer note_2; 
integer note_3; 
integer note_4;

base_freq_genx64 freqgen (
	.note_in		(note_in),
	.clk50mhz	(clk),
	.freq_out	(freq)
	);
	
base_freq_genx64 freqgen2 (
	.note_in	   (note_in2),
	.clk50mhz	(clk),
	.freq_out	(basefreq2)
);


square_gen sqgen1 ( 	
	.base_freq	(freq2),
	.square_out	(sq1)
	);
	
square_gen sqgen2 ( 	
	.base_freq	(freq2),
	.square_out	(sq2)
	);

trigen trgen1 (
	.base_freq (basefreq2),
	.triangle_out (tr1)
);

trigen trgen2 (
	.base_freq (basefreq2),
	.triangle_out (tr2)
);


/*
mux2_4bit waveselmux (
	.d_in0 (sq_out),
	.d_in1 (tri_out),
	.sel (wavesel),
	.d_out (audio_out)
);
*/ 


mixer_8bit_4ch mixer (
	.in1 (sq1),
	.in2 (sq2),
	.in3 (tr1),
	.in4 (tr2),
	.out (audio_out)
);

BUFG clk1_bufg (.I (freq), .O (freq2)); //a clock buffer? 


	initial begin
	counter = 0;
	wavesel = 0;
	end
	

always@(posedge clk)
begin

note_1 = 1;
 note_2 = 13;
 note_3 = 25;
note_4 = 37;
case(oct)

	6'b000001:
	begin
		note_1 = 3;
		note_2 = 15;
		note_3 = 27;
		note_4 = 39;
	end

	6'b000010:
	begin
		note_1 = 5;
		note_2 = 17;
		note_3 = 29;
		note_4 = 41;
	end

	6'b000100:
	begin
		note_1 = 6;
		note_2 = 18;
		note_3 = 30;
		note_4 = 42;
	end

	6'b001000:
	begin
		note_1 = 8;
		note_2 = 20;
		note_3 = 32;
		note_4 = 44;
	end

	6'b010000:
	begin
		note_1 = 10;
		note_2 = 22;
		note_3 = 34;
		note_4 = 46;
	end

	6'b100000:
	begin
		note_1 = 12;
		note_2 = 24;
		note_3 = 36;
		note_4 = 48;
	end

	default:
	begin
		note_1 = 1;
		note_2 = 13;
		note_3 = 25;
		note_4 = 37;
	end

endcase
 
 
 
if(butt_1)
begin
	 note_in = note_1;
end
else
begin
	note_in = 0;
end

if(butt_2)
begin
	 note_in3 = note_2;
end
else
begin
	note_in3 = 0;
end


if(butt_3)
begin
	 note_in2 = note_3;
end
else 
begin
	note_in2 = 0;
end

if(butt_4)
begin
	 note_in4 = note_4;
end
else 
begin
	note_in4 = 0;
end




end






endmodule
