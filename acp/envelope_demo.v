`timescale 1ns / 1ps

module envelope_demo(
						clk,
						butt_1, butt_2, butt_3, butt_4,
						switch,
						//volsel,
						audio_out,
						//SECCTR
    );

//output reg SECCTR;
input clk;
input butt_1, butt_2, butt_3, butt_4;
input [7:0] switch;
output wire [7:0] audio_out;
/////////////////////////////////////////////




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



sq_channel envtest1 (
			.note_in		(note_in1),
			.note_clk	(note_clk),
			.note_rst	(butt_1),
			.note_length (switch[7:5]),
			.env_atk		(switch[4:3]), //envelope attack and decay
			.env_dec		(switch[2:1]),
			.fx_sel		(2'b00),
			.fx_optA		(2'b00),
			.fx_optB		(2'b00),
			.clk50mhz	(clk),
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


initial
begin

	note_in1 <= 42;

	note_clk_count <= 0;
	note_clk <= 0;
/*
	SecondCtr <= 0;
	SECCTR <= 0;
	StateCtr <= 0;
*/

end




always@ (posedge clk) 
begin

//note clock counter
	note_clk_count <= note_clk_count + 1;
	if (note_clk_count >= 390625)
	begin
		note_clk_count <= 0;
		note_clk <= ~note_clk;
		
		///////////////////////////////////
		//extra non-critical demo shit
		if (butt_2)
		begin
			if (note_in1 <=63)
			begin
				note_in1 <= note_in1 + 1; //wooooeeep woooeep
			end else
			begin
				note_in1 <= 0;
			end
		end 
		if (butt_3)
		begin
				//ADD A COUNTER TO MAKE THE EFFECT SLOWER OR LOOP OR WHATEVER
			
			if (note_in1 > 0)  
			begin
				note_in1 <= note_in1 - 1;  //ppeeeooowww peeeowww
			end else
			begin
				note_in1 <= 63;
			end
		end 
		////end extra non-crit demo shit
		///////////////////////////////////
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
