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
              output mlb_L, //end SRAM specific signals
		      output [7:0] audio_out, // Audio
              input rx, // UART
              output tx, // UART
              input ps2_data_in, // PS2 serial data
              input clk_ps2      // PS2 clock
              );
              
reg clk25MHz;
initial begin
    clk25MHz = 0;
end
always@(posedge clk50MHz) begin
    clk25MHz <= ~clk25MHz;
end
              
parameter NUM_DEVICES = 8;

//each device gets an ID
//note that these should be synced with the values in BusAddressTranslator.v
//There might be a better way to do this???
parameter RAM_BUS_ID = 0;
parameter ROM_BUS_ID = 1;
parameter VGA_BUS_ID = 2;
parameter PS2_BUS_ID = 3;
parameter ACP_BUS_ID = 4;
parameter UART_BUS_ID = 6;
parameter CPU_BUS_ID = 7;

wire [I_WIDTH-1:0] pc; //TODO how wide should this be?
wire [I_WIDTH-1:0] instr;

wire [NUM_DEVICES-1:0] bus_ack;
wire [NUM_DEVICES-1:0] bus_req;
assign bus_req[5:0] = 0;
wire [D_WIDTH-1:0] bus_data;
wire [C_WIDTH-1:0] bus_ctrl;

wire[15:0] cpu_data_out;
wire[C_WIDTH-1:0] cpu_ctrl_out;

mips cpu(.clk(clk25MHz),
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
micron_controller_async sram_ctrl(.clk50MHz(clk25MHz),
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
// updated 10.19
wire[C_WIDTH-1:0] acp_ctrl_out;
acp		AudioCopper(
				.clk50MHz	(clk25MHz),
				.m_bus_in	(bus_data), 	//[31:0]
				.m_ack		(bus_ack[ACP_BUS_ID]),
				.m_ctrl_in	(bus_ctrl), 	//[7:0]
				.m_ctrl_out (acp_ctrl_out), 	//[7:0]
				.audio_out 	(audio_out) 		//[7:0] see acp.ucf for NET list
);
// 					   
		
wire [D_WIDTH-1:0] uart_bus_out;   
wire [C_WIDTH-1:0] uart_ctrl_out;        
uartInterface uart(.clk50MHz(clk25MHz),
                   .bus_in(bus_data),
                   .ctrl_in(bus_ctrl),
                   .bus_req(bus_req[UART_BUS_ID]),
                   .bus_ack(bus_ack[UART_BUS_ID]),
                   .bus_out(uart_bus_out),
                   .ctrl_out(uart_ctrl_out),
                   .rx(rx),
                   .tx(tx));   

wire [D_WIDTH-1:0] ps2_data_out;
wire [C_WIDTH-1:0] ps2_ctrl_out;
PS2Controller ps2_ctrl(.ps2_data_in(ps2_data_in),
                       .clk_ps2(clk_ps2),
                       .clk(clk25MHz),
                       .ack(bus_ack[PS2_BUS_ID]),
                       .bus_in(bus_data),
                       .bus_out(ps2_data_out),
                       .ctrl_out(ps2_ctrl_out));
                     
BusController bus_ctrller(.req(bus_req), 
                       .clk(clk25MHz),
                       .ack(bus_ack),
                       .bus_in_0(sram_data_out),
                       .bus_in_3(ps2_data_out),
                       .bus_in_6(uart_bus_out),
                       .bus_in_7({16'b0, cpu_data_out}),
                       .ctrl_in_0(sram_ctrl_out),
                       .ctrl_in_3(ps2_ctrl_out),
					   .ctrl_in_4(acp_ctrl_out),
                       .ctrl_in_6(uart_ctrl_out),
                       .ctrl_in_7(cpu_ctrl_out),
                       .bus_out(bus_data),
                       .ctrl_out(bus_ctrl)); 

                   
endmodule
