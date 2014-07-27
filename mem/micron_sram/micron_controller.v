`timescale 1ns / 1ps

module micron_controller #(parameter A_WIDTH = 16,
                           parameter D_WIDTH = 16)
                          (input clk50MHz,
                           input baddr[A_WIDTH-1:0],
                           inout bdata[D_WIDTH-1:0],
                           input bwe,
                           input [1:0] bburst,
                           output bwait,
                           output maddr[A_WIDTH-1:0],
                           inout  mdata[D_WIDTH-1:0],
                           output moe_L,  //output enable
                           output mwe_L,  //write enable
                           output madv_L, //address valid
                           output mclk,   //memory clock
                           output mub_L,  //upper byte
                           output mlb_L,  //lower byte
                           output mce_L,  //chip enable
                           output mcre,   //control register enable
                           input  mwait); //wait
                           
//Address of the SRAM controller
//TODO change this to global scope
parameter CTRL_ADDR = 16'hFFF0;
            
//Constants            
parameter ASSERT = 1;
parameter DEASSERT = 0;
parameter ASSERT_L = 0;
parameter DEASSERT_L = 1;

//States
parameter STATE_IDLE = 0;
parameter STATE_READ_ADDR = 1;
parameter STATE_READ_WAIT_1 = 2;
parameter STATE_READ_WAIT_2 = 3;
parameter STATE_READ_WAIT_3 = 4;
parameter STATE_READ_D0 = 5;
parameter STATE_READ_D1 = 6;
parameter STATE_READ_D2 = 7;
parameter STATE_READ_D3 = 8;
                           
//These aren't used
assign mub_L = DEASSERT_L;
assign mlb_L = DEASSERT_L;

//For read, mclk is active from WAIT_1 to D3
//For write, ???
assign mclk = (currentState >= STATE_WAIT_1 && currentState <= STATE_READ_D3)? clk50MHz : DEASSERT;

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
            if (baddr == CTRL_ADDR) begin //detected our address
                if (bwe) begin
                    //TODO goto first write state
                    nextState <= STATE_IDLE;
                end
                else begin
                    nextState <= STATE_READ_WAIT_1;
                end
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_READ_ADDR: begin
            nextState <= STATE_READ_WAIT_1;
        end
        STATE_READ_WAIT_1: begin
            nextState <= STATE_READ_WAIT_2;
        end
        STATE_READ_WAIT_2: begin
            nextState <= STATE_READ_WAIT_3;
        end
        STATE_READ_WAIT_3: begin
            nextState <= STATE_READ_D0;
        end
        STATE_READ_D0: begin
            nextState <= STATE_READ_D1;
        end
        STATE_READ_D1: begin
            nextState <= STATE_READ_D2;
        end
        STATE_READ_D2: begin
            nextState <= STATE_READ_D3;
        end
        STATE_READ_D3: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

//Outputs
always@(currentState) begin
    case (currentState) 
        STATE_IDLE: begin
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= DEASSERT_L;
        end
        STATE_READ_ADDR: begin
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= ASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_WAIT_1: begin
            moe_L <= DEASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_WAIT_2: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_WAIT_3: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_D0: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_D1: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_D2: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
        STATE_READ_D3: begin
            moe_L <= ASSERT_L;
            mwe_L <= DEASSERT_L;
            madv_L <= DEASSERT_L;
            mce_L <= ASSERT_L;
        end
    endcase
end




endmodule
