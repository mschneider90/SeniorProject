//d_flipflop.v
//N-input d-flipflop w/ enable

`timescale 1ns / 1ps

module DFlipFlop #(parameter DATA_WIDTH = 8)
                  (input      [DATA_WIDTH-1:0] d_in, 
				   input                       clk, 
                   input                       write_en,
				   output reg [DATA_WIDTH-1:0] q_out);

initial begin
	q_out = 0;
end

always@(posedge clk) begin
    if (write_en) 
        q_out <= d_in;
    else
        q_out <= q_out;
end

endmodule
