`timescale 1ns / 1ps
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
//input wavesel;
input [1:0] volsel;
wire [1:0] volstatic; //testing signal
assign volstatic = 2'b00;

//reg wavesel;
input [5:0] oct;
//wire [3:0] tri_out;
//wire [3:0] sq_out; 
output wire [7:0] audio_out;
//wire freq;
//wire freq2;
//wire basefreq1;
//wire basefreq2;
//wire basefreq3;
//wire basefreq4;

//wire buffreq1;
//wire buffreq2;
//wire buffreq3;
//wire buffreq4;

reg sq1_en;
reg sq2_en;
reg tr1_en;
reg noise_en;

reg [5:0] note_in;
reg [5:0] note_in2;
reg [5:0] note_in3;
reg [5:0] note_in4;

wire [3:0] tr1;
//wire [3:0] tr2;
wire [3:0] sq1;
wire [3:0] sq2;
wire [3:0] noise;

wire [5:0] porta_out;


reg [1:0] FX1_sel;
reg [1:0] FX2_sel;
reg [1:0] FX3_sel;
//wire [5:0] FX1_mux_out;


//reg porta_en;


//reg [9:0] counter;

integer note_1; 
integer note_2; 
integer note_3; 
integer note_4;

integer SecondCtr;
integer StateCtr; 
integer note_clk_count;

reg note_clk;


sq_channel sq_ch1(
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.channel_en	(sq1_en & butt_1),
	.fx_sel		(FX1_sel),
	.clk50mhz	(clk),
	.wave_out	(sq1)
    );
	 
sq_channel sq_ch2(
	.note_in 	(note_in3),
	.note_clk	(note_clk),
	.channel_en	(sq2_en & butt_2),
	.fx_sel		(FX2_sel),
	.clk50mhz	(clk),
	.wave_out	(sq2)
	);
	
triangle_channel tr_ch3(
	.note_in 	(note_in2),
	.note_clk	(note_clk),
	.channel_en	(tr1_en & butt_3),
	.fx_sel		(FX3_sel),
	.clk50mhz	(clk),
	.wave_out	(tr1)
);

noise_channel noise_cha4(
	.note_in		({oct[3:0],1'b0, 1'b0}),
	.note_clk	(note_clk),
	.channel_en	(butt_4), //also NEED TO add noise_en when not just testing.
	.fx_sel		(FX2_sel),
	.clk50mhz	(clk),
	.wave_out	(noise)
);


mixer_8bit_4ch mixer (
	.in1 (sq1),
	.in2 (sq2),
	.in3 (tr1),
	.in4 (noise),
	.vol1 (volsel), //changed from volsel to volstatic for testing purposes. 
	.out (audio_out)
);

/*
BUFG freq1_bufg (.I (basefreq1), .O (buffreq1)); //a clock buffer? 
BUFG freq2_bufg (.I (basefreq2), .O (buffreq2));
BUFG freq3_bufg (.I (basefreq3), .O (buffreq3));
BUFG freq4_bufg (.I (basefreq4), .O (buffreq4));
*/

	initial begin
	//	counter = 0;
	//	wavesel = 0;
		SecondCtr <= 0;
		SECCTR <= 0;
		StateCtr <= 0;
		//porta_en <= 0;
		note_in <= 31;
		note_in2 <= 0;
		note_in3 <= 0;
		note_in4 <= 40;
		note_1 <= 0;
		note_2 <= 0;
		note_3 <= 0;
		note_4 <= 43;
		sq1_en <= 1;
		sq2_en <= 1;
		tr1_en <= 1;
		noise_en <=1;
		note_clk_count <= 0;
		note_clk <= 0;
		FX1_sel <= 0;
		FX2_sel <= 0;
		FX3_sel <= 0;
	end
	
//assign F = (prev_note_A>note_in) ?  (prev_note_A - note_in) : (note_in - prev_note_A);

always@(posedge clk)
begin

	FX1_sel <= (oct[5] == 1) ? 1 : 0;
	FX2_sel <= (oct[4] == 1) ? 1 : 0;
	
	//this routine creates generates a note clock -- timing for the actual notes. This determines the tempo. 
	note_clk_count <= note_clk_count + 1;
	if (note_clk_count >= 318750) //implementation value: 3187500 OR//796875 //testbench value: 318750
	begin
		note_clk_count <= 0;
		note_clk <= ~note_clk;
	end


	//the following two if blocks determine the timing of the states. 
	if(oct[0]) //button 4 is being reassigned as an "RST COUNTER" button.
	begin
		SecondCtr <= 0;
		StateCtr <= 0;
		SECCTR <= 0;
	end
	else
	begin
	SecondCtr <= SecondCtr + 1;
	end



	//this if  block sets a number of predetermined states for testing purposes. 
	if (SecondCtr >= 6000000) //implementation value: 6,000,000 (about 1/8 s = 125bpm (0,4,8,12) to 50,000,000 //test value: 100,000 //this sets the time it takes for the state to transition
	begin
		SECCTR <= ~SECCTR; //SECCTR blinks the led once per clock cycle. 
		StateCtr <= StateCtr + 1;
		SecondCtr <= 0;
		
		if (StateCtr >= 15)
		begin
			StateCtr <= 0;
		end
		
		case(StateCtr)  
			0:
				begin
					note_in <= 41;
					note_in3 <= 1;
					note_in2 <= 1;

					
					sq1_en <=1;
					
					//porta_en <= 0;
					//FX1_sel <= 1;
				end
			1:
				begin
					//note_in <= 0;
					note_in2 <= 13;
					
					sq1_en <=0;
				end
			2:
				begin
					note_in <= 46;
					note_in3 <= 13;
					note_in2 <= 25;
					
					sq1_en <=1;
				end
			3: 
				begin
					//note_in <= 0;
					note_in2 <= 1;
					
					sq1_en <=0;
				end
			4:
				begin
					note_in <= 44;
					note_in3 <= 1;
					note_in2 <= 13;
					//FX1_sel <= 0;
					sq1_en <=1;
				end		
			5: 
				begin
					//note_in <= 0;
					note_in2 <= 25;
					
					sq1_en <=0;

				end		
			6: 
				begin
					note_in <= 37;
					note_in3 <= 13;
					note_in2 <= 1;
					
					sq1_en <=1;
				end		
			7: 
				begin
					//note_in <= 0;
					note_in2 <= 13;
					
					sq1_en <=0;
				end		
			8:
				begin
					note_in <= 37;
					note_in3 <= 1;
					note_in2 <= 25;
					//FX1_sel <= 1;
					
					sq1_en <=1;
				end
			9:
				begin
					//note_in <= 0;
					note_in2 <= 1;
					
					sq1_en <=0;
				end
			10:
				begin
					note_in <= 39;
					note_in3 <= 13;
					note_in2 <= 13;
					
					sq1_en <=1;
				end	
			11:
				begin
					note_in <= 41;
					note_in2 <= 25;
					
					sq1_en <=1;
				end	
			12:
				begin
					note_in <= 39;
					note_in3 <= 1;
					note_in2 <= 1;
					
					sq1_en <=1;
				end	
			13:
				begin
					//note_in <= 0;
					note_in2 <= 13;
					
					sq1_en <=0;
				end	
			14:
				begin
					note_in <= 51;
					note_in3 <= 13;
					note_in2 <= 25;
					//FX1_sel <= 0;
					
					sq1_en <=1;
				end	
			15:
				begin
					//note_in <= 0;
					note_in2 <= 1;
					
					sq1_en <=0;
					
				end	
				
			default:
				begin
					note_in <= 0;
//					porta_en <= 0;
				end
		endcase
		
		
		end
	
		
		
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





/*
 
FX_porta porta1 (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk)
	);

base_freq_genx64 freqgen ( //SQUARE CHANNEL 1
	.note_in		(FX1_mux_out),
	.clk50mhz	(clk),
	.freq_out	(basefreq1)
	);
	
base_freq_genx64 freqgen2 (  //TRIANGLE CHANNEL 1 
	.note_in	   (note_in2), 
	.clk50mhz	(clk),
	.freq_out	(basefreq2)
);

base_freq_genx64 freqgen3 ( //SQUARE CHANNEL 2 (note_in port changed from note_in3 to note_in to test portamento module. CHange back when done
	.note_in	   (note_in3),
	.clk50mhz	(clk),
	.freq_out	(basefreq3)
);

base_freq_genx64 freqgen4 ( //TRIANGLE CHANNEL 2
	.note_in	   (note_in4),
	.clk50mhz	(clk),
	.freq_out	(basefreq4)
);


//SQUARE WAVE CHANNEL 1 
square_gen sqgen1 ( 	
	.base_freq	(buffreq1),
	.square_out	(sq1),
	.en			(sq1_en && butt_1)
	);

//SQUARE WAVE CHANNEL 2
square_gen sqgen2 ( 	
	.base_freq	(buffreq3),
	.square_out	(sq2),
	.en			(sq2_en && butt_2)
	);

//TRIANGLE WAVE CHANNEL 3
trigen trgen1 (
	.base_freq (buffreq2),
	.triangle_out (tr1),
	.en (tr1_en && butt_3)
);


//TRIANGEL WAVE CHANNEL 4
trigen trgen2 (   //change trigen to trigen8bit to make an 8 bit triangle wave
	.base_freq (buffreq4),
	.triangle_out (tr2),
	.en (butt_4)
);





//Channel 1 FX Selector Multiplexer
mux4to1 FX1_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(0),
	.in_d		(0),
	.mux_sel	(FX1_sel),
	.mux_out	(FX1_mux_out)
);


*/
/*
mux2_4bit waveselmux (
	.d_in0 (sq_out),
	.d_in1 (tri_out),
	.sel (wavesel),
	.d_out (audio_out)
);
*/ 