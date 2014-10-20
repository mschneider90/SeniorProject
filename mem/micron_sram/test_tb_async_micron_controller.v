`timescale 1ns / 1ps

module test_tb_async_micron_controller();

reg clk50MHz;
reg sw_0;
reg sw_1;
reg sw_6;
reg sw_7;
wire mwe_L;
wire moe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
wire [23:0] maddr;
assign maddr[23] = 1'b0;
wire [7:0] debug_out;
wire [15:0] mdata;
                                 
tb_async_micron_controller ctrl(.clk50MHz(clk50MHz), 
                               .sw_0(sw_0), //LSb addr
                               .sw_1(sw_1), //MSb addr
                               .sw_6(sw_6), //we
                               .sw_7(sw_7), //en
                               .mwe_L(mwe_L),
                               .moe_L(moe_L),
                               .madv_L(madv_L),
                               .mclk(mclk),
                               .ready(ready),
                               .mub_L(mub_L),
                               .mlb_L(mlb_L),
                               .mce_L(mce_L),
                               .mcre(mcre),
                               .maddr(maddr),
                               .debug_out(debug_out),
                               .mem_data(mdata));

initial begin
    clk50MHz <= 0;
    sw_0 <= 0;
    sw_1 <= 0;
    sw_6 <= 0;
    sw_7 <= 1;
    #20
    sw_7 <= 0;
    sw_6 <= 1;
    #300
    sw_6 <= 0;
    #400
    sw_0 <= 1;
    sw_1 <= 0;
    #20
    sw_0 <= 0;
    sw_1 <= 1;
    #20
    sw_0 <= 1;
    sw_1 <= 1;
end

always begin
    #10 clk50MHz = ~clk50MHz;
end

micron_sram #(.NUM_ELEMENTS(8)) ram (.clk(mclk),
                 .addr(maddr),
                 .adv_L(madv_L),
                 .ce_L(mce_L),
                 .oe_L(moe_L),
                 .we_L(mwe_L),
                 .mem_wait(mem_wait),
                 .data(mdata),
                 .ub_L(mub_L),
                 .lb_L(mlb_L));
                 
endmodule
