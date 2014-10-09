`timescale 1ns / 1ps

module mux21 #(parameter D_WIDTH = 32)
              (input[D_WIDTH-1:0] in_a,
               input[D_WIDTH-1:0] in_b,
               input sel,
               output reg[D_WIDTH-1:0] out);
               
parameter SEL_A = 0;
parameter SEL_B = 1;

always@(*) begin
    case (sel)
        SEL_A: out <= in_a;
        SEL_B: out <= in_b;
        default: out <= 0;
    endcase
end


endmodule
