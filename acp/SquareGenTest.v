`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////

module SquareGenTest(
    );

reg clk;
reg [5:0] note_in;
wire square_out;
wire freq;

base_freq_genx64 freqgen (
	.note_in		(note_in),
	.clk50mhz	(clk),
	.freq_out	(freq)
	);
	
square_gen sqgen ( 	
	.base_freq	(freq),
	.square_out	(square_out)
	);


initial
begin
#1 clk = 0;
#1 note_in = 63;
#10000000 note_in = 51;
#10000000 note_in = 39;


end


always
begin
#1 clk = ~clk;
end

endmodule
