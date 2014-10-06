`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//multiplexer.v
//4->1 n-width mux
//sel = 00 => output A
//sel = 01 => output B
//sel = 10 => output C
//sel = 11 => output D
//////////////////////////////////////////////////////////////////////////////////
module mux_4to1_4bit #(parameter DATA_WIDTH = 4)
                (input [DATA_WIDTH-1:0]      in_a,
                 input [DATA_WIDTH-1:0]      in_b, 
                 input [DATA_WIDTH-1:0]      in_c,
                 input [DATA_WIDTH-1:0]      in_d,
                 input [1:0]                 mux_sel, 
                 output reg [DATA_WIDTH-1:0] mux_out);

                 
localparam SEL_A = 2'b00;
localparam SEL_B = 2'b01;
localparam SEL_C = 2'b10;
localparam SEL_D = 2'b11;

always@(*) begin
    case (mux_sel)
        SEL_A: mux_out <= in_a;
        SEL_B: mux_out <= in_b;
        SEL_C: mux_out <= in_c;
        SEL_D: mux_out <= in_d;
    endcase
end

endmodule
