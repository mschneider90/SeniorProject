`timescale 1ns / 1ps

module envelope_control(
									attack,
									decay,
									length,
									enable_out,
									rst,
									note_clk,
									square_in,
									square_out,
    );

input rst; //this input reloads the length counter
input [1:0] attack;
input [1:0] decay;
input [2:0] length;	 
output enable_out; //enable_out is the control signal which controls the output of the wave channel. May not be necessary. 
input note_clk;
input [3:0] square_in; //square in takes one of two values: 0000 or 1111. 
output [3:0] square_out;

reg [2:0] env_vol;

reg [4:0] atktime; //atktime is the proportional part of attack. multiply by 8 and note_clk to get total attack time. 
reg [4:0] dectime;
reg [15:0] lentime;

reg atkctr;
reg decctr;
reg lenctr;

reg atkstate;

//reg totaltime;

//code to attempt if timing is bad with rst/
//always@(posedge clk)
/*
begin
	if (rst)
	begin
		lenrst <= 1; ?? this probabaly wouldn't work
	end

end
*/

always @ (posedge note_clk or posedge rst)
begin
	
	//reload length counter on RST and posedge note_clk. 
	//ensure these happen at the same time or there will be problems. 
	if(rst)
	begin
		lenctr <= 0;
		//sent "RST_en" signal to reset the enable bit. 
	end
	

	
	case (attack)
		0: atktime <= 0; //calculations assuming 390625 note clock at 50MHz base clock 
		1: atktime <= 1; //1 = 8note clocks = approx 1/32th note at 120bpm
		2: atktime <= 2; // 16: approx 1/8th note
		3: atktime <= 3;
		default: atktime <= 0; 
	endcase
	
	case (decay)
		0: dectime <= 0;
		1: dectime <= 1;
		2: dectime <= 2;
		3: dectime <= 3;
		default: dectime <= 0;
	endcase
	
	case (length)
		0: lentime <= 2;
		1: lentime <= 4;
		2: lentime <= 8;
		3: lentime <= 16;
		4: lentime <= 32;
		5: lentime <= 64;
		6: lentime <= 128;
		7: lentime <= 256;
		8: lentime <= 512; 
		default: lentime <=  32;
	endcase
	
	//channel enable and length counter decrement. 
	if (lenctr <= lentime)
	begin
		lenctr <= lenctr + 1;
		enable_out <= 1; //enable the channel signal. 
	
	//this is where the envelope control can go. 
	//code for implementing note attack time
		if (atktime == 0)
		begin
			env_vol <= 7; 
		end
	   else 
		begin
		if (lenctr % atktime == 0)
			begin
			   if( env_vol < 7) 
				begin
					env_vol <= env_vol + 1;
				end
			end
		end
	 //end code for attack time 
	 
	 
	 
	end	
	else
	begin
		enable_out <= 0; //disable the channel when the length goes to 0. 
	end
	
	
	
	//volume control block. 
	if(square_in == 4'b0000)
	begin
		square_out = 4'b0000;
	end
	else
	begin
		case (env_vol)
			0: square_out = 4'b0001; 
			1: square_out = 4'b0011;
			2: square_out = 4'b0101;
			3: square_out = 4'b0111;
			4: square_out = 4'b1001;
			5: square_out = 4'b1011;
			6: square_out = 4'b1101;
			7: square_out = 4'b1111;
			default: square_out = 4'b1111;
		endcase
	end
	//end volume control. 
	
	
	// we need to have an  "envelope period" in order to apply the envelope. 
	// it is possible to derive this from the length. 
	
	//also need to determine how the envelope will be applied on only the top part of the square wave.
	//if sq_in == 4'b0000 then sq_out <= 4'b0000 else sq_out = envelope value.  
	
	
	/* this code won't work. we need to trigger the attack at a time right after the note starts 
	if (atktime == 0) 
	begin
		square_out <= square_in;	
	endcase
	end
	else if (atktime > 0)
	begin 
	
	end */ 
	/*
	else if (atktime == 2)
	begin
	
	
	end
	else if (atktime == 3)
	begin
	
	
	end
	*/




end


endmodule
