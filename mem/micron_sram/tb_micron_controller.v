`timescale 1ns / 1ps

module tb_micron_controller();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

reg clk50MHz;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;

//Signals to memory
wire[19:0] maddr;
wire[15:0] mdata;
wire moe_L;
wire mwe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
      
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
tb_test_master #(.WRITE_TRANSFER(1)) master(.bus_in(bus),
                      .ack(ack[7]),
                      .clk(clk50MHz),
                      .req(req[7]),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;     
micron_controller sramctrl(.clk50MHz(clk50MHz),
                       .bus_data_in(bus),
                       .bus_data_out(slave_out),
                       .bus_ctrl_in(ctrl),
                       .bus_ctrl_out(slave_ctrl_out),
                       .bus_ack(ack[0]),
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
                                         
micron_sram ram (.clk(mclk),
                 .addr(maddr),
                 .adv_L(madv_L),
                 .ce_L(mce_L),
                 .oe_L(moe_L),
                 .we_L(mwe_L),
                 .mem_wait(mem_wait),
                 .data(mdata),
                 .ub_L(mub_L),
                 .lb_L(mlb_L));  

initial begin
    clk50MHz = 1;
end
                
always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule
