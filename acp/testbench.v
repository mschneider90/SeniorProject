`timescale 20ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:53 03/12/2014 
// Design Name: 
// Module Name:    sqgendemo_test 
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
module sqgendemo_test(
    );

reg clk;
reg butt_1, butt_2, butt_3, butt_4;
reg [5:0] oct;
reg [1:0] volsel;
wire [7:0] audio_out;
//reg wavesel;


sqgendemo UUT (clk, butt_1, butt_2, butt_3, butt_4, oct, volsel, audio_out
    );

initial begin
#1 butt_2 = 0;
#1 butt_3 = 0;
#1 butt_4 = 0;
#1 butt_4 = 1;
#10 butt_4 = 0;
#1 clk = 0;
#1 volsel = 2'b11;
#1 oct = 6'b000000;
#10000 butt_1 = 1;


#5000000 oct = 6'b100000;



//#1 wavesel = 0;
//#5000000 butt_3 = 1;
#10000000 butt_1 = 0;
#10000000 butt_1 = 1;

//#1		 butt_2 = 1;
//#10000000 butt_2 = 0;

end



always
begin
#1 clk = ~clk;
end

endmodule
