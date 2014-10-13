`timescale 1ns / 1ps

module PriorityGen (input [7:0] pri_in,
                    input clk,
                    input en,
                    input reset,
                    output reg [7:0] pri_out); 
                    
reg [7:0] pri;
                             
always@(posedge clk) begin
    if (en) begin
        if (reset) begin
            pri_out <= 0;
        end
        else begin
            pri_out <= pri;
        end
    end
    else begin
        pri_out <= pri_out;
    end
end

always@(*) begin
    if (pri_in[0] == 1'b1) begin
        pri <= 8'b00000001;
    end
    else if (pri_in[1] == 1'b1) begin
        pri <= 8'b00000010;
    end
    else if (pri_in[2] == 1'b1) begin
        pri <= 8'b00000100;
    end
    else if (pri_in[3] == 1'b1) begin
        pri <= 8'b00001000;
    end
    else if (pri_in[4] == 1'b1) begin
        pri <= 8'b00010000;
    end
    else if (pri_in[5] == 1'b1) begin
        pri <= 8'b00100000;
    end
    else if (pri_in[6] == 1'b1) begin
        pri <= 8'b01000000;
    end
    else if (pri_in[7] == 1'b1) begin
        pri <= 8'b10000000;
    end
    else begin
        pri <= 8'b00000000;
    end
end
   
endmodule
