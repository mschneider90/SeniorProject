`timescale 1ns / 1ps

module tb_System();

reg clk50MHz;
reg reset;

//debug
reg [4:0] debug_ra4;
wire [7:0] debug_rd4;

wire mclk;
wire [23:0] maddr;
wire madv_L;
wire mce_L;
wire moe_L;
wire mwe_L;
wire mwait;
wire [15:0] bus_data;
wire mub_L;
wire mlb_L;
wire mcre;

System sys(.clk50MHz(clk50MHz),
           .reset(reset),
           .debug_ra4(debug_ra4),
           .debug_rd4(debug_rd4),
           .mclk(mclk), //begin SRAM controller specific signals
           .maddr(maddr),
           .madv_L(madv_L),
           .mce_L(mce_L),
           .moe_L(moe_L),
           .mwe_L(mwe_L),
           .mcre(mcre),
           .mwait(mwait),
           .bus_data(bus_data),
           .mub_L(mub_L),
           .mlb_L(mlb_L) //end SRAM controller specific signals
           );
              
micron_sram ram(.clk(mclk),
                .addr(maddr), // 24 bits
                .adv_L(madv_L),
                .ce_L(mce_L),
                .oe_L(moe_L),
                .we_L(mwe_L ),
                .mem_wait(mwait),
                .data(bus_data), //16 bits
                .ub_L(mub_L),
                .lb_L(mlb_L),
                .mcre(mcre));
           
initial begin
    reset <= 1;
    clk50MHz <= 0;
    debug_ra4 <= 5;
    #10
    reset = 0;
    //#250
    //$finish;
end

always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule
