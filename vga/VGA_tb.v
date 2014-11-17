`timescale 1ns/100ps

module VGA_tb;

reg tb_clk25MHz;
reg tb_rst;

reg [31:0] tb_bus_in; //
reg ack;

wire tb_hsync;
wire tb_vsync;
wire [7:0] tb_rgb;


VGA_module DUT(.clk25MHz(tb_clk25MHz),
               .reset(tb_rst),
               .vsync(tb_vsync),
               .hsync(tb_hsync),
               .rgb(tb_rgb),
               .bus_ack(ack),
               .bus_in(tb_bus_in));

initial begin
	tb_rst = 1;
	tb_bus_in = 32'hABCD;
	tb_clk25MHz = 0;
	ack <= 0;
    #30
    tb_rst = 0;
	 ack <= 1;
	 #100
	 ack <= 0;
	 #20
	 ack <= 1;
	 #50000 tb_bus_in = ~tb_bus_in;
	 #50000 tb_bus_in = ~tb_bus_in;
end

always begin
	#20 tb_clk25MHz <= ~tb_clk25MHz;
	//#5106 tb_bus_in <= ~tb_bus_in;

end

endmodule
