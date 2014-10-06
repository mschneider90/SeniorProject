`timescale 1ns / 1ps

// Models Micron MT45W8 pseudo-SRAM, burst R/W fixed latency mode

module micron_sram #(parameter D_WIDTH = 16,
                     parameter A_WIDTH = 16)
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
                     input mcre);
                     
parameter LATENCY = 4;
                     
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
count_reg #(.D_WIDTH(16)) addr_counter 
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

reg[D_WIDTH-1:0] mem[63:0];
reg[D_WIDTH-1:0] data_reg;

reg data_out_en;
assign data = (data_out_en && ce_L == ASSERT_L)? data_reg : 'bz;

reg mem_wait_en;
assign mem_wait = (mem_wait_en)? ASSERT : DEASSERT;

integer i;
initial begin
    currentState <= STATE_IDLE;
    nextState <= STATE_IDLE;
    data_reg <= 0;
    for (i = 0; i<64; i = i + 1) begin
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
            if (ce_L == ASSERT_L) begin
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
            mem_wait_en <= ASSERT;
            data_out_en <= DEASSERT;
            
            //counters
            wait_load <= DEASSERT;
            addr_load <= DEASSERT;
            addr_en <= DEASSERT;
        end
        STATE_READ_DATA: begin
            data_reg <= mem[currentAddr];
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
            mem_wait_en <= ASSERT;
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
