/* Programmable GPU
	
*/

`timescale 1ns / 1ps

module GPU #(parameter PIX_WIDTH = 8,
             parameter INSTR_WIDTH = 16;
             parameter MAX_INSTR = 16,
				 parameter MAX_SPR_DIM = 32,
				 parameter IO_WIDTH = 16)
				(inout[IO_WIDTH-1:0] io,
				 output active);
				
/*Control signals from GPU controller
	NOTE THAT THIS MUCH MATCH DEFINITION INSIDE GPUController
*/
parameter WE_MODE = 0;
parameter WE_NUMINSTR = 1;
parameter WE_SPRWIDTH = 2;
parameter WE_SRCMEM = 3;
parameter WE_DESTMEM = 4;
parameter WE_INSTRCACHE = 5;
parameter WE_SPRCACHE = 6;
parameter CACHE_ADDR_LSB = 7;
parameter CACHE_ADDDR_MSB = 14;
wire[15:0] control;

GPUController gpuctrl(.ctrl_in(/* todo: need to be able to read from IO or from regs */),
                      .ctrl_out(control),
							 .clk(clk));
					  
InstructionCache instr_cache(.data_in(io),
                             .addr(),
									  .clk(clk),
									  .we(control[WE_INSTRCACHE]),
									  .data_out());
									  
wire [15:0] spr_cache_out;
SpriteCache spr_cache(.data_in(io),
                      .addr(),
							 .clk(clk),
							 .we(control[WE_SPRCACHE]),
							 .data_out(spr_cache_out));

PixelPipe pp0();
PixelPipe pp1();
PixelPipe pp2();
PixelPipe pp3();
PixelPipe pp4();
PixelPipe pp5();
PixelPipe pp6();
PixelPipe pp7();


InstructionDecoder instrdec();

//Pointer to the instruction memory
Register prog_mem(.write_data(io),
                  .write_enable(control[WE_MODE]),
						.clk(clk),
						.reset(reset),
						.read_data());
//Number of instructions
Register num_instr(.write_data(io),
                   .write_enable(control[WE_NUMINSTR]),
						 .clk(clk),
						 .reset(reset),
						 .read_data());
//Width of sprite in px (square)
Register spr_width(.write_data(io),
                   .write_enable(control[WE_SPRWIDTH]),
						 .clk(clk),
						 .reset(reset),
						 .read_data());
//Pointer to the sprite source
Register src_mem(.write_data(io),
                 .write_enable(control[WE_SRCMEM]),
 					  .clk(clk),
					  .reset(reset),
					  .read_data());
//Pointer to the sprite destination
Register dest_mem(.write_data(io),
                  .write_enable(control[WE_DESTMEM]),
						.clk(clk),
						.reset(reset),
						.read_data());

endmodule
