`timescale 1ns / 1ps

module tb_cpu_bus();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

reg clk50MHz;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;
      
wire [BUS_WIDTH-1:0] slave_out; 
wire [CTRL_WIDTH-1:0] slave_ctrl_out;                   
tb_test_slave   slave(.bus_in(bus),
                      .ack(ack[0]),
                      .clk(clk50MHz),
                      .bus_out(slave_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(slave_ctrl_out));
                     
wire [BUS_WIDTH-1:0] cpu_out;  
wire [CTRL_WIDTH-1:0] cpu_ctrl_out;     
        
reg reset;
wire [31:0] pc;
wire [31:0] instr;
mips cpu(.clk(clk50MHz),
         .reset(reset),
         .bus_ctrl_in(ctrl),
         .bus_ack(slave_ack),
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(req[7]),
         .bus_data_in(bus),
         .bus_data_out(cpu_out));
        
              
BusController controller(.req(req),
                         .clk(clk50MHz),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_7(cpu_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_7(cpu_ctrl_out),
                         .ctrl_out(ctrl));

initial begin
    clk50MHz <= 1;
    reset <= 1;
    #3 reset <= 0;
end
                
always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule

