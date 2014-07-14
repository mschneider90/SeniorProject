`timescale 1ns / 1ps

module tb_ps2_if();

reg clk;
reg data_in;
wire[7:0] data_out;
wire valid;

parameter[7:0] test_word = 8'b10110010;

PS2Interface ps2_interface(.clk(clk), .data_in(data_in), .data_out(data_out), .valid(valid));

initial begin
    clk = 1;
    data_in = 1;
    #14
    data_in = 0; //start bit
    #10
    data_in = test_word[7]; //d0
    #10
    data_in = test_word[6]; //d1
    #10
    data_in = test_word[5]; //d2
    #10
    data_in = test_word[4]; //d3
    #10
    data_in = test_word[3]; //d4
    #10
    data_in = test_word[2]; //d5
    #10
    data_in = test_word[1]; //d6
    #10
    data_in = test_word[0]; //d7
    #10
    data_in = 1; //parity
    #10
    data_in = 1; //stop bit
end

always@(negedge valid) begin
    if (data_out == test_word)
        $display("PASS");
    else
        $display("FAIL");
end

always begin
    #5 clk = ~clk;
end

endmodule
