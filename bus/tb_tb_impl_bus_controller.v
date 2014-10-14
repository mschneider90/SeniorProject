`timescale 1ns / 1ps

module tb_tb_impl_bus_controller();

reg clk50MHz;
reg sw_0;
reg sw_1;
reg sw_6;
reg sw_7;

wire [7:0] debug_out;

tb_impl_bus_controller bus_test(.clk50MHz(clk50MHz),
                       .sw_7(sw_7),
                       .sw_6(sw_6),
                       .sw_1(sw_1),
                       .sw_0(sw_0),
                       .debug_out(debug_out));

initial begin
    clk50MHz <= 0;
    sw_0 <= 0;
    sw_1 <= 0;
    sw_6 <= 0;
    sw_7 <= 0;
    #20
    sw_7 <= 1;
    sw_6 <= 1;
    #300
    sw_6 <= 0;
    #400
    sw_0 <= 1;
    sw_1 <= 0;
    #20
    sw_0 <= 0;
    sw_1 <= 1;
    #20
    sw_0 <= 1;
    sw_1 <= 1;
end

always begin
    #10 clk50MHz = ~clk50MHz;
end
                 
endmodule
