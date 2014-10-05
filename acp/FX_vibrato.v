`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:32 09/28/2014 
// Design Name: 
// Module Name:    FX_vibrato 
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



/*
FX_vibrato sq_vibra (
	.note_in		(note_in),  //6 bits
	.note_clk	(note_clk), //1 bit
	.note_out	(vibra_out), //6 bits
	.speed		(vibra_speed),  //speed: two bits FXA
	.depth		(vibra_depth),   //depth: two bits FXB
	.offset_mul	(vibra_offset_mul), //3 bits
	.offset_dir	(vibra_offset_dir), //1 bit
	.en			(vibra_en), //1 bit
	.clk50mhz	(clk50mhz) //1 bit
);

*/


module FX_vibrato(
						note_in,
						note_clk,
						note_out,
						speed, 
						depth,
						offset_mul,
						offset_dir,
						en,
						clk50mhz
    );


input [5:0] note_in;
input note_clk;
output [5:0] note_out;
input [1:0] speed; //when speed goes up, vibrato slows down. 
input [1:0] depth;

output reg [2:0] offset_mul;
output reg offset_dir;

input en;
input clk50mhz;

reg [4:0] speed_counter;
reg [3:0] count;  


assign note_out = note_in; //note coming in doesn't change, we just apply some pitch bending via the BFG. 

initial 
begin
	speed_counter = 0;
	offset_mul = 0;
	count = 0;
	offset_dir = 0;

end


always@(posedge note_clk)
	begin
	
	if (count >= speed)
	begin
		count = 0;
		speed_counter = speed_counter + 1;
	end
	
	
	if(depth == 3)
	begin
		case(speed_counter)
			0: offset_mul = 0; 
			1: offset_mul = 1; 
			2: offset_mul = 2; 
			3: offset_mul = 3; 
			4: offset_mul = 4; 
			5: offset_mul = 5; 
			6: offset_mul = 6; 
			7: offset_mul = 7; 
			8: offset_mul = 7; 
			9: offset_mul = 6; 
			10: offset_mul = 5; 
			11: offset_mul = 4; 
			12: offset_mul = 3; 
			13: offset_mul = 2; 
			14: offset_mul = 1; 
			15: offset_mul = 0; 
			default: offset_mul = 0; 
		endcase
			
	end
	else if(depth == 2)
	begin
		case(speed_counter)
			0: offset_mul = 0; 
			1: offset_mul = 1; 
			2: offset_mul = 1; 
			3: offset_mul = 2; 
			4: offset_mul = 2; 
			5: offset_mul = 3; 
			6: offset_mul = 3; 
			7: offset_mul = 4; 
			8: offset_mul = 4; 
			9: offset_mul = 3; 
			10: offset_mul = 3; 
			11: offset_mul = 2; 
			12: offset_mul = 2; 
			13: offset_mul = 1; 
			14: offset_mul = 1; 
			15: offset_mul = 0;
			default: offset_mul = 0; 
		endcase			
	end
	else if (depth == 1)
	begin
		case(speed_counter)
			0: offset_mul = 0; 
			1: offset_mul = 0; 
			2: offset_mul = 1; 
			3: offset_mul = 1; 
			4: offset_mul = 1; 
			5: offset_mul = 1; 
			6: offset_mul = 2; 
			7: offset_mul = 2; 
			8: offset_mul = 2; 
			9: offset_mul = 2; 
			10: offset_mul = 1; 
			11: offset_mul = 1; 
			12: offset_mul = 1; 
			13: offset_mul = 1; 
			14: offset_mul = 0; 
			15: offset_mul = 0;
			default: offset_mul = 0; 
		endcase			
	
	end
	else if (depth == 0)
	begin
		case(speed_counter)
			0: offset_mul = 0; 
			1: offset_mul = 0; 
			2: offset_mul = 0; 
			3: offset_mul = 0; 
			4: offset_mul = 1; 
			5: offset_mul = 1; 
			6: offset_mul = 1; 
			7: offset_mul = 1; 
			8: offset_mul = 1; 
			9: offset_mul = 1; 
			10: offset_mul = 1; 
			11: offset_mul = 1; 
			12: offset_mul = 0; 
			13: offset_mul = 0; 
			14: offset_mul = 0; 
			15: offset_mul = 0; 
			default: offset_mul = 0; 
		endcase
	end
	
	
	if(speed_counter >= 16) //if we reach the end of the speed ctr, flip the offset direction. 
	begin
		speed_counter = 0;
		offset_dir = ~offset_dir;
	end
	if(en)
	begin
		count= count + 1;
	end
	else
	begin
		count = 0;
	end 
	
	//if (count >= 16)
	//begin
	//	count = 0;
	//end

	//if(!en)
	//begin
	//	count = 0;
	//end


end

endmodule
