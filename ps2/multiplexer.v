//multiplexer.v
//4->1 n-width mux
//sel = 00 => output A
//sel = 01 => output B
//sel = 10 => output C
//sel = 11 => output D

`timescale 1ns / 1ps

module mux4to1 #(parameter DATA_WIDTH = 8)
                (input [DATA_WIDTH-1:0]      in_a,
                 input [DATA_WIDTH-1:0]      in_b, 
                 input [DATA_WIDTH-1:0]      in_c,
                 input [DATA_WIDTH-1:0]      in_d,
                 input [1:0]                 mux_sel, 
                 output reg [DATA_WIDTH-1:0] mux_out);
                 
parameter SEL_A = 2'b00;
parameter SEL_B = 2'b01;
parameter SEL_C = 2'b10;
parameter SEL_D = 2'b11;

always@(*) begin
    case (mux_sel)
        SEL_A: mux_out <= in_a;
        SEL_B: mux_out <= in_b;
        SEL_C: mux_out <= in_c;
        SEL_D: mux_out <= in_d;
    endcase
end

endmodule
