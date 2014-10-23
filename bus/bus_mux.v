`timescale 1ns / 1ps

module BusMux #(parameter D_WIDTH = 32)
                (input [D_WIDTH-1:0] in_0,
                 input [D_WIDTH-1:0] in_1,
                 input [D_WIDTH-1:0] in_2,
                 input [D_WIDTH-1:0] in_3,
                 input [D_WIDTH-1:0] in_4,
                 input [D_WIDTH-1:0] in_5,
                 input [D_WIDTH-1:0] in_6,
                 input [D_WIDTH-1:0] in_7,
                 input [7:0] sel,
                 output reg [D_WIDTH-1:0] out);

parameter sel_0 = 8'b00000001;
parameter sel_1 = 8'b00000010;
parameter sel_2 = 8'b00000100;
parameter sel_3 = 8'b00001000;
parameter sel_4 = 8'b00010000;
parameter sel_5 = 8'b00100000;
parameter sel_6 = 8'b01000000;
parameter sel_7 = 8'b10000000;
                 
always@(sel, in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7) begin
    case (sel)
        sel_0: begin
            out <= in_0;
        end
        sel_1: begin
            out <= in_1;
        end
        sel_2: begin
            out <= in_2;
        end
        sel_3: begin
            out <= in_3;
        end
        sel_4: begin
            out <= in_4;
        end
        sel_5: begin
            out <= in_5;
        end
        sel_6: begin
            out <= in_6;
        end
        sel_7: begin
            out <= in_7;
        end
        default: begin
            out <= 0;
        end
    endcase  
end

endmodule
