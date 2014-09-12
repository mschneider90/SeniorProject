`timescale 1ns / 1ps

module tb_System();

reg clk50MHz;
reg reset;

System sys(.clk50MHz(clk50MHz),
           .reset(reset));

initial begin
    reset = 1;
    clk50MHz = 0;
    #10
    reset = 0;
end

always begin
    #5 clk50MHz = ~clk50MHz;
end




endmodule
