`timescale 1ns / 1ps

module tb_impl_micron_controller(input clk50MHz,
                                 input button_1,
                                 output mwe_L,
                                 output moe_L,
                                 output madv_L,
                                 output mclk,
                                 output mub_L,
                                 output mlb_L,
                                 output mce_L,
                                 output mcre,
                                 output [15:0] maddr,
                                 output [7:0] data_out,
                                 inout [15:0] mdata
                                 );
                              
wire[15:0] baddr;
wire bwait;

micron_controller ctrl(.clk50MHz(clk50MHz),
                       .baddr(baddr),
                       .bburst(2'b10),
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

wire [15:0] bdata;
wire[4:0] counter;

assign mdata = (counter > 8)? 'bz : bdata;

count_reg cntr(1, ~button_1, clk50MHz, counter);

assign bdata = 16'h2222;
assign baddr = (counter > 8)? 16'h0001 : 16'h0000;
assign data_out = (counter == 16)? mdata : 8'h00;
    
endmodule
