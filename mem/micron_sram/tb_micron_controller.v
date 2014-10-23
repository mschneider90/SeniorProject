`timescale 1ns / 1ps

module tb_micron_controller_init();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

reg clk50MHz;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;

wire[22:0] BCR_CONFIG;
assign BCR_CONFIG = {3'b000, // [22:20] Reserved, must be 0
                     2'b10,  // [19:18] Register select (BCR)
                     2'b00,  // [17:16] Reserved, must be 0
                     1'b0,   // [15:15] Operating mode (Synchronous)
                     1'b1,   // [14:14] Initial latency (Fixed)
                     3'b011, // [13:11] Latency counter (Code 3)
                     1'b1,   // [10:10] WAIT polarity (Active high)
                     1'b0,   // [9:9]   Reserved, must be set to 0
                     1'b1,   // [8:8]   Wait config (Asserted one cycle before delay)
                     2'b00,  // [7:6]   Reserved, must be set to 0
                     2'b01,  // [5:4]   Drive strength (1/2 strength, this is default)
                     1'b1,   // [3:3]   Burst wrap (No wrap)
                     3'b001  // [2:0]   Burst length (4 words)
                     };

//Signals to memory
wire[22:0] maddr;
wire[15:0] mdata;
assign mdata = (moe_L == 0)? BCR_CONFIG : 'bz;
wire moe_L;
wire mwe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
wire ready;
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;   
reg reset;  
micron_controller sramctrl(.clk50MHz(clk50MHz),
                       .bus_data_in(0),
                       .bus_data_out(slave_out),
                       .bus_ctrl_in(0),
                       .bus_ctrl_out(slave_ctrl_out),
                       .bus_ack(0),
                       .ready(ready),
                       .reset_external(reset),
                       .mem_data(mdata),
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
    clk50MHz <= 0;
    reset <= 1;
    #30
    reset <= 0;
    #500
    reset <= 1;
    #30
    reset <= 0;
end
                
always begin
    #10 clk50MHz = ~clk50MHz;
end

endmodule
