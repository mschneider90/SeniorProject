`timescale 1ns / 1ns

module FX_porta(
	note_in,
	clk50mhz,
	note_out,
	en
    );
	 
input clk50mhz;
input [5:0] note_in;
input en;
output reg [5:0] note_out;
//integer base_freq;

reg [5:0] prev_note;
reg [5:0] current_note;
integer count;
reg note_clk;
reg note_chg;
reg en_flag;



//wire [7:0] currentNote; 
//wire [7:0] previousNote;
wire [5:0] subdiv; 
wire [5:0] distance;
wire up;
//reg [15:0] count;
//output reg freq_out;


/*
d_flipflop porta_shiftreg1(
	.d_in		({2'b00, note_in}),
	.clk		(note_chg),
	.q_out	(currentNote),
);


d_flipflop porta_shiftreg2(
	.d_in		(currentNote),
	.clk		(note_chg),
	.q_out	(previousNote),
);
*/



initial
begin
count <= 0;
//freq_out = 0;
note_clk <= 0;
note_out = 0;
note_chg <= 0;
prev_note <= 0;
en_flag <= 0;
//previousNote <= 0; 
end

always@(posedge clk50mhz)
begin
	count = count + 1;
	if (count >= 10000) //implementation value: 3187500 //testbench value: 10000
	begin
		count = 0;
		note_clk = ~note_clk;
	end
end

always@(note_in)
begin
	prev_note <= current_note;
	current_note <= note_in;
end

assign distance = (prev_note>note_in) ?  (prev_note - note_in) : (note_in - prev_note);
assign up = (prev_note > note_in) ? 0 : 1;
assign subdiv = distance / 4;
//s[1] <= (a[1]>a[2])?(a[1]-a[2]):(a[2]-a[1]);

always@(posedge note_clk)
begin
	
	if(en)
	begin
		
		if(en_flag == 0)
		begin
			en_flag <= 1;
			note_out <= current_note;
		end


		if(up)
		begin
		
			if(note_out < note_in)
			begin
				note_out <= note_out + subdiv;
			end
			
		end
		
		else 
		begin
		
			if(note_out > note_in)
			begin
				note_out <= note_out - subdiv;
			end

		end 
	end 
	else 
	begin
		note_out <= 0;
		en_flag <=0;		
	end

end


endmodule
