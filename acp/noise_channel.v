`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:50 09/03/2014 
// Design Name: 
// Module Name:    noise_channel 
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



//The linear feedback shift register (LFSR) generates a pseudo-random bit sequence. 
//It has a 15-bit shift register with feedback. When clocked by the frequency timer, 
//the low two bits (0 and 1) are XORed, all bits are shifted right by one, and the 
//result of the XOR is put into the now-empty high bit. If width mode is 1 (NR43), 
//the XOR result is ALSO put into bit 6 AFTER the shift, resulting in a 7-bit LFSR. 
//The waveform output is bit 0 of the LFSR, INVERTED.
//SOURCE: http://gbdev.gg8.se/wiki/articles/Gameboy_sound_hardware

module noise_channel(note_in,
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
	 
	 wire [1:0] porta_speed_sel;
	 assign porta_speed_sel = 0;
	 
	 wire [5:0] porta_out;
	 
	 wire [5:0] fx_mux_out;
	 
	 wire basefreq;
	 wire buffreq;

	 reg porta_en;

initial begin
	porta_en <= 0;
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
	

FX_porta noiz_porta (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_out	(porta_out),
	.speed_sel 	(porta_speed_sel),
	.en			(porta_en),  //used to be butt_1
	.clk50mhz	(clk50mhz)
	);
	
mux4to1 noiz_FX_mux (
	.in_a		(note_in),
	.in_b		(porta_out),
	.in_c		(0),
	.in_d		(0),
	.mux_sel	(fx_sel),
	.mux_out	(fx_mux_out)
);


base_freq_genx64 noise_freqgen ( //SQUARE CHANNEL 1
	.note_in		(fx_mux_out),
	.clk50mhz	(clk50mhz),
	.freq_out	(basefreq)
);

BUFG freq1_bufg (.I (basefreq), .O (buffreq)); //a clock buffer? 



noise_gen nogen4 (
	.base_freq (buffreq),
	.noise_out (wave_out),
	.en		  (channel_en)
);

/*	 
//SQUARE WAVE CHANNEL
square_gen sqgen1 ( 	
	.base_freq	(buffreq),
	.square_out	(wave_out),
	.en			(channel_en)
);
*/


endmodule





module noise_gen(
					base_freq,
					noise_out,
					en
);

input base_freq;
input en;
reg [5:0] count;
output reg [4:0] noise_out;

wire [15:0] lsfr_data;

//reg randbit;

linear_feedback_shift_reg lsfr1(
	.clk		(base_freq),
	.data		(lsfr_data),
	.en		(en)	
	);


initial 
begin
count = 0;
noise_out = 4'b0000;
end

always@(posedge base_freq)
begin

	if (count >= 32)
	begin
		count <= 0;
	end
	
	if (en) 
	begin
		count <= count + 1;
		noise_out <= lsfr_data[0] << 3; //lsfr data generates random bits every bfg clock cycle
	end
	else
	begin
		count <= 0;
		noise_out <= 4'b0000;
	end
	
		//put noise generating code here


end

endmodule


module linear_feedback_shift_reg(						
						clk,
						data,
						en
);

input clk;
output reg [15:0] data;
input en;

wire feedback_bit;


initial
begin
	data = 16'b0000_0000_0000_0001;

end

assign feedback_bit = ((data[15] ^ data[13]) ^ data[12]) ^ data[10];

always@(posedge clk)
begin
	if(en)
	begin
		data <= {data[14],
					data[13],
					data[12],
					data[11],
					data[10],
					data[9],
					data[8],
					data[7],
					data[6],
					data[5],
					data[4],
					data[3],
					data[2],
					data[1],
					data[0],
					feedback_bit};

	end	
	else
	begin
		data <= data;
	end	
end

endmodule
