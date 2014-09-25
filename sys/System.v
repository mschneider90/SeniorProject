`timescale 1ns / 1ps

module System #(parameter A_WIDTH = 32,
                parameter I_WIDTH = 32,
                parameter D_WIDTH = 16)
             (input clk50MHz,
              input reset,
              input [4:0] debug_ra4,
              output [7:0] debug_rd4,
              output mclk, //begin SRAM specific signals
              output [A_WIDTH-1:0] maddr,
              output madv_L,
              output mce_L,
              output moe_L,
              output mwe_L,
              input  mwait,
              output [D_WIDTH-1:0] bus_data,
              output mcre,
              output mub_L,
              output mlb_L //end SRAM specific signals
              );
              

parameter NUM_DEVICES = 8;

//each device gets an ID
//note that these should be synced with the values in BusAddressTranslator.v
//There might be a better way to do this???
parameter RAM_BUS_ID = 0;
parameter ROM_BUS_ID = 1;
parameter VGA_BUS_ID = 2;
parameter PS2_BUS_ID = 3;
parameter ACP_BUS_ID = 4;
parameter CPU_BUS_ID = 7;

wire [I_WIDTH-1:0] pc; //TODO how wide should this be?
wire [I_WIDTH-1:0] instr;

wire bus_wait;
wire [NUM_DEVICES-1:0] bus_ack;
wire [NUM_DEVICES-1:0] bus_req;
wire bus_write;
wire [1:0] bus_burst_length;
wire [A_WIDTH-1:0] bus_addr;
wire [NUM_DEVICES-1:0] device_en;
wire [A_WIDTH-1:0] bus_phys_addr;

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
         .bus_data(bus_data), //16 bits
         .debug_ra4(debug_ra4),
         .debug_rd4(debug_rd4));

imem instr_mem(.addr(pc[7:2]),
               .data_r(instr));

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

BusController bus_ctrl(.req(bus_req),
                       .clk(clk50MHz),
                       .ack(bus_ack),
                       .virtual_addr(bus_addr),
                       .phys_addr(bus_phys_addr),
                       .device_en(device_en)); 

endmodule
