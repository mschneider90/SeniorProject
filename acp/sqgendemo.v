`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module sqgendemo(clk,
						butt_1, butt_2, butt_3, butt_4,
						oct,
						volsel,
						audio_out,
						SECCTR
    );

output reg SECCTR;
input clk;
input butt_1, butt_2, butt_3, butt_4;

//input wavesel;
input [1:0] volsel;
//reg wavesel;
input [5:0] oct;
//wire [3:0] tri_out;
//wire [3:0] sq_out; 
output wire [7:0] audio_out;
//wire freq;
//wire freq2;
wire basefreq1;
wire basefreq2;
wire basefreq3;
wire basefreq4;

wire buffreq1;
wire buffreq2;
wire buffreq3;
wire buffreq4;



reg [5:0] note_in;
reg [5:0] note_in2;
reg [5:0] note_in3;
reg [5:0] note_in4;

wire [3:0] tr1;
wire [3:0] tr2;
wire [3:0] sq1;
wire [3:0] sq2;

wire [5:0] porta_out;

reg porta_en;


//reg [9:0] counter;

integer note_1;
integer note_2; 
integer note_3; 
integer note_4;

integer SecondCtr;
integer StateCtr; 
 
FX_porta porta1 (
	.note_in 	(note_in2),
	.clk50mhz	(clk),
	.note_out	(porta_out),
	.en			(porta_en)  //used to be butt_1
	);

base_freq_genx64 freqgen (
	.note_in		(porta_out),
	.clk50mhz	(clk),
	.freq_out	(basefreq1)
	);
	
base_freq_genx64 freqgen2 (
	.note_in	   (note_in), //changed to test PORTA1. change back when done. 
	.clk50mhz	(clk),
	.freq_out	(basefreq2)
);

base_freq_genx64 freqgen3 (
	.note_in	   (note_in3),
	.clk50mhz	(clk),
	.freq_out	(basefreq3)
);

base_freq_genx64 freqgen4 (
	.note_in	   (note_in4),
	.clk50mhz	(clk),
	.freq_out	(basefreq4)
);


//SQUARE WAVE CHANNEL 1 
square_gen sqgen1 ( 	
	.base_freq	(buffreq1),
	.square_out	(sq1)
	);

//SQUARE WAVE CHANNEL 2
square_gen sqgen2 ( 	
	.base_freq	(buffreq3),
	.square_out	(sq2)
	);

//TRIANGLE WAVE CHANNEL 3
trigen trgen1 (
	.base_freq (buffreq2),
	.triangle_out (tr1),
	.en (butt_3)
);


//TRIANGEL WAVE CHANNEL 4
trigen trgen2 (   //change trigen to trigen8bit to make an 8 bit triangle wave
	.base_freq (buffreq4),
	.triangle_out (tr2),
	.en (butt_3)
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
	.vol1 (volsel),
	.out (audio_out)
);

BUFG freq1_bufg (.I (basefreq1), .O (buffreq1)); //a clock buffer? 
BUFG freq2_bufg (.I (basefreq2), .O (buffreq2));
BUFG freq3_bufg (.I (basefreq3), .O (buffreq3));
BUFG freq4_bufg (.I (basefreq4), .O (buffreq4));


	initial begin
	//	counter = 0;
	//	wavesel = 0;
		SecondCtr <= 0;
		SECCTR <= 0;
		StateCtr <= 0;
		porta_en <= 0;
		note_in <= 31;
		note_1 <= 0;
		note_2 <= 0;
		note_3 <= 0;
		note_4 <= 0;
	end
	

always@(posedge clk)
begin

//note_1 = 1;
// note_2 = 13;
// note_3 = 25;
//note_4 = 37;
/*
case(oct)

	6'b000001:
	begin
		note_1 <= 3;
		note_2 <= 15;
		note_3 <= 27;
		note_4 <= 39;
	end

	6'b000010:
	begin
		note_1 <= 5;
		note_2 <= 17;
		note_3 <= 29;
		note_4 <= 41;
	end

	6'b000100:
	begin
		note_1 <= 6;
		note_2 <= 18;
		note_3 <= 30;
		note_4 <= 42;
	end

	6'b001000:
	begin
		note_1 <= 8;
		note_2 <= 20;
		note_3 <= 32;
		note_4 <= 44;
	end

	6'b010000:
	begin
		note_1 <= 10;
		note_2 <= 22;
		note_3 <= 34;
		note_4 <= 46;
	end

	6'b100000:
	begin
		note_1 <= 12;
		note_2 <= 24;
		note_3 <= 36;
		note_4 <= 48;
	end

	default:
	begin
		note_1 <= 1;
		note_2 <= 13;
		note_3 <= 25;
		note_4 <= 37;
	end

endcase
*/  
 /*
 FX_porta porta1 (
	.note_in 	(note_in),
	.clk50mhz	(clk),
	.note_out	(porta_out),
	.en			(porta_en)  //used to be butt_1
	);
 */

	if(butt_4) //button 4 is being reassigned as an "RST COUNTER" button.
	begin
		SecondCtr <= 0;
		StateCtr <= 0;
		SECCTR <= 0;
	end
	else
	begin

		SecondCtr <= SecondCtr + 1;
	end

	if (SecondCtr >= 50000000)
	begin
		SECCTR <= ~SECCTR;
		StateCtr <= StateCtr + 1;
		SecondCtr <= 0;
		
		if (StateCtr > 8)
		begin
			StateCtr <= 0;
		end
		
		case(StateCtr)  
			0:
				begin
					note_in <= 26;
					
				end
			1:
				begin
					porta_en <= 1;
					note_in <= 34;
				end
			2:
				begin
					note_in <= 46;
				end
			3: 
				begin
					note_in <= 22;
				end
			4:
				begin
					porta_en <= 1;
				end		
			5: 
				begin
					porta_en <= 0;
				end		
			6: 
				begin
					porta_en <= 0;
				end		
			7: 
				begin
					porta_en <= 0;
				end		
			8:
				begin
					porta_en <= 0;
				end		
			default:
				begin
					porta_en <= 0;
				end
		endcase
	
		
	end

 
	
 
 
/*
if(butt_1)
begin
	 note_in = note_1; //maybe instead of assigning note_in to 0 or note_1, we use an enable wire to the next module. 
								//0This prevents porta from getting a 0 as the next note
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
	 note_in2 = note_1;
end
else 
begin
	note_in2 = 0;
end

if(butt_4)
begin
	 note_in4 = note_2;
end
else 
begin
	note_in4 = 0;
end
*/



end






endmodule
