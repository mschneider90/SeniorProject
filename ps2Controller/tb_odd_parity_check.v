`timescale 1ns / 1ps

//6/25 PASS
module tb_odd_parity_check();

reg serial;
reg clk;
reg reset;
wire parity;

odd_parity_check pc(.serial_in(serial), .clk(clk), .reset(reset), .parity_valid(parity));

initial begin
	clk <= 0;
	reset <= 1;
	serial <= 0;
	#5
	reset <= 0;
	#10
	serial <= 1; //Parity should be asserted after this is clocked in
	#10
	serial <= 0;
	#10
	serial <= 1; //Parity should be de-asserted after this is clocked in
	#10
	serial <= 0;
	#10
	reset <= 1;
end

always begin
	#5 clk = ~clk;
end


endmodule
