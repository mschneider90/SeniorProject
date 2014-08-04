`timescale 1ns / 1ps

module tb_micron_controller();

reg clk50MHz;
reg[15:0] baddr;
reg bwait;
wire[15:0] maddr;
wire moe_L;
wire mwe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;

wire[15:0] bdata;
wire[15:0] mdata;
                          
micron_controller ctrl(.clk50MHz(clk50MHz),
                       .baddr(baddr),
                       .bburst(2'b11),
                       .bwait(bwait),
                       .maddr(maddr),
                       .moe_L(moe_L),
                       .mwe_L(mwe_L),
                       .madv_L(madv_L),
                       .mclk(mclk),
                       .mub_L(mub_L),
                       .mlb_L(mlb_L),
                       .mce_L(mce_L),
                       .mcre(mcre),
                       .mwait(0)
                      );
                      
initial begin
    clk50MHz = 0;
    baddr = 0;
    bwait = 0;
    #8
    baddr = 16'hFFFA;
    #10
    baddr = 16'h0000;
end

always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule
