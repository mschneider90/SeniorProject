`timescale 1ns / 1ps

//Controller for Micron MT45W8 pseudo-SRAM device

module micron_controller #(parameter A_WIDTH = 23,
                           parameter D_WIDTH = 16,
                           parameter BUS_WIDTH = 32,
                           parameter BUS_CTRL = 8)
                          (input clk50MHz,
                           output reg ready,
                           input  [BUS_CTRL-1:0] bus_ctrl_in,
                           output [BUS_CTRL-1:0] bus_ctrl_out,
                           input  [BUS_WIDTH-1:0] bus_data_in,
                           output [BUS_WIDTH-1:0] bus_data_out,
                           input bus_ack,
                           inout  [D_WIDTH-1:0] mem_data,
                           output [A_WIDTH-1:0] maddr,
                           output moe_L,  //output enable
                           output reg mwe_L,  //write enable
                           output reg madv_L, //address valid
                           output mclk,   //memory clock
                           output mub_L,  //upper byte
                           output mlb_L,  //lower byte
                           output reg mce_L,  //chip enable
                           output reg mcre,   //control register enable
                           input  mwait); //wait
                           
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
            
//Constants            
parameter ASSERT = 1;
parameter DEASSERT = 0;
parameter ASSERT_L = 0;
parameter DEASSERT_L = 1;

//States
parameter STATE_RESET = 0;
parameter STATE_INIT = 1;
parameter STATE_IDLE = 2;
parameter STATE_READ_WAIT = 3;
parameter STATE_READ_DATA = 4;
parameter STATE_WRITE_WAIT = 5;
parameter STATE_WRITE_DATA = 6;
parameter STATE_FINISH = 7;

reg[2:0] currentState;
reg[2:0] nextState;

//Unidirectional bus to tristate bus conversion
assign mem_data = (moe_L == ASSERT_L)? 'bz : bus_data_in;
assign bus_data_out = mem_data;

//See: micron_ram.pdf (datasheet), pg. 29
//Default read/write latency is 4 cycles
//This also allows us to operate up to 52MHz - convenient
parameter RW_LATENCY_CYCLES = 3;

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

//Counter for r/w latency
reg cycle_count_en;
wire cycle_count_geq;
wire[1:0] cycle_counter;
count_reg c_counter(.count_load(0),
                    .en(cycle_count_en),
                    .rst(reset),
                    .clk(clk50MHz),
                    .count(cycle_counter),
                    .load(DEASSERT));
//Zero indexed so subtract 1
assign cycle_count_geq = (cycle_counter >= RW_LATENCY_CYCLES - 1) ? ASSERT : DEASSERT;

// Stores the burst length
wire [2:0] bus_burst;
d_reg #(.WIDTH(3)) burstReg
       (.clk(clk50MHz),
        .reset(0),
        .en(bus_ack == ASSERT && currentState == STATE_IDLE),
        .d(bus_ctrl_in[4:2]),
        .q(bus_burst));

//Counter for burst length - support length of up to 8
reg burst_count_en;
wire burst_count_geq;
wire[2:0] burst_counter;
count_reg b_counter(.count_load(0),
                    .en(burst_count_en),
                    .rst(reset),
                    .clk(clk50MHz),
                    .count(burst_counter),
                    .load(DEASSERT));
reg[2:0] burst_length;
always@(*) begin
    case (bus_burst) 
        3'b000: burst_length = 1;
        3'b001: burst_length = 2;
        3'b010: burst_length = 4;
        3'b011: burst_length = 8;
        default: burst_length = 1;
    endcase
end
assign burst_count_geq = (burst_counter >= burst_length - 1) ? ASSERT : DEASSERT;

//counter for init procedure
// See Micron CellularRAM data sheet, pg. 18
// tCW is 70ns, so we need to wait for four cycles after adv_L is lowered
parameter INIT_CYCLES = 6;
reg init_count_en;
wire init_count_geq;
wire[3:0] init_counter;
count_reg i_counter(.count_load(0),
                    .en(init_count_en),
                    .rst(reset),
                    .clk(clk50MHz),
                    .count(init_counter),
                    .load(DEASSERT));
//Zero indexed so subtract 1
assign init_count_geq = (init_counter >= INIT_CYCLES - 1) ? ASSERT : DEASSERT;
        
// Stores the starting memory address
wire [A_WIDTH-1:0] maddr_reg_out;
d_reg #(.WIDTH(A_WIDTH)) maddrReg
       (.clk(clk50MHz),
        .reset(reset),
        .en(bus_ack == ASSERT && currentState == STATE_IDLE),
        .d(bus_data_in),
        .q(maddr_reg_out));
        
// Muxes the memory address and the BCR config word
parameter SEL_MADDR = 0;
parameter SEL_BCR = 1;
reg addr_sel;
mux21 #(.D_WIDTH(A_WIDTH)) addr_mux
       (.in_a(maddr_reg_out),
        .in_b(BCR_CONFIG),
        .sel(addr_sel),
        .out(maddr));

//Generate memory clock
reg mclk_en;
assign mclk = (mclk_en == ASSERT)? clk50MHz : DEASSERT;

//Wait output
//TODO this doesn't need to be like this
reg bwait_en;
assign bus_wait_out = (bwait_en == ASSERT)? ASSERT : DEASSERT;
                       
//These aren't used
assign mub_L = DEASSERT_L;
assign mlb_L = DEASSERT_L;

assign moe_L = (cycle_count_geq & currentState == STATE_READ_WAIT || 
                currentState == STATE_READ_DATA)?
                ASSERT_L : DEASSERT_L;

initial begin
    currentState <= STATE_RESET;
    nextState <= STATE_RESET;
end

always@(posedge clk50MHz) begin
    currentState <= nextState;
end

//Next state logic
always@(*) begin
    case (currentState)
        STATE_RESET: begin
            nextState <= STATE_INIT;
        end
        STATE_INIT: begin
            if (init_count_geq) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_INIT;
            end
        end   
        STATE_IDLE: begin
            if (bus_ack == ASSERT) begin
                if (bus_we == ASSERT) begin
                    nextState <= STATE_WRITE_WAIT;
                end
                else begin
                    nextState <= STATE_READ_WAIT;
                end
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_READ_WAIT: begin
            if (cycle_count_geq) begin
                nextState <= STATE_READ_DATA;
            end
            else begin
                nextState <= STATE_READ_WAIT;
            end
        end
        STATE_READ_DATA: begin
            if (burst_count_geq) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
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
            if (burst_count_geq) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
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
            mclk_en <= DEASSERT;
            mcre <= DEASSERT;
            ready <= DEASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_BCR;
        end
        STATE_INIT: begin
            init_count_en <= ASSERT;
            addr_sel <= SEL_BCR;
            ready <= DEASSERT;
            reset <= DEASSERT;
            
            case (init_counter)
               0: begin 
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= DEASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                1: begin //ADV_L low, CE_L low, CRE high
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= ASSERT_L;
                    mce_L <= ASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= ASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                2: begin //CE_L low
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= ASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                3: begin //CE_L low
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= ASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                4: begin //CE low, WE low
                    //Outputs
                    mwe_L <= ASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= ASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                5: begin //CE high
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= DEASSERT_L;
                    bwait_en <= ASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
                default: begin
                    //Outputs
                    mwe_L <= DEASSERT_L;
                    madv_L <= DEASSERT_L;
                    mce_L <= DEASSERT_L;
                    bwait_en <= DEASSERT;
                    mclk_en <= DEASSERT;
                    mcre <= DEASSERT;
                    
                    //Local signals
                    cycle_count_en <= DEASSERT;
                    burst_count_en <= DEASSERT;
                end
            endcase
        end
        STATE_IDLE: begin
            //Outputs
            mwe_L <= ~bus_we;
            if (bus_ack == ASSERT) begin //Address and control signals valid
                madv_L <= ASSERT_L;
                mce_L <= ASSERT_L;
            end
            else begin
                madv_L <= DEASSERT_L;
                mce_L <= DEASSERT_L;
            end
            bwait_en <= DEASSERT;
            mclk_en <= DEASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        STATE_READ_WAIT: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            if (cycle_counter <= RW_LATENCY_CYCLES - 2) begin
                bwait_en <= ASSERT;
            end
            else begin
                bwait_en <= DEASSERT;
            end
            mclk_en <= ASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        STATE_READ_DATA: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait_en <= DEASSERT;
            mclk_en <= ASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= ASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        STATE_WRITE_WAIT: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            if (cycle_counter <= RW_LATENCY_CYCLES - 2) begin
                bwait_en <= ASSERT;
            end
            else begin
                bwait_en <= DEASSERT;
            end
            mclk_en <= ASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= ASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        STATE_WRITE_DATA: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
            bwait_en <= DEASSERT;
            mclk_en <= ASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= DEASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= ASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        STATE_FINISH: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait_en <= DEASSERT;
            mclk_en <= ASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
        default: begin
            //Outputs
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
            bwait_en <= DEASSERT;
            mclk_en <= DEASSERT;
            mcre <= DEASSERT;
            ready <= ASSERT;
            
            //Local signals
            reset <= ASSERT;
            cycle_count_en <= DEASSERT;
            burst_count_en <= DEASSERT;
            init_count_en <= DEASSERT;
            addr_sel <= SEL_MADDR;
        end
    endcase
end

endmodule
