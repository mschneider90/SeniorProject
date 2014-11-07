`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:19:32 11/06/2014 
// Design Name: 
// Module Name:    FX_slide 
// no overflow correction; note will overflow high or low and may have weird artifacts.
// this is intended to be corrected by setting the appropriate LENGTH bits. 

module FX_slide(
						note_in,
						note_clk,
						note_out,
						speed, 
						direction,
						en,
						rst,
						clk50mhz
    );

input rst;

input [5:0] note_in;
input note_clk;
output reg [5:0] note_out;
input [1:0] speed;  
input [1:0] direction;


input en;
input clk50mhz;

reg [7:0] speed_counter;
reg [4:0] count;  
//reg rst_flag;

initial 
begin
	speed_counter <= 0;
	//offset_mul <= 0;
	count <= 0;
	//rst_flag = 0;
end





always@(posedge note_clk or posedge rst)
begin
	if (rst)
	begin
		speed_counter <= 0;
	end
	else
	begin
	
		if (count >= speed)
		begin
			count <= 0;
			speed_counter <= speed_counter + 1; //add one to the "speed counter"; it is incremented every few counts. 
			//speed_counter = speed_counter + 1;
		
			if (direction[0] == 0)
			begin
				note_out <= note_in - speed_counter; //slide down; 
			end
			
			else if (direction[0] == 1)	
			begin
				note_out <= note_in + speed_counter; //slide up
			end
			
		end
		
			if(en)	
			begin
				count <= count + 1;
			end
			else
			begin
				count <= 0;
			end 
		
		end
	end




endmodule
