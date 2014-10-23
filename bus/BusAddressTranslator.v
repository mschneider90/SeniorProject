module BusAddressTranslator #(parameter ADDR_WIDTH = 32,
                              parameter NUM_DEVICES = 8)
                             (input [ADDR_WIDTH-1:0] virtual_addr,
                              output reg [ADDR_WIDTH-1:0] phys_addr,
                              output reg [NUM_DEVICES-1:0] device_en);

// Define address ranges here
// ACP - 16 x 16 bits = 32 bytes
parameter ACP_LOW = 32'h00000000;
parameter ACP_HIGH = 32'h0000000F;
parameter ACP_ID = 4;

// PS2 - 16 x 16 bits = 32 bytes
parameter PS2_LOW  = 32'h00000010;
parameter PS2_HIGH = 32'h0000001F;
parameter PS2_ID = 3;

// VGA  - 16 x 16 bits = 32 bytes
parameter VGA_LOW  = 32'h00000020;
parameter VGA_HIGH = 32'h0000002F;
parameter VGA_ID = 2;

// RAM - 8M x 16 bits = 16MB
parameter RAM_LOW  = 32'h00000030;
parameter RAM_HIGH = 32'h0100002F;
parameter RAM_ID = 0;

// ROM - 8M x 16 bits = 16MB
parameter ROM_LOW  = 32'h01000030;
parameter ROM_HIGH = 32'h0200002F;
parameter ROM_ID = 1;

always@(*) begin
    if (virtual_addr >= ROM_LOW && virtual_addr <= ROM_HIGH) begin
        phys_addr <= virtual_addr;
        device_en <= ( 1 << ROM_ID);
    end
    else if (virtual_addr >= RAM_LOW && virtual_addr <= RAM_HIGH) begin
        phys_addr <= virtual_addr - RAM_LOW;
        device_en <= ( 1 << RAM_ID);
    end
    else if (virtual_addr >= VGA_LOW && virtual_addr <= VGA_HIGH) begin
        phys_addr <= virtual_addr - VGA_LOW;
        device_en <= ( 1 << VGA_ID);
    end
    else if (virtual_addr >= PS2_LOW && virtual_addr <= PS2_HIGH) begin
        phys_addr <= virtual_addr - PS2_LOW;
        device_en <= ( 1 << PS2_ID);
    end
    else if (virtual_addr >= ACP_LOW && virtual_addr <= ACP_HIGH) begin
        phys_addr <= virtual_addr - ACP_LOW;
        device_en <= ( 1 << ACP_ID);
    end
    else begin
        phys_addr <= 0;
        device_en <= 0;
    end
end
endmodule
