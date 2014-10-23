`timescale 1ns / 1ps

module test_tb_async_micron_controller();

reg clk50MHz;
reg rx;
wire tx;
wire mwe_L;
wire moe_L;
wire madv_L;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;
wire [23:0] maddr;
assign maddr[23] = 1'b0;
wire [7:0] debug_out;
wire [15:0] mdata;
                                 
tb_async_micron_controller ctrl(.clk50MHz(clk50MHz), 
                               .mwe_L(mwe_L),
                               .moe_L(moe_L),
                               .madv_L(madv_L),
                               .mub_L(mub_L),
                               .mlb_L(mlb_L),
                               .mce_L(mce_L),
                               .mcre(mcre),
                               .maddr(maddr),
                               .mem_data(mdata),
                               .rx(rx),
                               .tx(tx),
                               .debug_out(debug_out));

parameter UART_BAUD = 9600;
parameter INPUT_CLOCK = 50000000;
parameter CLOCKS_BETWEEN_BITS = INPUT_CLOCK / UART_BAUD;
                         
initial begin
    clk50MHz = 0;
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
    rx = 0; // 0
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 1
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 2
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 0; // 3
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 5
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
    rx = 1; // 4
    #(CLOCKS_BETWEEN_BITS * 20)
    rx = 1; // 5
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

/*micron_sram_async #(.NUM_ELEMENTS(8)) ram 
                (.addr(maddr),
                 .adv_L(madv_L),
                 .ce_L(mce_L),
                 .oe_L(moe_L),
                 .we_L(mwe_L),
                 .mem_wait(mem_wait),
                 .data(mdata),
                 .ub_L(mub_L),
                 .lb_L(mlb_L)); */
                 
endmodule
