/*
~~~REVISION HISTORY~~~
4/7/2013 Michael: Cleaned up code, added in constants. 
4/11 3:30pm paul: attempted to trig'd vsync on posedge hsync. may cause glitches, see //begin vsync pulse
						changed timing values in test bench to reflect real-world values. now simulator timebar represents
						real-world measurable values. 
9/26            : Move sync signals to end so the pixel coordinate matches the counter. Move pixel color data outside of this
                  module. End Captain's Log.
1/9/2014        : opened project. renamed hcycle to row and cycle to col
						
*/


/* with a 25MHz clock, we have a 40ns clock period.

*/
`timescale 1ns/100ps  //including this in every module significantly improves simulation speed (like 10x faster, no shit)

module sync_gen(rst, clk50MHz, hsync, vsync, output_valid, col, row);
																		//time values calculated using 25MHz clk
parameter H_SYNC_WIDTH = 96; 		 //Width of horizontal sync pulse, in clock cycles (3.84us)
parameter H_FPORCH = 16;     		 //Width of horizontal front porch, in clock cycles (0.6us)
parameter H_BPORCH = 48;     		 //Width of horizontal back porch, in clock cycles (1.92us)
parameter V_SYNC_WIDTH = 2;  		 //Width of vertical sync pulse, in lines (1 line = PLD clocks) (64us)
parameter V_FPORCH = 10;     		 //Width of vertical front porch, in lines (320us)
parameter V_BPORCH = 29;    		 //Width of vertical back porch, in lines (928us)
parameter H_RES = 640;      		 //Viewable horizontal resolution, in pixels (25.6us)
parameter V_RES = 480;            //Viewable vertical resolution, in pixels 
parameter CLK_PER_LINE = 800;     //Total clocks per line
parameter LINE_PER_FRAME = 521;   //Total lines per frame

input rst;
input clk50MHz;
output reg vsync;  //NOTE: HSYNC AND VSYNC ARE ACTIVE LOW
output reg hsync;
output reg output_valid;

reg clk25MHz;
output reg [10:0] col;
output reg [10:0] row;

initial begin
	vsync = 1;
	hsync = 1;
	clk25MHz = 0;
	col = 0;
	row = 0;
end

always@(posedge clk50MHz) begin
		clk25MHz = ~clk25MHz;
end

always@(posedge clk25MHz) begin
	if (!rst) begin
		col <= col + 1;  //increment cycle counter. Counts # of posedge clk transitions. 
		if (col == CLK_PER_LINE) begin  //800 cycles is one horizontal line
			row <= row + 1; //increment line count
			col <= 0;				 //reset cycle count for next h line
		end


//----------Hsync & Vsync Output	

		if (col == H_RES + H_FPORCH) //begin hsync pulse
			hsync <= 0;  //active low
		if (col == H_RES + H_FPORCH + H_SYNC_WIDTH) //end hsync pulse
			hsync <= 1;
		
		if (row == V_RES + V_FPORCH) //begin vsync pulse
			vsync <= 0;
		if (row == V_RES + V_FPORCH + V_SYNC_WIDTH) //end vsync pulse
			vsync <= 1;
			
//output colors
		if (col <= H_RES && row <= V_RES)
			output_valid <= 1'b1;
		else
			output_valid <= 1'b0;
			
//////////////////////////////	/
		if (row == LINE_PER_FRAME) 
			row <= 0;
	end
	
//----------If RESET 
	else begin 
		col <= 0;
		row <= 0;
		hsync <= 1;
		vsync <= 1;
	end
end
/////////////////

endmodule

		
	
	