`timescale 1ns / 1ps

module PriorityEncoder  (input  [7:0] enc_in,
                         output [3:0]  enc_out); //Width of output should
                                                 //correspond to width of input + 1
                                                 //MSB is a "valid" bit

wire valid;
assign enc_out = {valid, bcd_out};  
       
always@(*) begin
    if (enc_in[0] == 1'b1) begin
        bcd_out <= 0;
        valid <= 1;
    end
    else if (enc_in[1] == 1'b1) begin
        bcd_out <= 1;
        valid <= 1;
    end
    else if (enc_in[2] == 1'b1) begin
        bcd_out <= 2;
        valid <= 1;
    end
    else if (enc_in[3] == 1'b1) begin
        bcd_out <= 3;
        valid <= 1;
    end
    else if (enc_in[4] == 1'b1) begin
        bcd_out <= 4;
        valid <= 1;
    end
    else if (enc_in[5] == 1'b1) begin
        bcd_out <= 5;
        valid <= 1;
    end
    else if (enc_in[6] == 1'b1) begin
        bcd_out <= 6;
        valid <= 1;
    end
    else if (enc_in[7] == 1'b1) begin
        bcd_out <= 7;
        valid <= 1;
    end
    else begin
        bcd_out <= 0;
        valid <= 0;
    end
end
   
endmodule
