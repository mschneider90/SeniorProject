`timescale 1ns/100ps 

module VGA_module(rgb, vsync, hsync, clk50MHz, rst);

input clk50MHz;
input rst;

output [7:0] rgb;
output vsync;
output hsync;

wire output_valid;

wire [10:0] row;
wire [10:0] col;

sync_gen sgen(.clk50MHz(clk50MHz), .vsync(vsync), .hsync(hsync), .output_valid(output_valid), .rst(rst), .col(col), .row(row));
color_gen cgen(.row(row), .col(col), .rgb(rgb), .output_valid(output_valid));


endmodule
