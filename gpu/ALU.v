`timescale 1ns / 1ps

module ALU #(parameter IN_WIDTH = 16
             parameter OUT_WIDTH = 16
				 parameter CTRL_WIDTH = 2)
				(input[IN_WIDTH-1:0]   alu_inA,
				 input[IN_WIDTH-1:0]   alu_inB,
				 input[CTRL_WIDTH-1:0] alu_ctrl,
				 output[OUTPUT_WIDTH-1:0] alu_out);
				 
//constants
parameter CTRL_ADD = 0;
parameter CTRL_SUB = 1;
parameter CTRL_SL = 2;
parameter CTRL_SR = 3;

reg[OUT_WIDTH-1:0] result;

assign alu_out = result;
				 
always@(*) begin
	case (ctrl)
		CTRL_ADD: result = alu_inA + alu_inB;
		CTRL_SUB: result = alu_inA - alu_inB;
		CTRL_SL:  result = alu_inA << alu_inB;
		CTRL_SR:  result = alu_inB >> alu_inB;
	endcase
end
	


endmodule
