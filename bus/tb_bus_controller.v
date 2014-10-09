`timescale 1ns / 1ps

module tb_bus_controller();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [7:0] req;
assign req[6:0] = 0;
wire [7:0] ack;
reg clk;
wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;
      
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
tb_test_master master(.bus_in(bus),
                      .ack(ack[7]),
                      .clk(clk),
                      .req(req[7]),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;                   
tb_test_slave slave (.bus_in(bus),
                     .ack(ack[0]),
                     .clk(clk),
                     .bus_out(slave_out),
                     .ctrl_in(ctrl),
                     .ctrl_out(slave_ctrl_out));
                     
BusController controller(.req(req),
                         .clk(clk),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_7(master_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_7(master_ctrl_out),
                         .ctrl_out(ctrl));
                         
initial begin
    clk = 1;
end

always begin
    #5 clk = ~clk;
end

endmodule




