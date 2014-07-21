`timescale 1ns / 1ps

module PixelPipe #(parameter CTRL_WIDTH = 8,
                   parameter PIX_WIDTH = 8,
						(input[CTRL_WIDTH-1:0] control, 
                   input[PIX_WIDTH-1:0]  pix_in,
						 input                 clk,
                   output[PIX_WIDTH-1:0] pix_out);
							
wire[PIX_WIDTH-1:0] alu_inA;
							 
RegisterFile rf(.write_data(pix_out),
                .read_addr(control[7:6]),
 					 .write_addr(control[5:4]),
					 .write_enable(control[3]),
					 .clk(clk),
					 .read_data(alu_inA));
					 
ALU alu(.alu_inA(alu_inA)
        .alu_inB(pix_in)
		  .alu_ctrl(conrol[2:1]),
		  .alu_out(pix_out));
		  
endmodule
