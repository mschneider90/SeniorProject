`timescale 1ns / 1ps

module TriBuffer  #(parameter DATA_WIDTH = 8)
                   (input[DATA_WIDTH-1:0] buf_in,
                    input output_en,
                    output[DATA_WIDTH-1:0] buf_out);
                    
assign buf_out = (output_en)? buf_in : 'bz;

endmodule
