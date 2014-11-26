`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:28 11/23/2014 

//pixel buffer
//16 wide by 8 deep pixel buffer. Holds 

module pixelbuff #(parameter WIDTH = 16, DEPTH = 3)
             (input  [WIDTH-1:0] data_in,
              input  clk,
              input  we,
              input  [DEPTH - 1:0] write_address, //[2:0] means only 8 addresses for now
              input  [DEPTH - 1:0] read_address,
              output [WIDTH-1:0] data_out);

    reg [DEPTH - 1:0] buffer [WIDTH - 1:0];

    always@(posedge clk)
    begin
        if (we)
        begin
            buffer[write_address] <= data_in;
        end
    end
    
    assign data_out = buffer[read_address];

endmodule



