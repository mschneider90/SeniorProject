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
							wave_output_en,
							fx_sel,
							clk50mhz,
							wave_out
    );
	 
	 input [5:0] note_in;
	 input note_clk;
	 input wave_output_en;
	 input [1:0] fx_sel;
	 input clk50mhz;
	 wire wave_out;
	 
	 
	 wire porta_out;
	 
	 wire fx_mux_out;
	 
	 wire basefreq;
	 wire buffreq;
	 
	 
FX_porta sq_porta (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk)
	);
	
mux4to1 sq_FX_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(0),
	.in_d		(0),
	.mux_sel	(fx_sel),
	.mux_out	(fx_mux_out)
);


base_freq_genx64 sq_freqgen ( //SQUARE CHANNEL 1
	.note_in		(fx_mux_out),
	.clk50mhz	(clk50mhz),
	.freq_out	(basefreq)
);

BUFG freq1_bufg (.I (basefreq), .O (buffreq)); //a clock buffer? 
	 
//SQUARE WAVE CHANNEL
square_gen sqgen1 ( 	
	.base_freq	(buffreq),
	.square_out	(wave_out),
	.en			(wave_output_en)
);

endmodule
