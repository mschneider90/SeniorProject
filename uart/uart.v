`timescale 1ns / 1ps

module uart(input clk50MHz,
            input rx,
            output tx,
            output [7:0] data,
            output reg data_valid);
            
//TODO
assign tx = 1;

parameter UART_BAUD = 9600;
parameter INPUT_CLOCK = 50000000;

parameter CLOCKS_BETWEEN_BITS = INPUT_CLOCK / (UART_BAUD);

// Input clock is 50MHz. Want to sample ~8 times per bit => 50MHz/(9600Hz * 8)
parameter SAMPLES_PER_BIT = 8;
parameter CLOCKS_BETWEEN_SAMPLES = INPUT_CLOCK / (UART_BAUD * SAMPLES_PER_BIT);

parameter HALF_BIT = SAMPLES_PER_BIT / 2;
wire [HALF_BIT-1:0] sampleOut;
reg sample_we;
reg sample_rst;
shift_reg_uart #(.WIDTH(HALF_BIT)) rxSamples(.serial_in(rx),
                    .en(sample_we),
                    .clk(clk50MHz),
                    .rst(sample_rst),
                    .parallel_out(sampleOut));
                    
    
reg data_we;
reg data_rst;
shift_reg_uart #(.WIDTH(8)) rxData(.serial_in(rx),
                                   .en(data_we),
                                   .clk(clk50MHz),
                                   .rst(data_rst),
                                   .parallel_out(data));
                    
wire [15:0] cycleCount;
reg cycle_count_en;
reg cycle_count_rst;
count_reg #(.D_WIDTH(16)) cycleCounter (.en(cycle_count_en),
                                        .rst(cycle_count_rst),
                                        .clk(clk50MHz),
                                        .count(cycleCount));
 
wire [3:0] bitCount;
reg bit_count_en;
reg bit_count_rst; 
count_reg #(.D_WIDTH(4)) bitCounter (.en(bit_count_en),
                                     .rst(bit_count_rst),
                                     .clk(clk50MHz),
                                     .count(bitCount));
                                        
wire [15:0] sampleCycleCount;
reg sample_cycle_count_en;
reg sample_cycle_count_rst;
count_reg #(.D_WIDTH(16)) sampleCycleCounter (.en(sample_cycle_count_en),
                                        .rst(sample_cycle_count_rst),
                                        .clk(clk50MHz),
                                        .count(sampleCycleCount));


parameter STATE_RESET = 0;
parameter STATE_IDLE = 1;
parameter STATE_DATA= 2;
parameter STATE_PARITY = 3;
parameter STATE_FINISH = 4;

reg [2:0] currentState;
reg [2:0] nextState;

initial begin
    currentState <= STATE_RESET;
    nextState <= STATE_RESET;
end

always@(posedge clk50MHz) begin
    currentState <= nextState;
end

always@(*) begin
    case (currentState)
        STATE_RESET: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 1;
            sample_we <= 0;
            cycle_count_en <= 0;
            cycle_count_rst <= 1;
            sample_rst <= 1;
            data_we <= 0;
            data_rst <= 1;
            bit_count_rst <= 1;
            bit_count_en <= 0;
            data_valid <= 0;
        end
        STATE_IDLE: begin
            sample_cycle_count_en <= 1;
            cycle_count_en <= 0;
            cycle_count_rst <= 0;
            sample_rst <= 0;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            bit_count_en <= 0;
            data_valid <= 0;
            
            if (sampleCycleCount == CLOCKS_BETWEEN_SAMPLES) begin
                sample_we <= 1;
                sample_cycle_count_rst <= 1;
            end
            else begin
                sample_we <= 0;
                sample_cycle_count_rst <= 0;
            end
        end
        STATE_DATA: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            cycle_count_en <= 1;
            sample_rst <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            data_valid <= 0;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                data_we <= 1;
                cycle_count_rst <= 1;
                bit_count_en <= 1;
            end
            else begin
                data_we <= 0;
                cycle_count_rst <= 0;
                bit_count_en <= 0;
            end
        end
        STATE_PARITY: begin 
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            sample_rst <= 0;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            bit_count_en <= 0;
            data_valid <= 0;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
                cycle_count_en <= 1;
                cycle_count_rst <= 0;
            end
        end
        STATE_FINISH: begin //Waits for a full bit cycle so that we don't accidentally start again
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 1;
            sample_we <= 0;
            sample_rst <= 1;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 1;
            bit_count_en <= 0;
            
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                data_valid <= 1;
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
                data_valid <= 0;
                cycle_count_en <= 1;
                cycle_count_rst <= 0;
            end
        end
        default: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            cycle_count_en <= 0;
            cycle_count_rst <= 0;
            sample_rst <= 0;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            bit_count_en <= 0;
            data_valid <= 0;
        end
   endcase
end

always@(*) begin
    case (currentState)
        STATE_RESET: begin
            nextState <= STATE_IDLE;
        end
        STATE_IDLE: begin
            if (sampleOut == 0) begin
                nextState <= STATE_DATA;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_DATA: begin
            if (bitCount == 8) begin
                nextState <= STATE_PARITY;
            end
            else begin
                nextState <= STATE_DATA;
            end
        end
        STATE_PARITY: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_PARITY;
            end
        end
        STATE_FINISH: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_FINISH;
            end
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

endmodule
