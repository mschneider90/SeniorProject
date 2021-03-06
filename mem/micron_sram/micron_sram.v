`timescale 1ns / 1ps

// Models Micron MT45W8 pseudo-SRAM, burst R/W fixed latency mode

module micron_sram #(parameter D_WIDTH = 16,
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

// Note: for simulation purposes this must match the BCR_CONFIG value
// in the SRAM controller module
wire[A_WIDTH-1:0] BCR_CONFIG;
assign BCR_CONFIG = {3'b000, // [22:20] Reserved, must be 0
                     2'b10,  // [19:18] Register select (BCR)
                     2'b00,  // [17:16] Reserved, must be 0
                     1'b0,   // [15:15] Operating mode (Synchronous)
                     1'b1,   // [14:14] Initial latency (Fixed)
                     3'b011, // [13:11] Latency counter (Code 3)
                     1'b1,   // [10:10] WAIT polarity (Active high)
                     1'b0,   // [9:9]   Reserved, must be set to 0
                     1'b1,   // [8:8]   Wait config (Asserted one cycle before delay)
                     2'b00,  // [7:6]   Reserved, must be set to 0
                     2'b01,  // [5:4]   Drive strength (1/2 strength, this is default)
                     1'b1,   // [3:3]   Burst wrap (No wrap)
                     3'b001  // [2:0]   Burst length (4 words)
                     };
                     
//States
parameter STATE_IDLE = 0;
parameter STATE_READ_ADDR = 1;
parameter STATE_READ_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_WRITE_ADDR = 4;
parameter STATE_WRITE_WAIT = 5;
parameter STATE_WRITE_DATA = 6;

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
//reg[D_WIDTH-1:0] data_reg;

reg data_out_en;
wire [D_WIDTH-1:0] data_out;
assign data_out = (currentState == STATE_IDLE)? BCR_CONFIG : mem[currentAddr];
//assign data = (data_out_en && ce_L == ASSERT_L)? data_out : 'bz;
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

always@(posedge clk) begin
    if (ce_L == ASSERT_L) begin
        if (currentState == STATE_WRITE_DATA) begin
            mem[currentAddr] <= data;
        end
    end
end
   
//Next state logic   
always@(*) begin
    case (currentState) 
        STATE_IDLE: begin
            if (ce_L == ASSERT_L && addr != BCR_CONFIG) begin
                if (adv_L == ASSERT_L) begin
                    if (we_L == ASSERT_L) begin
                        nextState <= STATE_WRITE_WAIT;
                    end
                    else if (we_L == DEASSERT_L) begin
                        nextState <= STATE_READ_WAIT;
                    end
                end
            end
        end
        STATE_READ_WAIT: begin
            if (waitCounter == LATENCY - 2) begin //Read first data at the BEGINNING
                nextState <= STATE_READ_DATA;     //of the fifth cycle
            end
        end
        STATE_READ_DATA: begin
            if (ce_L == DEASSERT_L) begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_WRITE_WAIT: begin
            if (waitCounter == LATENCY - 2) begin //Write first data at the BEGINNING
                nextState <= STATE_WRITE_DATA;    //of the fifth cycle
            end
        end
        STATE_WRITE_DATA: begin
            if (ce_L == DEASSERT_L) begin
                nextState <= STATE_IDLE;
            end
        end
    endcase
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
        STATE_READ_WAIT: begin
            if (waitCounter <= LATENCY - 2) begin
                mem_wait_en <= ASSERT;
            end
            else begin
                mem_wait_en <= DEASSERT;
            end
            data_out_en <= DEASSERT;
            
            //counters
            wait_load <= DEASSERT;
            addr_load <= DEASSERT;
            addr_en <= DEASSERT;
        end
        STATE_READ_DATA: begin
            //data_reg <= mem[currentAddr];
            mem_wait_en <= DEASSERT;
            if (oe_L == ASSERT_L) begin
                data_out_en <= ASSERT;
            end
            else begin
                data_out_en <= DEASSERT;
            end
            
            //counters
            wait_load <= DEASSERT;
            addr_load <= DEASSERT;
            addr_en <= ASSERT;
        end
        STATE_WRITE_WAIT: begin
            if (waitCounter <= LATENCY - 2) begin
                mem_wait_en <= ASSERT;
            end
            else begin
                mem_wait_en <= DEASSERT;
            end
            data_out_en <= DEASSERT;
            
            //counters
            wait_load <= DEASSERT;
            addr_load <= DEASSERT;
            addr_en <= DEASSERT;
        end
        STATE_WRITE_DATA: begin
            mem_wait_en <= DEASSERT;
            data_out_en <= DEASSERT;
            
            //counters
            wait_load <= DEASSERT;
            addr_load <= DEASSERT;
            addr_en <= ASSERT;
        end
    endcase
end




endmodule
