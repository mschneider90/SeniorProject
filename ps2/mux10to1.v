`timescale 1ns / 1ps

// This is a weird module
// 10 to 1 mux, 1 bit input 32 bit output
module mux10to1 #(parameter OUT_WIDTH = 32)
               (input in_0,
                input in_1,
                input in_2,
                input in_3,
                input in_4,
                input in_5,
                input in_6,
                input in_7,
                input in_8,
                input in_9,
                input[3:0] sel,
                output [OUT_WIDTH-1:0] mux_out);

parameter SEL_0 = 4'h0;
parameter SEL_1 = 4'h1;
parameter SEL_2 = 4'h2;
parameter SEL_3 = 4'h3;
parameter SEL_4 = 4'h4;
parameter SEL_5 = 4'h5;
parameter SEL_6 = 4'h6;
parameter SEL_7 = 4'h7;
parameter SEL_8 = 4'h8;
parameter SEL_9 = 4'h9;
                
reg out;              
always@(*) begin
    case (sel) 
        SEL_0: begin
            out <= in_0;
        end
        SEL_1: begin
            out <= in_1;
        end
        SEL_2: begin
            out <= in_2;
        end
        SEL_3: begin
            out <= in_3;
        end
        SEL_4: begin
            out <= in_4;
        end
        SEL_5: begin
            out <= in_5;
        end
        SEL_6: begin
            out <= in_6;
        end
        SEL_7: begin
            out <= in_7;
        end
        SEL_8: begin
            out <= in_8;
        end
        SEL_9: begin
            out <= in_9;
        end
        default: begin
            out <= 0;
        end
    endcase
end

assign mux_out = {31'b0, out};

endmodule
