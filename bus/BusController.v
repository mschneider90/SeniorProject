`timescale 1ns / 1ps

module BusController #(NUM_DEVICES = 8)
                      (input [NUM_DEVICES-1:0] req,
                       input clk50MHz,
                       output [NUM_DEVICES-1:0] ack);
                  
// States                  
reg [1:0] currentState;
reg [1:0] nextState;
parameter STATE_IDLE = 0;
parameter STATE_BUSY = 1;

// The width of this signal should correspond to the number of devices
wire [2:0] enc_out;
PriorityEncoder enc(.enc_in(req), .enc_out(enc_out));

// The device that currently holds the bus, if in STATE_BUSY
// The width of this signal should correspond to the number of devices
reg [2:0] current_device;

initial begin
    currentState <= 0;
    nextState <= 0;
end
                       
always@(posedge clk50MHz) begin
    case (currentState)
        STATE_IDLE: begin
            if (enc_out != 0) begin
                current_device <= enc_out;
                nextState <= STATE_BUSY;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_BUSY: begin
            if (enc_out == current_device)
                nextState <= STATE_BUSY;
            else begin
                nextState <= STATE_IDLE;
            end
        end
    endcase
end
                       


endmodule
