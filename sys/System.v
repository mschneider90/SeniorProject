`timescale 1ns / 1ps

module System #(parameter A_WIDTH = 32,
                parameter I_WIDTH = 32,
                parameter D_WIDTH = 32,
                parameter C_WIDTH = 8,
                parameter COLOR_DEPTH = 8)
             (input clk50MHz_in,
              input reset_cpu,
              input reset_vga,
              output dcm_locked,
              //input [4:0] debug_ra4,
              //output [7:0] debug_rd4,
              output mclk, //begin SRAM specific signals
              output [23:0] maddr,
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
              output rx_led,
              output tx_led,
              input ps2_data_in, // PS2 serial data
              input clk_ps2,      // PS2 clock
              output[COLOR_DEPTH-1:0] rgb, // vga out
              output vsync,
              output hsync
              );

wire clk25MHz;
wire clk50MHz;
wire clk100MHz;
SysClockGen clk_gen(.CLKIN_IN(clk50MHz_in),
                    .CLKFX_OUT(clk25MHz),
                    .CLK0_OUT(clk50MHz),
                    .CLK2X_OUT(clk100MHz),
                    .LOCKED_OUT(dcm_locked));
    
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

wire [NUM_DEVICES-1:0] bus_master_ack;
wire [NUM_DEVICES-1:0] bus_slave_en;
wire [NUM_DEVICES-1:0] bus_req;
assign bus_req[5] = 0;
assign bus_req[4] = 0;
assign bus_req[3] = 0;
assign bus_req[1] = 0;
assign bus_req[0] = 0;
wire [D_WIDTH-1:0] bus_data;
wire [C_WIDTH-1:0] bus_ctrl;

wire[D_WIDTH-1:0] cpu_data_out;
wire[C_WIDTH-1:0] cpu_ctrl_out;

mips cpu(.clk(clk25MHz),
         .clk100MHz(clk100MHz),
         .reset_ext(reset_cpu),
         .bus_master_ack(bus_master_ack[CPU_BUS_ID]),
         .bus_slave_en(bus_slave_en[CPU_BUS_ID]),
         .bus_ctrl_in(bus_ctrl),
         .bus_ctrl_out(cpu_ctrl_out),
         .bus_req(bus_req[CPU_BUS_ID]),
         .bus_data_in(bus_data),
         .bus_data_out(cpu_data_out),
         .debug_ra4(debug_ra4),
         .debug_rd4(debug_rd4));

wire [D_WIDTH-1:0] sram_data_out;
wire [C_WIDTH-1:0] sram_ctrl_out;
micron_controller_async sram_ctrl(.clk25MHz(clk25MHz),
                           .bus_ctrl_in(bus_ctrl),
                           .bus_ctrl_out(sram_ctrl_out),
                           .bus_ack(bus_slave_en[RAM_BUS_ID]),
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
                          
wire[C_WIDTH-1:0] acp_ctrl_out;
acp		AudioCopper(
				.clk50MHz	(clk50MHz),
				.clk25MHz	(clk25MHz),
				.m_bus_in	(bus_data), 	
				.m_ack		(bus_slave_en[ACP_BUS_ID]),
				.m_ctrl_in	(bus_ctrl), 
				.m_ctrl_out (acp_ctrl_out), 
				.audio_out 	(audio_out) 		
);				   
		
wire [D_WIDTH-1:0] uart_bus_out;   
wire [C_WIDTH-1:0] uart_ctrl_out;   
assign rx_led = ~rx;
assign tx_led = ~tx;     
uartInterface uart(.clk50MHz(clk25MHz),
                   .bus_in(bus_data),
                   .ctrl_in(bus_ctrl),
                   .bus_req(bus_req[UART_BUS_ID]),
                   .bus_ack(bus_master_ack[UART_BUS_ID]),
                   .bus_out(uart_bus_out),
                   .ctrl_out(uart_ctrl_out),
                   .rx(rx),
                   .tx(tx));   

wire [D_WIDTH-1:0] ps2_data_out;
wire [C_WIDTH-1:0] ps2_ctrl_out;
PS2Controller ps2_ctrl(.ps2_data_in(ps2_data_in),
                       .clk_ps2(clk_ps2),
                       .clk(clk25MHz),
                       .ack(bus_slave_en[PS2_BUS_ID]),
                       .bus_in(bus_data),
                       .bus_out(ps2_data_out),
                       .ctrl_out(ps2_ctrl_out));
                       
wire [D_WIDTH-1:0] vga_bus_out;
wire [C_WIDTH-1:0] vga_ctrl_out;                    
VGA_module vga_ctrl(.rgb(rgb),
                    .vsync(vsync),
                    .hsync(hsync),
                    .clk25MHz(clk25MHz),
                    .reset(reset_vga),
                    .bus_master_ack(bus_master_ack[VGA_BUS_ID]),
                    .bus_slave_en(bus_slave_en[VGA_BUS_ID]),
                    .bus_in(bus_data),
                    .ctrl_in(bus_ctrl),
                    .bus_req(bus_req[VGA_BUS_ID]),
                    .ctrl_out(vga_ctrl_out),
                    .bus_out(vga_bus_out)
                    );

BusController bus_ctrller(.req(bus_req), 
                       .clk(clk25MHz),
                       .master_ack(bus_master_ack),
                       .slave_en(bus_slave_en),
                       .bus_in_0(sram_data_out),
                       .bus_in_2(vga_bus_out),
                       .bus_in_3(ps2_data_out),
                       .bus_in_6(uart_bus_out),
                       .bus_in_7(cpu_data_out),
                       .ctrl_in_0(sram_ctrl_out),
                       .ctrl_in_2(vga_ctrl_out),
                       .ctrl_in_3(ps2_ctrl_out),
                       .ctrl_in_4(acp_ctrl_out),
                       .ctrl_in_6(uart_ctrl_out),
                       .ctrl_in_7(cpu_ctrl_out),
                       .bus_out(bus_data),
                       .ctrl_out(bus_ctrl)); 
                   
endmodule
