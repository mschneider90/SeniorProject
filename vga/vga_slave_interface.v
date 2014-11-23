`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
// Engineer: Michael Schneider. Modified for use with moosebox ACP by paul mayzeles
// Module Name:   vga_slave_interface: slave interface for the vga controller 
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// Create Date:    17:54:01 11/16/2014 
// This code may be used freely as long as the original authors are credited. 
// Please like us on facebook. Just kidding!

module vga_slave_interface #(parameter BUS_WIDTH = 32,
                     parameter CTRL_WIDTH = 8)
                    (input [BUS_WIDTH-1:0] bus_in,
                     input ack,
                     input clk,
                     input [CTRL_WIDTH-1:0] ctrl_in,
                     output reg data_we);
                     
reg [3:0] currentState;
reg [3:0] nextState;

parameter STATE_WAIT_FOR_ACK = 0;
parameter STATE_WRITE_WAIT = 1;
parameter STATE_READ_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_WRITE_DATA = 4;
parameter STATE_FINISH = 5;

wire we = ctrl_in[1];

initial begin
    currentState <= STATE_WAIT_FOR_ACK;
    nextState <= STATE_WAIT_FOR_ACK;
end

always@(posedge clk) begin
    currentState <= nextState;
end

// Outputs
always@(*) begin
    case (currentState)
        STATE_WAIT_FOR_ACK: begin
            data_we <= 0;
        end
        STATE_READ_WAIT: begin
            data_we <= 0;
        end
        STATE_WRITE_WAIT: begin
            data_we <= 0;
        end
        STATE_READ_DATA: begin
            data_we <= 0;
        end
        STATE_WRITE_DATA: begin
            data_we <= 1;
        end
        STATE_FINISH: begin
            data_we <= 0;
        end
        default: begin
            data_we <= 0;
        end
    endcase
end

// next state logic
always@(*) begin
    case (currentState)
        STATE_WAIT_FOR_ACK: begin
            if (ack) begin
                nextState <= STATE_WRITE_WAIT;
            end
            else begin
                nextState <= STATE_WAIT_FOR_ACK;
            end
        end
        STATE_READ_WAIT: begin
            nextState <= STATE_READ_DATA;
        end
        STATE_WRITE_WAIT: begin
            nextState <= STATE_WRITE_DATA;
        end
        STATE_READ_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_WRITE_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_FINISH: begin
            if (ack) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_WAIT_FOR_ACK;
            end
        end
    endcase
end

endmodule
