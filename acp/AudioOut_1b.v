`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:55:02 02/26/2014 
// Design Name: 
// Module Name:    AudioOut_1b 
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
module AudioOut_1b( 	clk,
							butt_1, butt_2, butt_3, butt_4,
							oct,
							audio_out);
						  
	input clk;
	input butt_1;
	input butt_2;
	input butt_3;
	input butt_4;	
	output reg audio_out;
	
integer count1;
//integer count2;
//integer count3;
//integer count4;
//reg countTo;

integer note_1;
integer note_2;
integer note_3;
integer note_4;

input [2:0] oct;


initial
begin
 count1 = 1;
 note_1 = 191113;
 note_2 = 151686;
 note_3 = 95556;
 note_4 = 75843;
//countTo = 0;
end
//integer count1000hz;	
always@(posedge clk)
begin
/*
case(oct)
	0:
begin //"C" octaves
	note_1 = 191113;
	note_2 = 95556;
	note_3 = 47778;
	note_4 = 23889;
end
	1:
begin // "D" octaves
	note_1 = 170262;
	note_2 = 85131;
	note_3 = 42566;
	note_4 = 21283;
end
	2:
begin // "E" octaves
	note_1 = 151686;
	note_2 = 75843;
	note_3 = 37922;
	note_4 = 18961;
end

endcase 
*/

	
	///////////////////
	if(butt_1)
	begin
		if(count1 >= note_1)
		begin
			audio_out = ~audio_out;
			count1 = 0;
		end
	count1 = count1 + 1;
	end
	
	if(butt_2)
	begin
		if(count1 >= note_2)
		begin
			audio_out = ~audio_out;
			count1 = 0;
		end
	count1 = count1 + 1;
	end
	
	if(butt_3)
	begin
		if(count1 >= note_3)
		begin
			audio_out = ~audio_out;
			count1 = 0;
		end
	count1 = count1 + 1;
	end
	
	if(butt_4)
	begin
		if(count1 >= note_4)
		begin
			audio_out = ~audio_out;
			count1 = 0;
		end
	count1 = count1 + 1;
	end
	
//////////////
/*
	if(note_1)
	begin
		countTo = 191113;
	end
	if(note_2)
	begin
		countTo = 180386;
	end
	if(note_3)
	begin
		countTo = 170262;
	end
	if(note_4)
	begin
		countTo = 160706;
	end 
			
	count1 = count1 + 1;
	
	if (count1 == countTo)
	begin
		audio_out = ~audio_out;
		count1 = 0;
		countTo = -1;
	end
	
	
*/

/*
	if(~note_1)
	begin
		count1 = 0;
		audio_out = 0;
	end
	else //if enable button is pressed, then make a sound
	begin
		if(count1 == 191113) //count 1/500th seconds
		begin
			audio_out = ~audio_out;	//make a sound
			count1 = 0;			//reset counter
		end

	count1 = count1 + 1;	//increment counter
	end
*/	
//////////////	
end

endmodule
