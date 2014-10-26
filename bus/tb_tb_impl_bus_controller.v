`timescale 1ns / 1ps

module tb_tb_impl_bus_controller();

reg clk50MHz;
reg sw_0;
reg sw_1;
reg m1_en;
reg m2_en;

wire [7:0] debug_out;

tb_impl_bus_controller bus_test(.clk50MHz(clk50MHz),
                       .master1_en(m1_en),
                       .master2_en(m2_en),
                       .sw_1(sw_1),
                       .sw_0(sw_0),
                       .debug_out(debug_out));

initial begin
    clk50MHz <= 0;
    m1_en <= 1;
    m2_en <= 1;
    #400
    m2_en <= 0;
end

always begin
    #10 clk50MHz = ~clk50MHz;
end
                 
endmodule
