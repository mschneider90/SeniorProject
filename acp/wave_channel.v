`timescale 1ns / 1ns//////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:30:21 08/31/2014 
// Design Name: 
// Module Name:    wave_channel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sq_channel( 	note_in,
							note_clk,
							channel_en,
							fx_sel,
							fx_optA,
							fx_optB,
							clk50mhz,
							wave_out
    );
	 
	 input [5:0] note_in;
	 input note_clk;
	 input channel_en;
	 input [1:0] fx_sel;
	 input [1:0] fx_optA;
	 input [1:0] fx_optB; 
	 
	 input clk50mhz;
	 
	 
	 output wire [3:0] wave_out;
	 


	 wire [5:0] fx_mux_out;
	 
	 wire basefreq;
	 wire buffreq;
	 
		 
	//porta module specific wires	 
	reg porta_en;
	wire [1:0] porta_speed_sel;
	assign porta_speed_sel = 1;
	wire [5:0] porta_out;
	 

	
	//vibrato module specific wires
	
	wire [5:0] vibra_out;
	wire [1:0] vibra_speed;
	wire [1:0] vibra_depth;
	wire [2:0] vibra_offset_mul;
	wire vibra_offset_dir;
	wire [3:0] vib_offset_mux_out;	 
	reg vibra_en;

	//testing specific assignments: only for testing a configuration. 
	assign vibra_speed = 3;
	assign vibra_depth = 3;
/*
	.note_in		(note_in),  //6 bits
	.note_clk	(note_clk), //1 bit
	.note_out	(vibra_out), //6 bits
	.speed		(vibra_speed),  //speed: two bits FXA
	.depth		(vibra_depth),   //depth: two bits FXB
	.offset_mul	(vibra_offset_mul), //3 bits
	.offset_dir	(vibra_offset_dir), //1 bit
	.en			(vibra_en), //1 bit
	.clk50mhz	(clk50mhz) //1 bit
);*/





initial begin
	porta_en <= 0;
	vibra_en <= 0;
	
end
	 
always@(posedge clk50mhz)	 	 
begin
case(fx_sel)
0: 
begin
porta_en <= 0;
vibra_en <= 0;
end
1:
begin
porta_en <= 1;
vibra_en <= 0;
end
2:
begin
porta_en <= 0;
vibra_en <= 1;
end
3:
begin
porta_en <= 0;
vibra_en <=0;
end
default:
begin
porta_en <= 0;
vibra_en <= 0;
end
endcase	 
end
	

	
FX_porta sq_porta (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.speed_sel 	(fx_optA), //two bits FXA
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk50mhz)
	);
	
	
	///9/24/2014: work on this. This is the declaration for the vibrato effect. Ensure it's correct then begin building the vibrato module. 
FX_vibrato sq_vibra (
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
	
mux4to1 sq_FX_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(vibra_out),
	.in_d		(0),
	.mux_sel	(fx_sel),
	.mux_out	(fx_mux_out)
);



mux_4to1_4bit vibrato_offset_mux (
	.in_a		(4'b0),
	.in_b		(4'b0),
	.in_c		({vib_offset_dir,vib_offset_mul}),
	.in_d		(4'b0),
	.mux_sel	(fx_sel),
	.mux_out	(vib_offset_mux_out)
);

base_freq_genx64 sq_freqgen ( //SQUARE CHANNEL 1
	.note_in		(fx_mux_out),
	.clk50mhz	(clk50mhz),
	.freq_out	(basefreq),
	.offset_mult (vib_offset_mux_out[2:0]),
	.offset_dir (vib_offset_mux_out[3])
);

BUFG freq1_bufg (.I (basefreq), .O (buffreq)); //a clock buffer? 
	 
//SQUARE WAVE CHANNEL
square_gen sqgen1 ( 	
	.base_freq	(buffreq),
	.square_out	(wave_out),
	.en			(channel_en)
);

endmodule
