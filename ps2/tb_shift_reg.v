`timescale 1ns / 1ps

//PASS 6/25
module tb_shift_reg();
						 
parameter WIDTH = 8;

reg clk;
reg d;
reg en;
reg reset;
wire[WIDTH-1:0] q;

ShiftReg #(WIDTH) sreg(.clk(clk), .d(d), .en(en), .reset(reset), .q(q));

initial begin
	clk = 0;
	d = 0;
	en = 0;
	reset = 1;
	#5
	en = 1;
	d = 1;
	#10
	reset = 0;
	d = 0;
	#10
	d = 1;
	#10 
	d = 0;
	#10
	d = 1;
	#10 
	d = 0;
	#10
	d = 1;
	#10 
	d = 0;
	#10
	d = 1;
	#10 
	d = 0;
	#10
	reset = 1;
	#10
	d = 1;
end

always begin
	#5 clk = ~clk;
end

endmodule
