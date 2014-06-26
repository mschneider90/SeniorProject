`timescale 1ns / 1ps

//odd_parity_check
//Checks for valid odd parity, with synchronous reset
//Odd parity: number of ONES plus PARITY BIT equals an odd number

module odd_parity_check (input serial_in,
								 input clk,
								 input reset,
                         output parity_valid);
								 
reg[3:0] counter;

//Valid if it is an odd number
assign parity_valid = counter[0];

always@(posedge clk) begin
	if (reset) begin
		counter <= 0;
	end
	else begin
		counter <= counter + serial_in;
	end
end

endmodule