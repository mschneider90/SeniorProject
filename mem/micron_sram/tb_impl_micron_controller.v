`timescale 1ns / 1ps

module tb_impl_micron_controller(input clk50MHz,
                                 input button_1,
                                 input button_2);
                                 
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
                       .bdata(bdata),
                       .bburst(2'b01),
                       .bwait(bwait),
                       .maddr(maddr),
                       .mdata(mdata),
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
                      
reg reading;
reg writing;
                      
always@(posedge clk50MHz) begin

end
                      

endmodule
