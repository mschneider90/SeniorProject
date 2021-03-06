`timescale 1ns / 1ps

module tb_uart();

reg clk50MHz;
reg tx;
wire rx;

parameter UART_BAUD = 9600;
parameter INPUT_CLOCK = 50000000;
parameter CLOCKS_BETWEEN_BITS = INPUT_CLOCK / UART_BAUD;

wire [7:0] data_out;
wire data_out_valid;

reg [7:0] data_in;
reg data_in_valid;

uart uartModule(.clk50MHz(clk50MHz),
                .rx(tx),
                .tx(rx),
                .data_out(data_out),
                .data_out_valid(data_out_valid),
                .data_in(data_in),
                .data_in_valid(data_in_valid));
                
initial begin
    clk50MHz = 0;
    tx = 1;
    data_in = 8'h55;
    data_in_valid = 0;
    #40
    data_in_valid = 1;
    #40
    data_in_valid = 0;
end
                
/*initial begin
    clk50MHz = 0;
    tx = 1;
    #100
    tx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 0; // parity
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // stop 1
    #(CLOCKS_BETWEEN_BITS * 20)
    tx = 1; // stop 2
end */
                
always begin
    #10 clk50MHz <= ~clk50MHz;
end



endmodule
