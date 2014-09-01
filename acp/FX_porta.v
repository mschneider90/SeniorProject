`timescale 1ns / 1ns

module FX_porta(
	note_in,
	note_clk,
	note_out,
	en,
	clk50mhz
    );
	 
input note_clk;
input clk50mhz;
input [5:0] note_in;
input en;
output reg [5:0] note_out;
//integer base_freq;

reg [5:0] prev_note;
reg [5:0] prev_note_A;
reg [5:0] current_note;
//integer count;
//reg note_clk;
//reg note_chg;
reg en_flag;



//wire [5:0] subdiv; 
//wire [5:0] distance;
//wire up;

wire [5:0] subdiv;
wire [5:0] distance;
wire up;


//reg [15:0] count;
//output reg freq_out;




initial
begin
//subdiv <= 0;
//distance <= 1;
//up <= 0;

//count <= 0;
//freq_out = 0;
note_out = 0;
//note_chg <= 0;
prev_note <= 0;
en_flag <= 0;
//previousNote <= 0; 
end


/*
always@(note_in)
begin
	prev_note <= current_note;
	current_note <= note_in;
end
*/


//always@(*) 
//begin
//use assign statements if these are wires instead of always block. 
assign distance = (prev_note_A>note_in) ?  (prev_note_A - note_in) : (note_in - prev_note_A);
assign up = (prev_note_A > note_in) ? 0 : 1;
assign subdiv = (distance > 4 ) ?  (distance / 4) : 1; //if distance is greater than 4, we divide it by 4. Otherwise subdiv is just 1. 
//s[1] <= (a[1]>a[2])?(a[1]-a[2]):(a[2]-a[1]);
//end

always@ (posedge clk50mhz)
begin

	prev_note <= current_note;
	current_note <= note_in;
			
			if(current_note != prev_note) 
			begin
				prev_note_A <= prev_note;
			end
	
	
	/*
	if (en)
	begin
		if(en_flag == 0)
		begin
			en_flag <= 1;
			note_out <= current_note;
		end
	
	end
		else 
	begin
		en_flag <=0;
	end
*/
	


end


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
			
				if ((note_in - note_out) < subdiv) //if the distance between the notes is less than a single subdiv
				begin
					note_out <= note_in; //then just assign the note out to note in. avoids overshoot. 
				end
				else
				begin
					note_out <= note_out + subdiv;
				end
			end
			
		end
		
		else 
		begin
		
			if(note_out > note_in)
			begin
			
				if ((note_out - note_in) < subdiv)
				begin
					note_out <= note_in;
				end
				else
				begin
					note_out <= note_out - subdiv;
				end
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
