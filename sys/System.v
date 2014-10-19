`timescale 1ns / 1ps

module System #(parameter A_WIDTH = 32,
                parameter I_WIDTH = 32,
                parameter D_WIDTH = 32,
                parameter C_WIDTH = 8)
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
              inout [D_WIDTH-1:0] mem_data,
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

wire [NUM_DEVICES-1:0] bus_ack;
wire [NUM_DEVICES-1:0] bus_req;
assign bus_req[6:0] = 0;
wire [D_WIDTH-1:0] bus_data;
wire [C_WIDTH-1:0] bus_ctrl;

wire[15:0] cpu_data_out;
wire[C_WIDTH-1:0] cpu_ctrl_out;
mips cpu(.clk(clk50MHz),
         .reset(reset),
         .pc(pc), 
         .instr(instr),
         .bus_ack(bus_ack[CPU_BUS_ID]),
         .bus_ctrl_in(bus_ctrl),
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(bus_req[CPU_BUS_ID]),
         .bus_data_in(bus_data), //16 bits
         .bus_data_out(cpu_data_out),
         .debug_ra4(debug_ra4),
         .debug_rd4(debug_rd4));

imem instr_mem(.addr(pc[7:2]),
               .data_r(instr));

wire [D_WIDTH-1:0] sram_data_out;
wire [C_WIDTH-1:0] sram_ctrl_out;
micron_controller sram_ctrl(.clk50MHz(clk50MHz),
                           .bus_ctrl_in(bus_ctrl),
                           .bus_ctrl_out(sram_ctrl_out),
                           .bus_ack(bus_ack[RAM_BUS_ID]),
                           .bus_data_in(bus_data),
                           .bus_data_out(sram_data_out),
                           .mem_data(mem_data),
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

BusController bus_ctrller(.req(bus_req), 
                       .clk(clk50MHz),
                       .ack(bus_ack),
                       .bus_in_0(sram_data_out),
                       .ctrl_in_0(sram_ctrl_out),
                       .bus_in_7({16'b0, cpu_data_out}),
                       .ctrl_in_7(cpu_ctrl_out),
                       .bus_out(bus_data),
                       .ctrl_out(bus_ctrl)); 

					   
/* updated 10.19
AudioCopper acp(
				.clk50MHz	(),
				.m_bus_in	(), 	//[31:0]
				.m_ack		(),
				.m_ctrl_in	(), 	//[7:0]
				.m_ctrl_out (), 	//[7:0]
				.audio_out 	() 		//[7:0] see acp.ucf for NET list
);
*/ 					   
					   
					   
endmodule
