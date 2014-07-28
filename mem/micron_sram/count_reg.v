`timescale 1ns / 1ps

module count_reg #(parameter D_WIDTH = 8)
                  (input en,
                   input rst,
                   input clk,
                   output reg[D_WIDTH-1:0] count);
                   
always@(posedge clk) begin
    if (rst) begin
        count <= 0;
    end
    else begin
        if (en) begin
            count <= count + 1;
         end
    end
end


endmodule
