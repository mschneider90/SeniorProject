`timescale 1ns / 1ps

module tb_regfile();

reg clk;
reg reset;
reg we3;
reg [4:0] ra1;
reg [4:0] ra2;
reg [4:0] wa3;
reg [31:0] wd3;
wire [31:0] rd1;
wire [31:0] rd2;
               
regfile rf(.clk(clk),
           .reset(reset),
           .we3(we3),
           .ra1(ra1),
           .ra2(ra2),
           .wa3(wa3),
           .wd3(wd3),
           .rd1(rd1),
           .rd2(rd2));
           
initial begin
    clk <= 0;
    reset <= 1;
    we3 <= 0;
    ra1 <= 0;
    ra2 <= 0;
    wa3 <= 0;
    wd3 <= 0;
    #50
    reset <= 0;
    #20
    ra1 <= 31;
    #200
    wa3 <= 31;
    #20
    we3 <= 1;
    #20
    we3 <= 0;
end

always begin
    #5 clk = ~clk;
end


endmodule
