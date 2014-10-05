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
	 
	 
	 
	 








endmodule
