`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:07 09/03/2014 
// Design Name: 
// Module Name:    triangle_channel 
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
module triangle_channel(
							note_in,
							note_clk,
							channel_en,
							fx_sel,
							clk50mhz,
							wave_out
    );
	 
	 input [5:0] note_in;
	 input note_clk;
	 input channel_en;
	 input [1:0] fx_sel;
	 input clk50mhz;
	 output wire [3:0] wave_out;
	 
	 
	 wire [5:0] porta_out;
	 
	 wire [5:0] fx_mux_out;
	 
	 wire basefreq;
	 wire buffreq;
	 
	 reg porta_en;
	 
	 wire [1:0] porta_speed_sel;
	 assign porta_speed_sel = 1;
	 
initial begin
	porta_en = 0;
end	 
	 
always@(posedge clk50mhz)	 	 
begin
case(fx_sel)
0: 
begin
porta_en <= 0;
end
1:
begin
porta_en <= 1;
end
2:
begin
porta_en <= 0;
end
3:
begin
porta_en <= 0;
end
default:
begin
porta_en <= 0;
end
endcase	 
end
	 
FX_porta tr_porta (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk50mhz)
	);
	
mux4to1 tr_FX_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(0),
	.in_d		(0),
	.mux_sel	(fx_sel),
	.mux_out	(fx_mux_out)
);


base_freq_genx64 tr_freqgen ( //SQUARE CHANNEL 1
	.note_in		(fx_mux_out),
	.clk50mhz	(clk50mhz),
	.freq_out	(basefreq)
);

BUFG freq3_bufg (.I (basefreq), .O (buffreq)); //a clock buffer? 
	 
//SQUARE WAVE CHANNEL
trigen trgen1 ( 	
	.base_freq	(buffreq),
	.triangle_out	(wave_out),
	.en			(channel_en)
);


endmodule
