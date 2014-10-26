`timescale 1ns / 1ps

module tb_System();

reg clk50MHz;
reg reset;

//debug
reg [4:0] debug_ra4;
wire [7:0] debug_rd4;

wire mclk;
wire [23:0] maddr;
wire madv_L;
wire mce_L;
wire moe_L;
wire mwe_L;
wire mwait;
wire [15:0] bus_data;
wire mub_L;
wire mlb_L;
wire mcre;

reg rx;
wire tx;

System sys(.clk50MHz(clk50MHz),
           .reset(reset),
           .debug_ra4(debug_ra4),
           .debug_rd4(debug_rd4),
           .mclk(mclk), //begin SRAM controller specific signals
           .maddr(maddr),
           .madv_L(madv_L),
           .mce_L(mce_L),
           .moe_L(moe_L),
           .mwe_L(mwe_L),
           .mcre(mcre),
           .mwait(mwait),
           .mem_data(bus_data),
           .mub_L(mub_L),
           .mlb_L(mlb_L), //end SRAM controller specific signals
           .rx(rx),
           .tx(tx)
           );
        /*      
micron_sram ram(.clk(mclk),
                .addr(maddr), // 24 bits
                .adv_L(madv_L),
                .ce_L(mce_L),
                .oe_L(moe_L),
                .we_L(mwe_L ),
                .mem_wait(mwait),
                .data(bus_data), //16 bits
                .ub_L(mub_L),
                .lb_L(mlb_L),
                .mcre(mcre)); */
                
          parameter UART_BAUD = 9600;
parameter INPUT_CLOCK = 50000000;
parameter CLOCKS_BETWEEN_BITS = INPUT_CLOCK / UART_BAUD;      
           
initial begin
    reset <= 1;
    clk50MHz <= 0;
    debug_ra4 <= 5;
    rx <= 1;
    #10
    reset = 0;

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
    #10 clk50MHz = ~clk50MHz;
end

endmodule
