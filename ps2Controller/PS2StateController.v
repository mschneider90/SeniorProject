`timescale 1ns / 1ps

module PS2StateController(input clk,
                          input data,
                          input parity_valid,
                          output shift_en,
                          output write_en,
                          output reset,
                          output frame_valid
                         );

reg[3:0] state;

assign write_en = (state == 11)? 1 : 0;

always@(posedge clk) begin
    state = state + 1;
end

endmodule

