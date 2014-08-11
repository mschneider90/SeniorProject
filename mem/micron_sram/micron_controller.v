`timescale 1ns / 1ps

//Controller for Micron MT45W8 pseudo-SRAM device
//
//External interface:
//Cycle 0: Present device address.
//Cycle 1: Present starting memory/register address & burst length
//Cycle 2: If "bwait" is asserted, wait until "bwait" is deasserted.
//...
//Cycle n: Present/read one data word per cycle
module micron_controller #(parameter A_WIDTH = 16,
                           parameter D_WIDTH = 16)
                          (input clk50MHz,
                           input[A_WIDTH-1:0] baddr,
                           input [1:0] bburst,
                           output reg bwait,
                           output[A_WIDTH-1:0] maddr,
                           output reg moe_L,  //output enable
                           output reg mwe_L,  //write enable
                           output reg madv_L, //address valid
                           output mclk,   //memory clock
                           output mub_L,  //upper byte
                           output mlb_L,  //lower byte
                           output reg mce_L,  //chip enable
                           output reg mcre,   //control register enable
                           input  mwait); //wait
                           
//Address of the SRAM controller
//TODO change this to global scope
parameter CTRL_ADDR_READ = 16'hFFFA;
parameter CTRL_ADDR_WRITE = 16'hFFFB;
            
//Constants            
parameter ASSERT = 1;
parameter DEASSERT = 0;
parameter ASSERT_L = 0;
parameter DEASSERT_L = 1;

//States
parameter STATE_IDLE = 0;
parameter STATE_READ_ADDR = 1;
parameter STATE_READ_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_WRITE_ADDR = 4;
parameter STATE_WRITE_WAIT = 5;
parameter STATE_WRITE_DATA = 6;
parameter STATE_FINISH = 7;

//See: micron_ram.pdf (datasheet), pg. 29
//Default read/write latency is 4 cycles
//This also allows us to operate up to 52MHz - convenient
parameter RW_LATENCY_CYCLES = 4;

//Local reset for counters
reg reset;

//Counter for r/w latency
reg cycle_count_en;
wire cycle_count_geq;
wire[1:0] cycle_counter;
count_reg c_counter(.en(cycle_count_en),
                    .rst(reset),
                    .clk(clk50MHz),
                    .count(cycle_counter),
                    .load(DEASSERT));
//Zero indexed so subtract 1
assign cycle_count_geq = (cycle_counter >= RW_LATENCY_CYCLES - 1) ? ASSERT : DEASSERT;

//Counter for burst length - support length of up to 16
reg burst_count_en;
wire burst_count_geq;
wire[3:0] burst_counter;
count_reg b_counter(.en(burst_count_en),
                    .rst(reset),
                    .clk(clk50MHz),
                    .count(burst_counter),
                    .load(DEASSERT));
//Zero indexed so subtract 1
assign burst_count_geq = (burst_counter >= bburst - 1) ? ASSERT : DEASSERT;

//Generate memory block
reg mclk_en;
assign mclk = (mclk_en == ASSERT)? clk50MHz : DEASSERT;

//Pass addr bus straight through
assign maddr = baddr;
                       
//These aren't used
assign mub_L = DEASSERT_L;
assign mlb_L = DEASSERT_L;

reg[3:0] currentState;
reg[3:0] nextState;

initial begin
    currentState <= STATE_IDLE;
    nextState <= STATE_IDLE;
end

always@(posedge clk50MHz) begin
    currentState <= nextState;
end

//Next state logic
always@(negedge clk50MHz) begin
    case (currentState)
        STATE_IDLE: begin
            if (baddr == CTRL_ADDR_WRITE) begin //detected our write address
                nextState <= STATE_WRITE_ADDR;
            end
            else if (baddr == CTRL_ADDR_READ) begin //detected our read address
                nextState <= STATE_READ_ADDR;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_READ_ADDR: begin
            nextState <= STATE_READ_WAIT;
        end
        STATE_READ_WAIT: begin
            if (cycle_count_geq) begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_READ_DATA: begin
            if (burst_count_geq) begin
                nextState <= STATE_FINISH;
            end
        end
        STATE_WRITE_ADDR: begin
            nextState <= STATE_WRITE_WAIT;
        end
        STATE_WRITE_WAIT: begin
            if (cycle_count_geq) begin
                nextState <= STATE_WRITE_DATA;
             end
        end
        STATE_WRITE_DATA: begin
            if (burst_count_geq) begin
                nextState <= STATE_FINISH;
            end
        end
        STATE_FINISH: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

//Outputs
always@(currentState) begin
    case (currentState) 
        STATE_IDLE: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= DEASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
        end
        STATE_READ_ADDR: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
        end
        STATE_READ_WAIT: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= ASSERT;
            mclk_en <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
        end
        STATE_READ_DATA: begin
            //Outputs
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= ASSERT;
        end
        STATE_WRITE_ADDR: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= ASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
        end
        STATE_WRITE_WAIT: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= ASSERT;
            mclk_en <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
        end
        STATE_WRITE_DATA: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= ASSERT;
        end
        STATE_FINISH: begin
            //Outputs
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait <= DEASSERT;
            mclk_en <= ASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
        end
    endcase
end

endmodule
