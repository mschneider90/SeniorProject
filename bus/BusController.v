`timescale 1ns / 1ps

module BusController #(NUM_DEVICES = 8)
                      (input [NUM_DEVICES-1:0] req,
                       input clk,
                       output reg [NUM_DEVICES-1:0] ack);
                  
// States                  
reg [1:0] currentState;
reg [1:0] nextState;
parameter STATE_IDLE = 0;
parameter STATE_BUSY = 1;

//Width of this corresponds to number of devices + 1 for MSB valid bit
wire [3:0] enc_out;
wire enc_valid;
wire [2:0] enc_bcd;
assign enc_valid = enc_out[3];
assign enc_bcd = enc_out[2:0];
PriorityEncoder enc(.enc_in(req), .enc_out(enc_out));

// The device that currently holds the bus, if in STATE_BUSY
// The width of this signal should correspond to the number of devices
reg [2:0] current_device;

initial begin
    currentState <= 0;
    nextState <= 0;
end

always@(negedge clk) begin
    currentState <= nextState;
end
                       
always@(posedge clk) begin
    case (currentState)
        STATE_IDLE: begin
            ack <= 0;
            if (enc_valid) begin
                current_device <= enc_bcd;
                nextState <= STATE_BUSY;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_BUSY: begin
            ack[current_device] = 1;
            if (req[current_device] == 1)
                nextState <= STATE_BUSY;
            else begin
                nextState <= STATE_IDLE;
            end
        end
    endcase
end
                       


endmodule
