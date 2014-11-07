`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mayzeles
// Create Date:    12:37:53 10/26/2014 
// Module Name:    tr_channel: the triangle wave channel.  
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 
// Finding inspiration through moose-related meditation and moose accessories. 

// notes: no envelope control for the triangle channel 
// because that's how dad did it, that's how game boy did it, 
// and it's worked out pretty well so far. 

module tr_channel( 	note_in,
							note_clk,
							note_rst,
							note_length,
							env_atk, //envelope attack and decay are unwired in tr_channel 
							env_dec, //env dec is unwired in tr_channel. preserved for ease of programming
							fx_sel,
							fx_optA,
							fx_optB,
							clk50mhz,
							wave_out
    );
	 
	 input [5:0] note_in;
	 input [2:0] note_length; 	 
	 input [1:0] env_atk;
	 input [1:0] env_dec;
	 input note_clk;
	 input note_rst;
	 input [1:0] fx_sel;
	 input [1:0] fx_optA;
	 input [1:0] fx_optB; 
	 
	 input clk50mhz;
	 
	 wire sq_en;
	 output wire [3:0] wave_out;
	 wire [3:0] sq_out;


	 wire [5:0] fx_mux_out;
	 
	 wire basefreq;
	 wire buffreq;
	 
		 
	//porta module specific wires	 
	reg porta_en;
	//wire [1:0] porta_speed_sel;
	//assign porta_speed_sel = 1;
	wire [5:0] porta_out;
	 

	
	//vibrato module specific wires
	
	wire [5:0] vibra_out;
	//wire [1:0] vibra_speed;
	//wire [1:0] vibra_depth;
	wire [2:0] vibra_offset_mul;
	wire vibra_offset_dir;
	wire [3:0] vib_offset_mux_out;	 
	reg vibra_en;

	//testing specific assignments: only for testing a configuration. 
	//assign vibra_speed = 3;
	//assign vibra_depth = 3;
	//slide module wires
	wire [5:0] slide_out;
	reg slide_en;


initial begin
	porta_en <= 0;
	vibra_en <= 0;
	slide_en <= 0;
end
	 
always@(posedge clk50mhz)	 	 
begin
case(fx_sel)
0: 
begin
porta_en <= 0;
vibra_en <= 0;
slide_en <= 0;
end
1:
begin
porta_en <= 1;
vibra_en <= 0;
slide_en <= 0;
end
2:
begin
porta_en <= 0;
vibra_en <= 1;
slide_en <= 0;
end
3:
begin
porta_en <= 0;
vibra_en <=0;
slide_en <= 1;
end
default:
begin
porta_en <= 0;
vibra_en <= 0;
slide_en <= 0;
end
endcase	 
end

	
FX_porta tr_porta (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.speed_sel 	(fx_optA), //two bits FXA
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk50mhz)
	);
	
	
FX_vibrato tr_vibra (
	.note_in		(note_in),  //6 bits
	.note_clk	(note_clk), //1 bit
	.note_out	(vibra_out), //6 bits
	.speed		(fx_optA),  //speed: two bits FXA. speed: inverse relationship. FXA up, speed goes slower. 
	.depth		(fx_optB),   //depth: two bits FXB
	.offset_mul	(vibra_offset_mul), //3 bits
	.offset_dir	(vibra_offset_dir), //1 bit
	.en			(vibra_en), //1 bit
	.clk50mhz	(clk50mhz) //1 bit
);

FX_slide  sq_slide(
	.note_in		(note_in),
	.note_clk	(note_clk),
	.note_out	(slide_out),
	.speed		(fx_optA),
	.direction	(fx_optB),
	.en			(slide_en),
	.rst			(note_rst),
	.clk50mhz	(clk50mhz)
);	

	
mux4to1 tr_FX_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(vibra_out),
	.in_d		(slide_out),
	.mux_sel	(fx_sel),
	.mux_out	(fx_mux_out)
);

mux_4to1_4bit vibrato_offset_mux_tr (
	.in_a		(4'b0),
	.in_b		(4'b0),
	.in_c		({{vibra_offset_dir},{vibra_offset_mul[2:0]}}),
	.in_d		(4'b0),
	.mux_sel	(fx_sel),
	.mux_out	(vib_offset_mux_out)
);

base_freq_genx64 tr_freqgen ( //SQUARE CHANNEL 1
	.note_in		(fx_mux_out),
	.clk50mhz	(clk50mhz),
	.freq_out	(basefreq),
	.offset_mult (vib_offset_mux_out[2:0]),
	.offset_dir (vib_offset_mux_out[3])
);

BUFG freq1_bufg (.I (basefreq), .O (buffreq)); //a clock buffer? 
	 
//SQUARE WAVE CHANNEL
trigen triangle_generator ( 	
	.base_freq	(buffreq),
	.triangle_out	(sq_out),
	.en			(sq_en) //CHANGE THIS; link to envelope controller 
);

//Envelope Controller
tri_length_control tri_len_ctrl(
		.attack 		(2'b00),  //triangle channel does not support atk/dec
		.decay 		(2'b00),  //triangle channel does not support atk/dec 
		.length		(note_length),
		.enable_out	(sq_en),
		.rst			(note_rst),
		.note_clk 	(note_clk),
		.square_in	(sq_out),
		.square_out (wave_out)
);




endmodule
