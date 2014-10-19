`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mayzeles
// Create Date:    17:31:55 10/16/2014 
// Module Name:    acp: the moosebox Audio Co-Processor
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 

module acp(
				input clk50MHz,
				input [31:0] m_bus_in,
				input m_ack,
				input [7:0] m_ctrl_in,
				output [7:0] m_ctrl_out,
				output [7:0] audio_out
    );

//output reg SECCTR;
//input clk;
//input butt_1, butt_2, butt_3, butt_4;
//input [7:0] switch;
//output wire [7:0] audio_out;
/////////////////////////////////////////////

//Address register. The ACP register address being written to is loaded in here. 

d_reg address_register(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);


//channel 0: square wave 0 
d_reg ch0_notereg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

d_reg ch0_fxreg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

//channel 1: square wave 1
d_reg ch1_notereg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

d_reg ch1_fxreg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

//channel 2: triangle wave
d_reg ch2_notereg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

d_reg ch2_fxreg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);


//channel 3: noise channel 
d_reg ch3_notereg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);

d_reg ch3_fxreg(
	.clk		(clk50MHz),
	.rst		(),
	.en		(),
	.d 		(m_bus_in[15:0]),
	.q			()
);



//NOTES IN
reg [5:0] note_in1;
//reg [5:0] note_in2;
//reg [5:0] note_in3;
//reg [5:0] note_in4;


//NOTE CLK
reg note_clk;
reg [31:0] note_clk_count; 
//NOTE_RST
//NOTE_LENGTH
//ENV_ATK 
//ENV_DEC
//FX_SEL
//FX_OPTA
//FX_OPTB
//CLK
//OUTPUTS
wire [3:0] sq1;



sq_channel sqch1 (
			.note_in		(note_in1),
			.note_clk	(note_clk),
			.note_rst	(butt_1),
			.note_length (switch[7:5]), 
			.env_atk		(switch[4:3]), //envelope attack and decay
			.env_dec		(switch[2:1]),
			.fx_sel		(2'b00),
			.fx_optA		(2'b00),
			.fx_optB		(2'b00),
			.clk50mhz	(clk50MHz),
			.wave_out	(sq1)
);


mixer_8bit_4ch mixer (
	.in1 (sq1),
	.in2 (4'b0000),
	.in3 (4'b0000),
	.in4 (4'b0000),
	.vol1 (2'b10), 
	.out (audio_out)
);






always@ (posedge clk) 
begin

//note clock counter
	note_clk_count <= note_clk_count + 1;
	if (note_clk_count >= 390625)
	begin
		note_clk_count <= 0;
		note_clk <= ~note_clk;
	end
//end note clk counter

/*
if(switch[0])
	begin
		SecondCtr <= 0;
		StateCtr <= 0;
		SECCTR <= 0;
	end
else
	begin
	SecondCtr <= SecondCtr + 1;
	end
*/
end






endmodule
