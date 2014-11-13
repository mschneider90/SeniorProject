`timescale 1ns / 1ps

//Controller for Micron MT45W8 pseudo-SRAM device (ASYNC MODE)

module micron_controller_async #(parameter A_WIDTH = 23,
                           parameter D_WIDTH = 16,
                           parameter BUS_WIDTH = 32,
                           parameter BUS_CTRL = 8)
                          (input clk25MHz,
                           input  [BUS_CTRL-1:0] bus_ctrl_in,
                           output [BUS_CTRL-1:0] bus_ctrl_out,
                           input  [BUS_WIDTH-1:0] bus_data_in,
                           output [BUS_WIDTH-1:0] bus_data_out,
                           input bus_ack,
                           inout  [D_WIDTH-1:0] mem_data,
                           output [A_WIDTH-1:0] maddr,
                           output reg moe_L,  //output enable
                           output reg mwe_L,  //write enable
                           output reg madv_L, //address valid
                           output mclk,   //memory clock
                           output reg mub_L,  //upper byte
                           output reg mlb_L,  //lower byte
                           output reg mce_L,  //chip enable
                           output reg mcre,   //control register enable
                           input  mwait, //wait
                           output[7:0] debug_out); 
                          
            
//Constants            
parameter ASSERT = 1;
parameter DEASSERT = 0;
parameter ASSERT_L = 0;
parameter DEASSERT_L = 1;

//States
parameter STATE_RESET = 0;
parameter STATE_IDLE = 1;
parameter STATE_READ_SINGLE_WAIT = 2;
parameter STATE_READ_SINGLE_DATA = 3;
parameter STATE_READ_PAGE_WAIT = 4;
parameter STATE_READ_PAGE_DATA = 5;
parameter STATE_WRITE_WAIT = 6;
parameter STATE_WRITE_DATA = 7;
parameter STATE_FINISH = 8;

reg[3:0] currentState;
reg[3:0] nextState;

//Unidirectional bus to tristate bus conversion
assign mem_data = (moe_L == ASSERT_L)? 'bz : bus_data_in;
assign bus_data_out = mem_data;

//Make the control signals more readable
wire bus_we;
assign bus_we = bus_ctrl_in[1];

wire bus_wait_out;
assign bus_ctrl_out = {3'b000, //not used
                       3'b000, //not used (burst length)
                       1'b0,   //not used (we)
                       bus_wait_out };

//Local reset for counters
reg reset;

//RW latency for single word oepration is 70ns => 2 x 40ns cycles
parameter RW_LATENCY_CYCLES = 2;

//Counter for r/w latency
reg cycle_count_en;
wire cycle_count_geq;
wire[1:0] cycle_counter;
count_reg c_counter(.count_load(0),
                    .en(cycle_count_en),
                    .rst(reset),
                    .clk(clk25MHz),
                    .count(cycle_counter),
                    .load(DEASSERT));
//Zero indexed so subtract 1
assign cycle_count_geq = (cycle_counter >= RW_LATENCY_CYCLES - 1) ? ASSERT : DEASSERT;

// Stores the burst length
wire [2:0] bus_burst;
d_reg #(.WIDTH(3)) burstReg
       (.clk(clk25MHz),
        .reset(0),
        .en(bus_ack == ASSERT && currentState == STATE_IDLE),
        .d(bus_ctrl_in[4:2]),
        .q(bus_burst));

//Counter for burst length - support length of up to 16 (page mode read)
reg burst_count_en;
wire burst_count_geq;
wire[2:0] burst_counter;
count_reg b_counter(.count_load(0),
                    .en(burst_count_en),
                    .rst(reset),
                    .clk(clk25MHz),
                    .count(burst_counter),
                    .load(DEASSERT));
reg[2:0] burst_length;
always@(*) begin
    case (bus_burst) 
        3'b000: burst_length = 1;
        3'b001: burst_length = 2;
        3'b010: burst_length = 4;
        3'b011: burst_length = 8;
        3'b100: burst_length = 16;
        default: burst_length = 1;
    endcase
end
assign burst_count_geq = (burst_counter >= burst_length - 1) ? ASSERT : DEASSERT;
        
// Stores the starting memory address
wire [A_WIDTH-1:0] addr_reg_out;
reg addr_write_en;
reg addr_reset;
d_reg #(.WIDTH(A_WIDTH)) maddrReg
       (.clk(clk25MHz),
        .reset(addr_reset),
        .en(addr_write_en),
        .d(bus_data_in),
        .q(addr_reg_out));
        
assign maddr = addr_reg_out;

//DEBUG
assign debug_out = addr_reg_out[7:0];

//Wait output
reg bwait_en;
assign bus_wait_out = (bwait_en == ASSERT)? ASSERT : DEASSERT;
                       
//These aren't used
assign mclk = DEASSERT;
                                                      
initial begin
    nextState <= STATE_RESET;
    currentState <= STATE_RESET;
end

always@(posedge clk25MHz) begin
    currentState <= nextState;
end

//Next state logic
always@(*) begin
    case (currentState)
        STATE_RESET: begin
            nextState <= STATE_IDLE;
        end
        STATE_IDLE: begin
            if (bus_ack == ASSERT) begin
                if (bus_we == ASSERT) begin
                    nextState <= STATE_WRITE_WAIT;
                end
                else begin
                    if (burst_length == 1) begin
                        nextState <= STATE_READ_SINGLE_WAIT;
                    end
                    else begin
                        nextState <= STATE_READ_PAGE_WAIT;
                    end
                end
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_READ_SINGLE_WAIT: begin
            if (cycle_count_geq) begin
                nextState <= STATE_READ_SINGLE_DATA;
            end
            else begin
                nextState <= STATE_READ_SINGLE_WAIT;
            end
        end
        STATE_READ_SINGLE_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_READ_PAGE_WAIT: begin
            nextState <= STATE_READ_PAGE_DATA; //TODO
        end
        STATE_READ_PAGE_DATA: begin
            nextState <= STATE_FINISH; //TODO
        end
        STATE_WRITE_WAIT: begin
            if (cycle_count_geq) begin
                nextState <= STATE_WRITE_DATA;
            end
            else begin
                nextState <= STATE_WRITE_WAIT;
            end
        end
        STATE_WRITE_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_FINISH: begin
            if (bus_ack) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

//Outputs
always@(*) begin
    case (currentState) 
       STATE_RESET: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait_en <= DEASSERT;
            mcre <= DEASSERT;
            moe_L <= DEASSERT_L;
            mlb_L <= DEASSERT_L;
            mub_L <= DEASSERT_L;
            
            //Local signals
            reset <= ASSERT;
            addr_reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
        STATE_IDLE: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait_en <= DEASSERT;
            mcre <= DEASSERT;
            moe_L <= DEASSERT_L;
            mlb_L <= DEASSERT_L;
            mub_L <= DEASSERT_L;
            
            //Local signals
            reset <= ASSERT;
            addr_reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= ASSERT;
        end
        STATE_READ_SINGLE_WAIT: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            if (cycle_count_geq) begin //end WAIT one cycle before state transition
                bwait_en <= DEASSERT;
            end
            else begin
                bwait_en <= ASSERT;
            end
            mcre <= DEASSERT;
            if (cycle_count_geq) begin
                moe_L <= ASSERT_L;
            end
            else begin
                moe_L <= DEASSERT_L;
            end
            mlb_L <= ASSERT_L;
            mub_L <= ASSERT_L;
            addr_reset <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
        STATE_READ_SINGLE_DATA: begin //Data valid
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            bwait_en <= DEASSERT;
            mcre <= DEASSERT;
            moe_L <= ASSERT_L;
            mlb_L <= ASSERT_L;
            mub_L <= ASSERT_L;
            addr_reset <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
        STATE_WRITE_WAIT: begin
            //Outputs
            if (cycle_counter == 0) begin //tWPH, hold mwe high for min 10ns
                mwe_L <= DEASSERT_L;
            end
            else begin
                mwe_L <= ASSERT_L;
            end
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            if (cycle_count_geq) begin //end WAIT one cycle before state transition
                bwait_en <= DEASSERT;
            end
            else begin
                bwait_en <= ASSERT;
            end
            mcre <= DEASSERT;
            moe_L <= DEASSERT_L;
            mlb_L <= ASSERT_L;
            mub_L <= ASSERT_L;
            addr_reset <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
        STATE_WRITE_DATA: begin //Data valid
            //Outputs
            mwe_L <= ASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
            bwait_en <= DEASSERT;
            mcre <= DEASSERT;
            moe_L <= DEASSERT_L;
            mlb_L <= ASSERT_L;
            mub_L <= ASSERT_L;
            addr_reset <= DEASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
        default: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait_en <= DEASSERT;
            mcre <= DEASSERT;
            moe_L <= DEASSERT_L;
            mlb_L <= DEASSERT_L;
            mub_L <= DEASSERT_L;
            addr_reset <= DEASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            addr_write_en <= DEASSERT;
        end
    endcase
end


endmodule
