/*
~~~REVISION HISTORY~~~
4/7/2013 Michael: Cleaned up code, added in constants. 
4/11 3:30pm paul: attempted to trig'd vsync on posedge hsync. may cause glitches, see //begin vsync pulse
						changed timing values in test bench to reflect real-world values. now simulator timebar represents
						real-world measurable values. 
						
*/


/* with a 25MHz clock, we have a 40ns clock period.

*/
`timescale 1ns/100ps  //including this in every module significantly improves simulation speed (like 10x faster, no shit)

module VGA(rst, clk50MHz, hsync, vsync, rgb);
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

output reg [7:0] rgb;

reg clk25MHz;
reg [10:0] cycle;
reg [10:0] hcycle;

initial begin
	vsync = 1;
	hsync = 1;
	clk25MHz = 0;
	cycle = 0;
	hcycle = 0;
end

always@(posedge clk50MHz) begin
		clk25MHz = ~clk25MHz;
end

always@(posedge clk25MHz) begin
	if (!rst) begin
		cycle <= cycle + 1;  //increment cycle counter. Counts # of posedge clk transitions. 
		if (cycle == CLK_PER_LINE) begin  //800 cycles is one horizontal line
			hcycle <= hcycle + 1; //increment line count
			cycle <= 0;				 //reset cycle count for next h line
		end

		//----------Color Signal Output
		//Color signal should be valid between for the entire H_RES and V_RES periods, starting after back porch ends.
		if (cycle > H_SYNC_WIDTH + H_BPORCH && cycle < H_SYNC_WIDTH + H_BPORCH + H_RES) begin 
			if (hcycle > V_SYNC_WIDTH + V_BPORCH && hcycle < V_SYNC_WIDTH + V_BPORCH + V_RES) begin 
				if(hcycle < 192)
					rgb <= 8'b11100000;
				else begin
					if(hcycle < 350)
						rgb <= 8'b00011100;
					else begin
						if(hcycle < 509)
							rgb <= 8'b00000011;
					end
				end
			end
		end
		else
			rgb <= 8'bzzzzzzzz;
		
//----------Hsync & Vsync Output	

		if (cycle == 0) //begin hsync pulse
			hsync <= 0;
		if (cycle == H_SYNC_WIDTH) //end hsync pulse
			hsync <= 1;
		
		if (hcycle == 0) //begin vsync pulse
			vsync <= 0;
		if (hcycle == V_SYNC_WIDTH) //end vsync pulse
			vsync <= 1;
			
//////////////////////////////	/
		if (hcycle == LINE_PER_FRAME) 
			hcycle <= 0;
	end
	
//----------If RESET 
	else begin 
		cycle <= 0;
		hcycle <= 0;
		hsync <= 1;
		vsync <= 1;
	end
end
/////////////////

endmodule

		
	
	