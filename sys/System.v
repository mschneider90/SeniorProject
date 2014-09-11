`timescale 1ns / 1ps

module System();

/*
           (input clk, reset,
            output [dwidth-1:0] pc,       //TODO remove pc and instr once we support reading
            input  [dwidth-1:0] instr,    //from ROM over bus interface
            input               bus_wait,
            input               bus_ack,
            output              bus_write,
            output              bus_burst_length,
            output [dwidth-1:0] bus_addr,
            output              bus_req,
            inout  [dwidth-1:0] bus_data); */
mips cpu();

imem instr_mem(.addr(),
               .data_r());
             
     
/*(input clk50MHz,
                           input[A_WIDTH-1:0] baddr,
                           input [1:0] bburst,
                           input bwe,
                           input benable,
                           output bwait,
                           output[A_WIDTH-1:0] maddr,
                           output reg moe_L,  //output enable
                           output reg mwe_L,  //write enable
                           output reg madv_L, //address valid
                           output mclk,   //memory clock
                           output mub_L,  //upper byte
                           output mlb_L,  //lower byte
                           output reg mce_L,  //chip enable
                           output reg mcre,   //control register enable
                           input  mwait); //wait */     
micron_controller mem_ctrl();

/*
input clk,
                     input[A_WIDTH-1:0] addr,
                     input adv_L,
                     input ce_L,
                     input oe_L,
                     input we_L,
                     output mem_wait,
                     inout[D_WIDTH-1:0] data,
                     input ub_L,
                     input lb_L); */
micron_sram ram();

/*
input     [ADDR_WIDTH-1:0] virtual_addr,
                              output reg[ADDR_WIDTH-1:0] phys_addr */
BusAddressTranslator bat();

/*
input [NUM_DEVICES-1:0] req,
                       input clk,
                       output reg [NUM_DEVICES-1:0] ack */
BusController bus_ctrl();

endmodule
