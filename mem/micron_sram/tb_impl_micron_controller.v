`timescale 1ns / 1ps

module tb_impl_micron_controller(input clk50MHz,
                                 input sw_7,
                                 input sw_6,
                                 input sw_1,
                                 input sw_0,
                                 output mwe_L,
                                 output moe_L,
                                 output madv_L,
                                 output mclk,
                                 output mub_L,
                                 output mlb_L,
                                 output mce_L,
                                 output mcre,
                                 output [23:0] maddr,
                                 output [7:0] debug_out,
                                 inout [15:0] mdata
                                 );
                              
parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;
wire ready;
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
tb_impl_test_master master(.bus_in(bus),
                      .ack(ack[7]),
                      .clk(clk50MHz),
                      .req(req[7]),
                      .ready_in(ready),
                      .writeTransfer(sw_6),
                      .en(sw_7),
                      .debug_sel({sw_1, sw_0}),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out),
                      .debug_out(debug_out));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;     
micron_controller sramctrl(.clk50MHz(clk50MHz),
                       .bus_data_in(bus),
                       .bus_data_out(slave_out),
                       .bus_ctrl_in(ctrl),
                       .bus_ctrl_out(slave_ctrl_out),
                       .bus_ack(ack[0]),
                       .ready(ready),
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
                     
BusController controller(.req(req),
                         .clk(clk50MHz),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_7(master_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_7(master_ctrl_out),
                         .ctrl_out(ctrl));
                                        
                 
endmodule
