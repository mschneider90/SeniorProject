`timescale 1ns / 1ps

// Models Micron MT45W8 pseudo-SRAM, async R/W

module micron_sram_async #(parameter D_WIDTH = 16,
                     parameter A_WIDTH = 23,
                     parameter NUM_ELEMENTS = 65536)
                     (input[A_WIDTH-1:0] addr,
                     input adv_L,
                     input ce_L,
                     input oe_L,
                     input we_L,
                     output mem_wait,
                     inout[D_WIDTH-1:0] data,
                     input ub_L,
                     input lb_L,
                     input cre);
                     
parameter LATENCY = 4;
                     
//States
parameter STATE_IDLE = 0;
parameter STATE_READ = 1;
parameter STATE_WRITE = 2;

//constants
parameter ASSERT = 1;
parameter DEASSERT = 0;
parameter ASSERT_L = 0;
parameter DEASSERT_L = 1;
                     
reg[3:0] currentState;
reg[3:0] nextState;

reg[D_WIDTH-1:0] mem[NUM_ELEMENTS-1:0];

reg [D_WIDTH-1:0] data_out;
assign data = (oe_L == ASSERT_L)? data_out : 'bz;

reg mem_wait_en;
assign mem_wait = (mem_wait_en)? ASSERT : DEASSERT;

integer i;
initial begin
    for (i = 0; i<NUM_ELEMENTS; i = i + 1) begin
        mem[i] <= 0;
    end
end
   
//Single word read/write  
always@(negedge adv_L) begin
    if (ce_L == ASSERT_L) begin
        if (adv_L == ASSERT_L) begin
            if (we_L == ASSERT_L) begin
                mem[addr] <= #75 data;
            end
            else if (we_L == DEASSERT_L) begin
                data_out <= #75 mem[addr];
            end
        end
    end
end

endmodule
