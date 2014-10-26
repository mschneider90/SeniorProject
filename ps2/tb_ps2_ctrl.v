`timescale 1ns / 1ps

module tb_ps2_controller();

reg clk;
reg clk_ps2;
reg data_in;
wire[7:0] data_out;

parameter[7:0] test_word = 8'h1D;

PS2Controller ps2_ctrl(.clk(clk), .clk_ps2(clk_ps2), .bus_in(data_in), .bus_out(data_out));

initial begin
    clk = 1;
    clk_ps2 = 1;
    data_in = 1;
    #50
    data_in = 0; //start bit
    #200
    data_in = test_word[0]; //d0
    #200
    data_in = test_word[1]; //d1
    #200
    data_in = test_word[2]; //d2
    #200
    data_in = test_word[3]; //d3
    #200
    data_in = test_word[4]; //d4
    #200
    data_in = test_word[5]; //d5
    #200
    data_in = test_word[6]; //d6
    #200
    data_in = test_word[7]; //d7
    #200
    data_in = 1; //parity
    #200
    data_in = 1; //stop bit
end

always begin
    #100 clk_ps2 = ~clk_ps2;
end

always begin
    #5 clk = ~clk;
end

endmodule
