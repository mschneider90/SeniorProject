`timescale 1ns / 1ps

module tb_uart_interface();

parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [7:0] req;
assign req[6:0] = 0;
wire [7:0] ack;
reg clk;
wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

reg rx;
wire tx;
      
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
uartInterface master(.bus_in(bus),
                      .bus_ack(ack[7]),
                      .clk50MHz(clk),
                      .bus_req(req[7]),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out),
                      .rx(rx),
                      .tx(tx));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;                   
tb_test_slave slave (.bus_in(bus),
                     .ack(ack[0]),
                     .clk(clk),
                     .bus_out(slave_out),
                     .ctrl_in(ctrl),
                     .ctrl_out(slave_ctrl_out));
                     
BusController controller(.req(req),
                         .clk(clk),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_7(master_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_7(master_ctrl_out),
                         .ctrl_out(ctrl));
                         
parameter UART_BAUD = 9600;
parameter INPUT_CLOCK = 50000000;
parameter CLOCKS_BETWEEN_BITS = INPUT_CLOCK / UART_BAUD;
                         
initial begin
    clk = 0;
    rx = 1;
    
    // First data: 0x56 (WRITE_COMMAND)
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    //Address 
    // Data Byte 0: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 1: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 2: 0xFF
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 3: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    //Data
    //Byte 0: 0xFF
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 1: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 2: 0xFF
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 3: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Read command (0x55)
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
     //Address 
    // Data Byte 0: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 1: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 2: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1
    
    #(CLOCKS_BETWEEN_BITS * 20) //wait
    
    // Data Byte 3: 0x00
    rx = 0; // start
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 5
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 6
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 7
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // stop 1

end

always begin
    #10 clk = ~clk;
end

endmodule





