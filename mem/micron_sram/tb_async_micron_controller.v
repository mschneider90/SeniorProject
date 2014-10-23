`timescale 1ns / 1ps

module tb_async_micron_controller(input clk50MHz,
                                 output mwe_L,
                                 output moe_L,
                                 output madv_L,
                                 output mclk,
                                 output mub_L,
                                 output mlb_L,
                                 output mce_L,
                                 output mcre,
                                 input mwait,
                                 output [22:0] maddr,
                                 output [7:0] debug_out,
                                 inout [15:0] mem_data,
                                 input rx,
                                 output tx);

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;    

wire [BUS_WIDTH-1:0] bus_data_out;  
wire [CTRL_WIDTH-1:0] bus_ctrl_out;  

wire [BUS_WIDTH-1:0] slave_out;
wire [CTRL_WIDTH-1:0] slave_ctrl_out;     

micron_controller_async sramctrl(.clk50MHz(clk50MHz),
                       .bus_data_in(bus),
                       .bus_data_out(slave_out),
                       .bus_ctrl_in(ctrl),
                       .bus_ctrl_out(slave_ctrl_out),
                       .bus_ack(ack[0]),
                       .mem_data(mem_data),
                       .maddr(maddr),
                       .moe_L(moe_L),
                       .mwe_L(mwe_L),
                       .madv_L(madv_L),
                       .mclk(mclk),
                       .mub_L(mub_L),
                       .mlb_L(mlb_L),
                       .mce_L(mce_L),
                       .mcre(mcre),
                       .mwait(mwait),
                       .debug_out(debug_out)
                      ); 
                                       
uartInterface master(.bus_in(bus),
                      .bus_ack(ack[7]),
                      .clk50MHz(clk50MHz),
                      .bus_req(req[7]),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out),
                      .rx(rx),
                      .tx(tx));
                      
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
