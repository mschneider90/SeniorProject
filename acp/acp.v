`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Paul Mayzeles
// Create Date:    17:31:55 10/16/2014 
// Module Name:    acp: the moosebox Audio Co-Processor
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 
// Chocolate covered nuts will be accepted by us but are not required to reuse this code.
 
 
 //notes: 10/19/2014
 //need to:
 // modify the mixer module in order to accept 4 volume inputs
 // modify noise and triangle channel in order to work with the updated system
 // test the system skeleton before moving on to make sure it works
 // check synthesis warnings. of note is 'atkctr' and 'decctr' warnings pertaining to fxX_atk and fxX_dec

module acp(
				input clk50MHz,
				input [31:0] m_bus_in,
				input m_ack,
				input [7:0] m_ctrl_in,
				output [7:0] m_ctrl_out,
				output [7:0] audio_out
    );

//output reg SECCTR;
//input clk50MHz;
//input butt_1, butt_2, butt_3, butt_4;
//input [7:0] switch;
//output wire [7:0] audio_out;
/////////////////////////////////////////////

acp_mem_interface acp_memctrl(
		.bus_in		(m_bus_in),
		.ack			(m_ack),
		.clk			(clk50MHz),
//		.bus_out		({16'b0, ),     //[31:0] 
		.ctrl_in		(m_ctrl_in),
		.ctrl_out	(m_ctrl_out),
		.addr_write (m_addr_we),
		.data_we		(m_data_we)
);


//Connections for Address Register 
//wire m_addr_we;
//wire m_data_we;
wire [15:0] m_addr;



/////////////////////////////////////////////
//CHANNEL REGISTERS
wire [15:0] ch0_nreg_out;
wire [15:0] ch0_fxreg_out;

wire [15:0] ch1_nreg_out;
wire [15:0] ch1_fxreg_out;

wire [15:0] ch2_nreg_out;
wire [15:0] ch2_fxreg_out;

wire [15:0] ch3_nreg_out;
wire [15:0] ch3_fxreg_out;


//NOTE CLK
reg note_clk;
reg [31:0] note_clk_count; 
//CH NOTE REG
wire [5:0] ch0_notein;
wire [5:0] ch1_notein;
wire [5:0] ch2_notein;
wire [5:0] ch3_notein;
wire [1:0] ch0_vol;
wire [1:0] ch1_vol;
wire [1:0] ch2_vol;
wire [1:0] ch3_vol;
wire [2:0] ch0_len;
wire [2:0] ch1_len;
wire [2:0] ch2_len;
wire [2:0] ch3_len;
wire ch0_rst;
wire ch1_rst;
wire ch2_rst;
wire ch3_rst;

//CH FX REG 
wire [1:0] fx0_atk;
wire [1:0] fx0_dec;
wire [1:0] fx0_sel;
wire [1:0] fx0_optA;
wire [1:0] fx0_optB;

wire [1:0] fx1_atk;
wire [1:0] fx1_dec;
wire [1:0] fx1_sel;
wire [1:0] fx1_optA;
wire [1:0] fx1_optB;

wire [1:0] fx2_atk;
wire [1:0] fx2_dec;
wire [1:0] fx2_sel;
wire [1:0] fx2_optA;
wire [1:0] fx2_optB;

wire [1:0] fx3_atk;
wire [1:0] fx3_dec;
wire [1:0] fx3_sel;
wire [1:0] fx3_optA;
wire [1:0] fx3_optB;

wire ch0_fx_we;
wire ch1_fx_we;
wire ch2_fx_we;
wire ch3_fx_we;

wire ch0_nr_we;
wire ch1_nr_we;
wire ch2_nr_we;
wire ch3_nr_we;


//CLK
//OUTPUTS
wire [3:0] sq0;
wire [3:0] sq1;
wire [3:0] tr2;
wire [3:0] nz3;

//Address register. The ACP register address being written to is loaded in here. 
d_reg address_register(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(m_addr_we),
	.d 		(m_bus_in[15:0]),
	.q			(m_addr)
); //create a decoder to process the output of the address 


decoder_1to8 address_decoder(
		.select		(m_addr[2:0]),
		.data_in		(m_data_we),   //these are the "memory addresses" of the acp registers. 
		.data_out	({	ch3_fx_we, //111  0x7
							ch3_nr_we,   //110  0x6
							ch2_fx_we, //101  0x5
							ch2_nr_we,	  //100  0x4
							ch1_fx_we, //011  0x3
							ch1_nr_we,	  //010  0x2
							ch0_fx_we, //001  0x1
							ch0_nr_we})  //000  0x0
);



//channel 0: square wave 0 
d_reg #(.WIDTH(16)) ch0_notereg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch0_nr_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch0_nreg_out)
);



d_reg #(.WIDTH(16)) ch0_fxreg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch0_fx_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch0_fxreg_out)
);

assign ch0_rst		= ch0_nr_we;
assign ch0_len		= ch0_nreg_out[10:8];
assign ch0_vol		= ch0_nreg_out[7:6];
assign ch0_notein = ch0_nreg_out[5:0];

assign fx0_optB = ch0_fxreg_out[9:8];
assign fx0_optA = ch0_fxreg_out[7:6];
assign fx0_sel = ch0_fxreg_out[5:4];
assign fx0_dec = ch0_fxreg_out[3:2];
assign fx0_atk = ch0_fxreg_out[1:0];

//channel 1: square wave 1
d_reg #(.WIDTH(16)) ch1_notereg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch1_nr_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch1_nreg_out)
);

d_reg #(.WIDTH(16)) ch1_fxreg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch1_fx_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch1_fxreg_out)
);

assign ch1_rst		= ch1_nr_we;
assign ch1_len		= ch1_nreg_out[10:8];
assign ch1_vol		= ch1_nreg_out[7:6];
assign ch1_notein = ch1_nreg_out[5:0];

assign fx1_optB = ch1_fxreg_out[9:8];
assign fx1_optA = ch1_fxreg_out[7:6];
assign fx1_sel = ch1_fxreg_out[5:4];
assign fx1_dec = ch1_fxreg_out[3:2];
assign fx1_atk = ch1_fxreg_out[1:0];

//channel 2: triangle wave
d_reg #(.WIDTH(16)) ch2_notereg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch2_nr_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch2_nreg_out)
);

d_reg #(.WIDTH(16)) ch2_fxreg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch2_fx_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch2_fxreg_out)
);

assign ch2_rst		= ch2_nr_we;
assign ch2_len		= ch2_nreg_out[10:8];
assign ch2_vol		= ch2_nreg_out[7:6];
assign ch2_notein = ch2_nreg_out[5:0];

assign fx2_optB = ch2_fxreg_out[9:8];
assign fx2_optA = ch2_fxreg_out[7:6];
assign fx2_sel = ch2_fxreg_out[5:4];
assign fx2_dec = ch2_fxreg_out[3:2];
assign fx2_atk = ch2_fxreg_out[1:0];

//channel 3: noise channel 
d_reg #(.WIDTH(16)) ch3_notereg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch3_nr_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch3_nreg_out)
);

d_reg #(.WIDTH(16)) ch3_fxreg(
	.clk		(clk50MHz),
	.reset	(1'b0),
	.en		(ch3_fx_we),
	.d 		(m_bus_in[15:0]),
	.q			(ch3_fxreg_out)
);

assign ch3_rst		= ch3_nr_we;
assign ch3_len		= ch3_nreg_out[10:8];
assign ch3_vol		= ch3_nreg_out[7:6];
assign ch3_notein = ch3_nreg_out[5:0];

assign fx3_optB = ch3_fxreg_out[9:8];
assign fx3_optA = ch3_fxreg_out[7:6];
assign fx3_sel = ch3_fxreg_out[5:4];
assign fx3_dec = ch3_fxreg_out[3:2];
assign fx3_atk = ch3_fxreg_out[1:0];

//NOTES IN
//reg [5:0] note_in1;
//reg [5:0] note_in2;
//reg [5:0] note_in3;
//reg [5:0] note_in4;


sq_channel sqch0 (
			.note_in		(ch0_notein[5:0]),
			.note_clk	(note_clk),
			.note_rst	(ch0_rst),
			.note_length (ch0_len[2:0]), 
			.env_atk		(fx0_atk[1:0]), //envelope attack and decay
			.env_dec		(fx0_dec[1:0]),
			.fx_sel		(fx0_sel[1:0]),
			.fx_optA		(fx0_optA[1:0]),
			.fx_optB		(fx0_optB[1:0]),
			.clk50mhz	(clk50MHz),
			.wave_out	(sq0[3:0])
);

sq_channel sqch1 (
			.note_in		(ch1_notein[5:0]),
			.note_clk	(note_clk),
			.note_rst	(ch1_rst),
			.note_length (ch1_len[2:0]), 
			.env_atk		(fx1_atk[1:0]), //envelope attack and decay
			.env_dec		(fx1_dec[1:0]),
			.fx_sel		(fx1_sel[1:0]),
			.fx_optA		(fx1_optA[1:0]),
			.fx_optB		(fx1_optB[1:0]),
			.clk50mhz	(clk50MHz),
			.wave_out	(sq1[3:0])
);

tr_channel trch2 (
			.note_in		(ch2_notein[5:0]),
			.note_clk	(note_clk),
			.note_rst	(ch2_rst),
			.note_length (ch2_len[2:0]), 
			.env_atk		(fx2_atk[1:0]), //envelope attack and decay
			.env_dec		(fx2_dec[1:0]),
			.fx_sel		(fx2_sel[1:0]),
			.fx_optA		(fx2_optA[1:0]),
			.fx_optB		(fx2_optB[1:0]),
			.clk50mhz	(clk50MHz),
			.wave_out	(tr2[3:0])
);

nz_channel nzch3 (
			.note_in		(ch3_notein[5:0]),
			.note_clk	(note_clk),
			.note_rst	(ch3_rst),
			.note_length (ch3_len[2:0]), 
			.env_atk		(fx3_atk[1:0]), //envelope attack and decay
			.env_dec		(fx3_dec[1:0]),
			.fx_sel		(fx3_sel[1:0]),
			.fx_optA		(fx3_optA[1:0]),
			.fx_optB		(fx3_optB[1:0]),
			.clk50mhz	(clk50MHz),
			.wave_out	(nz3[3:0])
);


mixer_8bit_4ch mixer (
	.in0 (sq0[3:0]),
	.in1 (sq1[3:0]),
	.in2 (tr2[3:0]),
	.in3 (nz3[3:0]),
	.vol0 (ch0_vol),
	.vol1 (ch1_vol),
	.vol2 (ch2_vol),
	.vol3 (ch3_vol),
	.out (audio_out)
);


initial 
begin
note_clk <= 0;
note_clk_count <= 0;

end
always@ (posedge clk50MHz) 
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
