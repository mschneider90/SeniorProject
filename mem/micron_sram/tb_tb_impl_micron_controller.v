`timescale 1ns / 1ps

module tb_tb_impl_micron_controller();

reg clk50MHz;
reg button_1;
wire mwe_L;
wire moe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
wire [15:0] maddr;
wire [7:0] data_out;
wire [15:0] mdata;
                                 
tb_impl_micron_controller ctrl(clk50MHz, 
                               button_1,
                               mwe_L,
                               moe_L,
                               madv_L,
                               mclk,
                               mub_L,
                               mlb_L,
                               mce_L,
                               mcre,
                               maddr,
                               data_out,
                               mdata);

initial begin
    clk50MHz = 0;
    button_1 = 0;
    #20
    button_1 = 1;
end

always begin
    #5 clk50MHz = ~clk50MHz;
end


endmodule
