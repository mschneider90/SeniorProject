`timescale 1ns / 1ps

// Models Micron MT45W8 pseudo-SRAM, async R/W

module micron_sram_async #(parameter D_WIDTH = 16,
                     parameter A_WIDTH = 23,
                     parameter NUM_ELEMENTS = 65536)
                    (input clk,
                     input[A_WIDTH-1:0] addr,
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

wire[A_WIDTH-1:0] currentAddr;
reg addr_load;
reg addr_en;
count_reg #(.D_WIDTH(A_WIDTH)) addr_counter 
                      (.en(addr_en),
                       .rst(reset),
                       .clk(clk),
                       .count(currentAddr),
                       .load(addr_load),
                       .count_load(addr));

wire[1:0] waitCounter;
reg wait_load;
count_reg #(.D_WIDTH(2)) wait_counter 
                      (.en(ASSERT),
                       .rst(reset),
                       .clk(clk),
                       .count(waitCounter),
                       .load(wait_load),
                       .count_load(0));

reg[D_WIDTH-1:0] mem[NUM_ELEMENTS-1:0];

reg [D_WIDTH-1:0] data_out;
assign data = (oe_L == ASSERT_L)? data_out : 'bz;

reg mem_wait_en;
assign mem_wait = (mem_wait_en)? ASSERT : DEASSERT;

integer i;
initial begin
    currentState <= STATE_IDLE;
    nextState <= STATE_IDLE;
    //data_reg <= 0;
    for (i = 0; i<NUM_ELEMENTS; i = i + 1) begin
        mem[i] <= 0;
    end
end

always@(posedge clk) begin
    currentState <= nextState;
end
   
//Single word read/write  
always@(posedge clk) begin
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

always@(*) begin
    case (currentState) 
        STATE_IDLE: begin
            mem_wait_en <= DEASSERT;
            data_out_en <= DEASSERT;
            
            //counters
            wait_load <= ASSERT;
            addr_load <= ASSERT;
            addr_en <= ASSERT;
        end
    endcase
end




endmodule
