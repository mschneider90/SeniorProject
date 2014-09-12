`timescale 1ns / 1ps

module BusAddressTranslator #(ADDR_WIDTH = 32,
                              NUM_DEVICES = 8)
                             (input     [ADDR_WIDTH-1:0] virtual_addr,
                              output reg[NUM_DEVICES-1:0] device_en,
                              output reg[ADDR_WIDTH-1:0] phys_addr);
                              
// Define address ranges here
// ROM - 8M x 16 bits = 16MB
parameter ROM_LOW  = 32'h00000000;
parameter ROM_HIGH = 32'h007FFFFF;
parameter ROM_ID = 0;

// RAM - 8M x 16 bits = 16MB
parameter RAM_LOW  = 32'h00800000;
parameter RAM_HIGH = 32'h00FFFFFF;
parameter RAM_ID = 1;

//TODO define address spaces for:
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
        device_en <= 1 << ROM_ID;
    end
    else if (virtual_addr >= RAM_LOW && virtual_addr <= RAM_HIGH) begin
        phys_addr <= virtual_addr - RAM_LOW;
        device_en <= 1 << RAM_ID;
    end
    else if (virtual_addr >= VGA_LOW && virtual_addr <= VGA_HIGH) begin
        phys_addr <= virtual_addr - VGA_LOW;
        device_en <= 1 << VGA_ID;
    end
    else if (virtual_addr >= PS2_LOW && virtual_addr <= PS2_HIGH) begin
        phys_addr <= virtual_addr - PS2_LOW;
        device_en <= 1 << PS2_ID;
    end
    else if (virtual_addr >= ACP_LOW && virtual_addr <= ACP_HIGH) begin
        phys_addr <= virtual_addr - ACP_LOW;
        device_en <= 1 << ACP_ID;
    end
    else begin
        phys_addr <= 0;
    end
end


endmodule
