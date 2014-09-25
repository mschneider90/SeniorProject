`timescale 1ns / 1ps

module BusController #(parameter NUM_DEVICES = 8,
                       parameter ADDR_WIDTH = 32)
                      (input [NUM_DEVICES-1:0] req,
                       input clk,                    
                       input      [ADDR_WIDTH-1:0]  virtual_addr,
                       output reg [NUM_DEVICES-1:0] ack,
                       output reg [NUM_DEVICES-1:0] device_en,
                       output reg [ADDR_WIDTH-1:0]  phys_addr);
                       
// Define address ranges here
// RAM - 8M x 16 bits = 16MB
parameter RAM_LOW  = 32'h00000000;
parameter RAM_HIGH = 32'h007FFFFF;
parameter RAM_ID = 0;

// ROM - 8M x 16 bits = 16MB
parameter ROM_LOW  = 32'h00800000;
parameter ROM_HIGH = 32'h00FFFFFF;
parameter ROM_ID = 1;

// TODO define address spaces for:
// VGA  - 16 x 16 bits = 32 bytes
parameter VGA_LOW  = 32'h01000000;
parameter VGA_HIGH = 32'h0100000F;
parameter VGA_ID = 2;

// PS2 - 16 x 16 bits = 32 bytes
parameter PS2_LOW  = 32'h01000010;
parameter PS2_HIGH = 32'h0100001F;
parameter PS2_ID = 3;

// ACP - 16 x 16 bits = 32 bytes
parameter ACP_LOW  = 32'h01000020;
parameter ACP_HIGH = 32'h0100002F;
parameter ACP_ID = 4;

always@(*) begin
    if (virtual_addr >= ROM_LOW && virtual_addr <= ROM_HIGH) begin
        phys_addr <= virtual_addr;
        device_en <= ( (ack != 0) << ROM_ID);
    end
    else if (virtual_addr >= RAM_LOW && virtual_addr <= RAM_HIGH) begin
        phys_addr <= virtual_addr - RAM_LOW;
        device_en <= ( (ack != 0) << RAM_ID);
    end
    else if (virtual_addr >= VGA_LOW && virtual_addr <= VGA_HIGH) begin
        phys_addr <= virtual_addr - VGA_LOW;
        device_en <= ( (ack != 0) << VGA_ID);
    end
    else if (virtual_addr >= PS2_LOW && virtual_addr <= PS2_HIGH) begin
        phys_addr <= virtual_addr - PS2_LOW;
        device_en <= ( (ack != 0) << PS2_ID);
    end
    else if (virtual_addr >= ACP_LOW && virtual_addr <= ACP_HIGH) begin
        phys_addr <= virtual_addr - ACP_LOW;
        device_en <= ( (ack != 0) << ACP_ID);
    end
    else begin
        phys_addr <= 0;
    end
end
                  
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
            ack[current_device] <= 1;
            if (req[current_device] == 1)
                nextState <= STATE_BUSY;
            else begin
                nextState <= STATE_IDLE;
            end
        end
    endcase
end

endmodule
