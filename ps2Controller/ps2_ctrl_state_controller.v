`timescale 1ns / 1ps

module PS2StateController(input clk,
                          input interface_valid,
                          output output_enable);
                          
parameter STATE_IDLE = 0;
parameter STATE_WRITE = 1;

reg[3:0] nextState;
reg[3:0] state;

assign output_enable = 0;
    


endmodule

