`timescale 1ns/100ps

module VGA_tb;

reg tb_clk50MHz;
reg tb_rst;

wire tb_hsync;
wire tb_vsync;
wire [7:0] tb_rgb;

VGA_module DUT(.clk50MHz(tb_clk50MHz), .rst(tb_rst), .vsync(tb_vsync), .hsync(tb_hsync), .rgb(tb_rgb));

initial begin
	tb_rst = 0;
	tb_clk50MHz = 0;
end

always begin
	#10 tb_clk50MHz = ~tb_clk50MHz;
end

endmodule
