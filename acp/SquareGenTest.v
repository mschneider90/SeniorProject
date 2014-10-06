`timescale 20ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module SquareGenTest(
    );

reg clk;
reg [5:0] note_in;
wire [2:0] offset_multiplier;
wire offset_direction;
reg en;
reg vibra_en;
reg note_clk;
reg[1:0] vibra_speed;
reg[1:0] vibra_depth;
wire[5:0] vibra_out;

wire square_out;
wire freq;



FX_vibrato sq_vibra (
	.note_in		(note_in),  //6 bits
	.note_clk	(note_clk), //1 bit
	.note_out	(vibra_out), //6 bits
	.speed		(vibra_speed),  //speed: two bits FXA
	.depth		(vibra_depth),   //depth: two bits FXB
	.offset_mul	(offset_multiplier), //3 bits
	.offset_dir	(offset_direction), //1 bit
	.en			(vibra_en), //1 bit
	.clk50mhz	(clk) //1 bit
);

base_freq_genx64 freqgen (
	.note_in		(vibra_out),
	.clk50mhz	(clk),
	.freq_out	(freq),
	.offset_mult (offset_multiplier),
	.offset_dir	 (offset_direction)
	);
	
	
/*
	module base_freq_genx64(
	note_in,
	clk50mhz,
	freq_out,
	offset_mult,
	offset_dir
    );
*/


square_gen sqgen ( 	
	.base_freq	(freq),
	.square_out	(square_out),
	.en			(en)
	);


initial
begin
#1 clk = 0;
#1 note_clk = 0;
#1 note_in = 42;
#1 en = 1;
#1 vibra_speed = 0;
#1 vibra_speed = 0;
#100000 vibra_en = 1;
#100000 vibra_speed = 3;
#100000 vibra_depth = 3;

//#100000 offset_direction = 1;
//#1 offset_multiplier = 6;
#200000 note_in = 52;

#50000000 vibra_depth = 1;
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
