`timescale 1ns / 1ps

module tb_impl_bus_controller(input clk50MHz,
                                 input master1_en,
                                 input master2_en,
                                 input sw_1,
                                 input sw_0,
                                 output [7:0] debug_out
                                 );
                              
parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[5:0] = 0;

wire [7:0] ack;
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
tb_impl_test_master master1(.bus_in(bus),
                      .ack(ack[7]),
                      .clk(clk50MHz),
                      .req(req[7]),
                      .ready_in(1),
                      .writeTransfer(1),
                      .en(master1_en),
                      .debug_sel({sw_1, sw_0}),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out));
   
wire [BUS_WIDTH-1:0] master2_out; 
wire [CTRL_WIDTH-1:0] master2_ctrl_out;    
tb_impl_test_master master2(.bus_in(bus),
                      .ack(ack[6]),
                      .clk(clk50MHz),
                      .req(req[6]),
                      .ready_in(1),
                      .writeTransfer(1),
                      .en(master2_en),
                      .debug_sel({sw_1, sw_0}),
                      .bus_out(master2_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master2_ctrl_out));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;     
tb_test_slave slave(.clk(clk50MHz),
                    .bus_in(bus),
                    .ack(ack[0]),
                    .bus_out(slave_out),
                    .ctrl_in(ctrl),
                    .ctrl_out(slave_ctrl_out));

                     
BusController controller(.req(req),
                         .clk(clk50MHz),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_6(master2_out),
                         .bus_in_7(master_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_6(master2_ctrl_out),
                         .ctrl_in_7(master_ctrl_out),
                         .ctrl_out(ctrl));
                                        
                 
endmodule
