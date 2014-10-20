`timescale 20ns / 1ns

module sq_channel_test(
    );


reg clk;
reg [5:0] note_in;
reg en;
reg note_clk;

reg[1:0] FX1_sel;  
reg[1:0] FX1_optA;
reg[1:0] FX1_optB;

reg [2:0] note_length;
reg [1:0] env_atk;
reg [1:0] env_dec;


wire [3:0] square_out;
//wire freq;


sq_channel UUT3 (
	.note_in 	(note_in),
	.note_clk	(note_clk),
	.note_rst	(en),
	.note_length (note_length),
	.env_atk		(env_atk),
	.env_dec		(env_dec),
	.fx_sel		(FX1_sel),
	.fx_optA		(FX1_optA),
	.fx_optB		(FX1_optB),
	.clk50mhz	(clk),
	.wave_out	(square_out)
    );

/*	note_in,
							note_clk,
							note_rst,
							note_length,
							env_atk, //envelope attack and decay
							env_dec,
							fx_sel,
							fx_optA,
							fx_optB,
							clk50mhz,
							wave_out
    );



*/

initial
begin
#1 clk = 0;
#1 note_clk = 0;
#1 note_in = 42;
#1 env_atk = 1;
#1 env_dec = 2;
#1 note_length = 5;
#1 en = 0;
#390630 en = 0;

#2 en = 1;
#20 en = 0;

//#1 vibra_speed = 0;
//#1 vibra_speed = 0;
#1 FX1_sel = 0;


//#20000000 en = 1;
//#20	  en = 0;

//#100000 FX1_optA = 3;
//#100000 FX1_optB = 3;

//#100000 offset_direction = 1;
//#1 offset_multiplier = 6;
#200000 note_in = 52;

//#50000000 FX1_optB = 1;
//#50000000 
//#10000000 note_in = 51;
//#10000000 note_in = 39;


end


always
begin
#1 clk = ~clk;
end

always 
begin
#390625 note_clk = ~note_clk; //this is so that note_clk * 32 = 1/4 second; 390625. 
end











endmodule
