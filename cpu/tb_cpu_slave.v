`timescale 1ns / 1ps

module tb_cpu_slave();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

reg clk100MHz;
reg clk25MHz;

reg [BUS_WIDTH-1:0] bus;
reg [CTRL_WIDTH-1:0] ctrl;

wire [7:0] req;
assign req[6:0] = 0;

reg ack;
reg en;
                     
wire [BUS_WIDTH-1:0] cpu_out;  
wire [CTRL_WIDTH-1:0] cpu_ctrl_out;     
        
reg reset;
wire [31:0] pc;
wire [31:0] instr;
mips cpu(.clk(clk25MHz),
         .clk100MHz(clk100MHz),
         .reset_ext(reset),
         .bus_ctrl_in(ctrl),
         .bus_master_ack(ack),
         .bus_slave_en(en),
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(req[7]),
         .bus_data_in(bus),
         .bus_data_out(cpu_out));

initial begin
    clk100MHz <= 1;
    clk25MHz <= 1;
    reset <= 1;
    ack <= 0;
    en <= 0;
    bus <= 0;
    ctrl <= 8'hFE; //write
    #11
    en <= 1;
    #10
    bus <= 32'hac081050;
    #10
    en <= 0;
    #50
    bus <= 1;
    en <= 1;
    #20
    bus <= 32'h10080001;
    #10
    en <= 0;
    #50
    bus <= 2;
    en <= 1;
    #20
    bus <= 32'h20090005;
    #10
    en <= 0;
    #80
    reset <= 0;
    ack <= 1;
   // #10
   // en <= 1;
end
                
always begin
    #2.5 clk100MHz = ~clk100MHz;
end

always begin
    #10 clk25MHz = ~clk25MHz;
end

endmodule
