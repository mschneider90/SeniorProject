`timescale 1ns / 1ps

module InstructionDecoder #(parameter INSTR_WIDTH = 16,
                            parameter CTRL_WIDTH = 16)
									(input[INSTR_WIDTH-1:0] instr,
									 output[CTRL_WIDTH-1:0] ctrl_out);

assign ctrl_out = ctrl;					 
always@(*) begin
	ctrl = 0;
end


endmodule
