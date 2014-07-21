`timescale 1ns / 1ps

module GPUController #(parameter IN_WIDTH = 16,
                       parameter CTRL_WIDTH = 16)
					       (input[IN_WIDTH-1:0] gpu_in,
					        input clk,
					        output[CTRL_WIDTH-1:0] ctrl_out);
						
//constants
parameter GPU_ACTIVATE = 16'h0F0F

//states
parameter STATE_WIDTH = 4;
parameter IDLE              = 0;
parameter PROGRAM_MODE      = 1;
parameter PROGRAM_NUM_INSTR = 2;
parameter PROGRAM_SPR_WIDTH = 3;
parameter PROGRAM_SRC_MEM   = 4;
parameter PROGRAM_DEST_MEM  = 5;
parameter LOAD_INSTR_CACHE  = 6;
parameter LOAD_SPR_CACHE    = 7;
parameter EXECUTE           = 8;
parameter WRITE_SPR         = 9;

//control
parameter CTRL_IDLE = 0;
parameter CTRL_PRG_MODE = 0;
parameter CTRL_PRG_NINSTR = 0;
parameter CTRL_PRG_SPRW = 0;
parameter CTRL_PRG_SMEM = 0;
parameter CTRL_PRG_DMEM = 0;
parameter CTRL_LD_INSTR = 0;
parameter CTRL_LD_SPR = 0;
parameter CTRL_EXEC = 0;
parameter CTRL_WSPR = 0;
	
reg[STATE_WIDTH-1:0] currentState;
reg[STATE_WIDTH-1:0] nextState;
reg[CTRL_WIDTH-1:0] nextOutput;
reg[7:0] programCounter;

assign #1 currentState = nextState;
assign #1 ctrl_out = nextOutput;

//Next state logic
always@(posedge clk) begin
	case (currentState)
		IDLE: ((gpu_in == GPU_ACTIVATE)? nextState <= PROGRAM_MODE : nextState <= currentState)
		PROGRAM_MODE: nextState <= PROGRAM_NUM_INSTR;
		PROGRAM_NUM_INSTR: nextState <= PROGRAM_SPR_WIDTH;
		PROGRAM_SPR_WIDTH: nextState <= PROGRAM_SRC_MEM;
		PROGRAM_SRC_MEM: nextState <= PROGRAM_DEST_MEM;
		PROGRAM_DEST_MEM: nextState <= LOAD_INSTR_CACHE;
		LOAD_INSTR_CACHE: nextState <= LOAD_SPR_CACHE; //todo: multi cycle
		LOAD_SPR_CACHE: nextState <= EXECUTE;          //todo: multi cycle
		EXECUTE: nextState <= WRITE_SPR;               //todo: multi cycle
		WRITE_SPR: nextState <= IDLE;                  //todo: multi cycle
		default: nextState <= IDLE;
	endcase
end

always@(currentState) begin
	case (currentState)
		IDLE: nextOutput <= CTRL_IDLE;
		PROGRAM_MODE: nextOutput <= CTRL_PRG_MODE;
		PROGRAM_NUM_INSTR: nextOutput <= CTRL_PRG_INSTR;
		PROGRAM_SPR_WIDTH: nextOutput <= CTRL_PRG_SPRW;
		PROGRAM_SRC_MEM: nextOutput <= CTRL_PRG_SMEM;
		PROGRAM_DEST_MEM: nextOutput <= CTRL_PRG_DMEM;
		LOAD_INSTR_CACHE: nextOutput <= CTRL_LD_INSTR;
		LOAD_SPR_CACHE: nextOutput <= CTRL_LD_SPR;
		EXECUTE: nextOutput <= CTRL_EXEC;
		WRITE_SPR: nextOutput <= CTRL_WSPR;
		default: nextOutput <= CTRL_IDLE;
   endcase
end

endmodule
