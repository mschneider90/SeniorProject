`timescale 1ns / 1ps

module tb_ps2_controller();

reg clk;
reg clk_ps2;
reg data_in;
wire[7:0] data_out;

parameter[7:0] w = 8'h1D; 
parameter[7:0] break_code = 8'hF0;

PS2Controller ps2_ctrl(.clk(clk), .clk_ps2(clk_ps2), .ps2_data_in(data_in), .bus_in(data_in), .bus_out(data_out));

initial begin
    clk = 1;
    clk_ps2 = 1;
    data_in = 1;
    #200
    data_in = 0; //start bit
    #200
    data_in = w[0]; //d0
    #200
    data_in = w[1]; //d1
    #200
    data_in = w[2]; //d2
    #200
    data_in = w[3]; //d3
    #200
    data_in = w[4]; //d4
    #200
    data_in = w[5]; //d5
    #200
    data_in = w[6]; //d6
    #200
    data_in = w[7]; //d7
    #200
    data_in = 1; //parity
    #200
    data_in = 1; //stop bit
    #600
    data_in = 0; //start bit
    #200
    data_in = break_code[0]; //d0
    #200
    data_in = break_code[1]; //d1
    #200
    data_in = break_code[2]; //d2
    #200
    data_in = break_code[3]; //d3
    #200
    data_in = break_code[4]; //d4
    #200
    data_in = break_code[5]; //d5
    #200
    data_in = break_code[6]; //d6
    #200
    data_in = break_code[7]; //d7
    #200
    data_in = 1; //parity
    #200
    data_in = 1; //stop bit
    #200
    data_in = 0; //start bit
    #200
    data_in = w[0]; //d0
    #200
    data_in = w[1]; //d1
    #200
    data_in = w[2]; //d2
    #200
    data_in = w[3]; //d3
    #200
    data_in = w[4]; //d4
    #200
    data_in = w[5]; //d5
    #200
    data_in = w[6]; //d6
    #200
    data_in = w[7]; //d7
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
