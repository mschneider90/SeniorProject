`timescale 1ns / 1ps

module shift_reg_uart #(parameter WIDTH = 4)
                  (input serial_in,
                   input clk,
                   input en,
                   input rst,
                   output reg [WIDTH-1:0] parallel_out);
                   
always@(posedge clk) begin
    if (rst) begin
        parallel_out <= 16'hFFFF;
    end
    else begin
        if (en) begin
            parallel_out <= parallel_out >> 1;
            parallel_out[WIDTH-1] <= serial_in;
        end
        else begin
            parallel_out <= parallel_out;
        end
    end
end


endmodule
