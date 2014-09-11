`timescale 1ns / 1ps

module tb_busAddressTranslator();

reg[31:0] virtual_addr;
wire[31:0] phys_addr;

BusAddressTranslator bat(.virtual_addr(virtual_addr), .phys_addr(phys_addr));

always begin
    virtual_addr <= 32'h00000020;
    #5
    virtual_addr <= 32'h008000A0;
    #5
    virtual_addr <= 32'h01000009;
    #5
    virtual_addr <= 32'h0100001C;
    #5
    virtual_addr <= 32'h00000027;
end

endmodule
