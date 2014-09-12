`timescale 1ns / 1ps

module System(input clk50MHz,
              input reset);

parameter D_WIDTH = 32;
parameter A_WIDTH = 32;

parameter NUM_DEVICES = 1; // num masters

//each device gets an ID
//note that these should be synced with the values in BusAddressTranslator.v
//There might be a better way to do this???
parameter ROM_BUS_ID = 0;
parameter RAM_BUS_ID = 1;
parameter VGA_BUS_ID = 2;
parameter PS2_BUS_ID = 3;
parameter ACP_BUS_ID = 4;
parameter CPU_BUS_ID = 7;

wire [D_WIDTH-1:0] pc;
wire [D_WIDTH-1:0] instr;

wire bus_wait;
wire [NUM_DEVICES-1:0] bus_ack;
wire [NUM_DEVICES-1:0] bus_req;
wire bus_write;
wire [1:0] bus_burst_length;
wire [A_WIDTH-1:0] bus_addr;
wire [D_WIDTH-1:0] bus_data;
wire [NUM_DEVICES-1:0] device_en;

mips cpu(.clk(clk50MHz),
         .reset(reset),
         .pc(pc), 
         .instr(instr),
         .bus_wait(bus_wait),
         .bus_ack(bus_ack[CPU_BUS_ID]),
         .bus_write(bus_write),
         .bus_burst_length(bus_burst_length), //2 bits
         .bus_addr(bus_addr), //32 bits
         .bus_req(bus_req[CPU_BUS_ID]),
         .bus_data(bus_data)); //16 bits

imem instr_mem(.addr(pc),
               .data_r(instr));

//TODO signals to memory should go outside of System for implementation
wire [23:0] maddr;
wire moe_L;
wire mwe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
wire mwait;

micron_controller mem_ctrl(.clk50MHz(clk50MHz),
                           .baddr(bus_phys_addr), //32 bits
                           .bburst(bus_burst_length), //2 bits
                           .bwe(bus_write),
                           .benable(device_en[RAM_BUS_ID]),
                           .bwait(bus_wait),
                           .maddr(maddr), //24 bits
                           .moe_L(moe_L),
                           .mwe_L(mwe_L),
                           .madv_L(madv_L),
                           .mclk(mclk),
                           .mub_L(mub_L),
                           .mlb_L(mlb_L),
                           .mce_L(mce_L),
                           .mcre(mcre),
                           .mwait(mwait));

micron_sram ram(.addr(maddr), // 24 bits
                .adv_L(madv_L),
                .ce_L(mce_L),
                .oe_L(moe_L),
                .we_L(mwe_L),
                .mem_wait(mwait),
                .data(bus_data), //16 bits
                .ub_L(mub_L),
                .lb_L(mlb_L));

BusAddressTranslator bat(.virtual_addr(bus_addr), //32 bits
                         .phys_addr(bus_phys_addr)); //32 bits

BusController bus_ctrl(.req(bus_req),
                       .clk(clk50MHz),
                       .device_en(device_en),
                       .ack(bus_ack)); 

endmodule
