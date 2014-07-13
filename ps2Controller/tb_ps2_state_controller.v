`timescale 1ns / 1ps

module tb_ps2_state_controller();

reg clk;
reg data;
reg parity_valid;
wire shift_en;
wire write_en;
wire reset;
wire frame_valid;

PS2StateController control(.clk(clk),
                           .data(data),
                           .parity_valid(parity_valid),
                           .shift_en(shift_en),
                           .write_en(write_en),
                           .reset(reset),
                           .frame_valid(frame_valid));
                           
initial begin
    clk = 1;
    data = 1;
    parity_valid = 0;
    #10
    data = 0; //start bit
    #10
    data = 1; //d0
    #10
    data = 1; //d1
    #10
    data = 0; //d2
    #10
    data = 1; //d3
    #10
    data = 0; //d4
    #10
    data = 0; //d5
    #10
    data = 0; //d6
    #10
    data = 1; //d7
    #10
    data = 0; //parity. don't care since we're generating our own parity
    #10
    parity_valid = 1;
    data = 1; //stop bit
    #50
    data = 0; //start bit
    #10 
    data = 1;
end

always begin
    #5 clk = ~clk;
end

endmodule
