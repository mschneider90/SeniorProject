`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:16 09/28/2014 
// Design Name: 
// Module Name:    bfg_test 
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
module bfg_test(
    );

reg clk50mhz;
reg [5:0] note_in;
reg [2:0] offset_mult;
reg offset_dir;



wire bfg_out;
//reg wavesel;
/*
module base_freq_genx64(
	note_in,
	clk50mhz,
	freq_out,
	offset_mult,
	offset_dir
    );
*/


base_freq_genx64 UUT (note_in, clk50mhz, bfg_out, offset_mult, offset_dir
    );
	 
	 
sq_channel UU3(
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.channel_en	(sq1_en),
	.fx_sel		(FX1_sel),
	.fx_optA		(FX1_optA),
	.fx_optB		(FX1_optB),
	.clk50mhz	(clk),
	.wave_out	(sq1)
    );
	 
	 
	 








endmodule
