`timescale 1ns/100ps

module VGA_tb;

reg tb_clk25MHz;
reg tb_rst;

wire tb_hsync;
wire tb_vsync;
wire [7:0] tb_rgb;

VGA_module DUT(.clk25MHz(tb_clk25MHz),
               .reset(tb_rst),
               .vsync(tb_vsync),
               .hsync(tb_hsync),
               .rgb(tb_rgb),
               .bus_ack(1));

initial begin
	tb_rst = 1;
	tb_clk25MHz = 0;
    #30
    tb_rst = 0;
end

always begin
	#20 tb_clk25MHz = ~tb_clk25MHz;
end

endmodule
