`timescale 1ns / 1ps

module uart(input clk50MHz,
            input rx,
            output tx,
            output reg busy,
            output [7:0] data_out,
            output reg data_out_valid,
            input [7:0] data_in,
            input data_in_valid);

parameter UART_BAUD = 115200;
parameter INPUT_CLOCK = 25000000;

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
                                   .parallel_out(data_out));
                    
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
                                        
//Mux between start bit (0) and data bits
wire tx_out;
reg start;
assign tx_out = (start)? 0 : data_in[bitCount];

//Keep tx high when not in use
reg oe;       
assign tx = (oe)? tx_out : 1;

parameter STATE_RESET = 0;
parameter STATE_IDLE = 1;
parameter STATE_READ_DATA = 2;
parameter STATE_WRITE_START = 3;
parameter STATE_WRITE_DATA = 4;
parameter STATE_PARITY = 5;
parameter STATE_FINISH_READ = 6;
parameter STATE_FINISH_WRITE = 7;

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
            data_out_valid <= 0;
            oe <= 0;
            start <= 0;
            busy <= 1;
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
            data_out_valid <= 0;
            oe <= 0;
            start <= 0;
            busy <= 0;
            
            if (sampleCycleCount == CLOCKS_BETWEEN_SAMPLES) begin
                sample_we <= 1;
                sample_cycle_count_rst <= 1;
            end
            else begin
                sample_we <= 0;
                sample_cycle_count_rst <= 0;
            end
        end
        STATE_READ_DATA: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            cycle_count_en <= 1;
            sample_rst <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            data_out_valid <= 0;
            oe <= 0;
            start <= 0;
            busy <= 1;
            
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
        STATE_WRITE_START: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            sample_rst <= 0;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            bit_count_en <= 0;
            data_out_valid <= 0;
            oe <= 1;
            start <= 1;
            busy <= 1;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
                cycle_count_en <= 1;
                cycle_count_rst <= 0;
            end
        end
        STATE_WRITE_DATA: begin
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 0;
            sample_we <= 0;
            cycle_count_en <= 1;
            sample_rst <= 0;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 0;
            data_out_valid <= 0;
            oe <= 1;
            start <= 0;
            busy <= 1;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                cycle_count_rst <= 1;
                bit_count_en <= 1;
            end
            else begin
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
            data_out_valid <= 0;
            oe <= 0;
            start <= 0;
            busy <= 1;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
                cycle_count_en <= 1;
                cycle_count_rst <= 0;
            end
        end
        STATE_FINISH_READ: begin //Waits for a full bit cycle so that we don't start again
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 1;
            sample_we <= 0;
            sample_rst <= 1;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 1;
            bit_count_en <= 0;
            oe <= 0;
            start <= 0;
            busy <= 1;
            
            if (cycleCount == 1) begin //Send a "data valid" pulse near the beginning of this state
                data_out_valid <= 1;
            end
            else begin
                data_out_valid <= 0;
            end
            
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
                cycle_count_en <= 1;
                cycle_count_rst <= 0;
            end
        end
        STATE_FINISH_WRITE: begin //Waits for a full bit cycle so that we don't start again
            sample_cycle_count_en <= 0;
            sample_cycle_count_rst <= 1;
            sample_we <= 0;
            sample_rst <= 1;
            data_we <= 0;
            data_rst <= 0;
            bit_count_rst <= 1;
            bit_count_en <= 0;
            oe <= 0;
            start <= 0;
            data_out_valid <= 0;
            busy <= 1;
            
            if (cycleCount == CLOCKS_BETWEEN_BITS * 2) begin
                cycle_count_en <= 0;
                cycle_count_rst <= 1;
            end
            else begin
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
            data_out_valid <= 0;
            oe <= 0;
            start <= 0;
            busy <= 1;
        end
   endcase
end

always@(*) begin
    case (currentState)
        STATE_RESET: begin
            nextState <= STATE_IDLE;
        end
        STATE_IDLE: begin
            if (data_in_valid) begin
                nextState <= STATE_WRITE_START;
            end
            else begin
                if (sampleOut == 0) begin
                    nextState <= STATE_READ_DATA;
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
        end
        STATE_READ_DATA: begin
            if (bitCount == 8) begin //Skip parity for now
                nextState <= STATE_FINISH_READ;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_WRITE_START: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                nextState <= STATE_WRITE_DATA;
            end
            else begin
                nextState <= STATE_WRITE_START;
            end
        end
        STATE_WRITE_DATA: begin
            if (bitCount == 8) begin //Skip parity for now
                nextState <= STATE_FINISH_WRITE;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
        end
        STATE_PARITY: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                nextState <= STATE_FINISH_READ; //TODO
            end
            else begin
                nextState <= STATE_PARITY;
            end
        end
        STATE_FINISH_READ: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_FINISH_READ;
            end
        end
        STATE_FINISH_WRITE: begin
            if (cycleCount == CLOCKS_BETWEEN_BITS * 2) begin //"1.5" stop bits
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_FINISH_WRITE;
            end
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

endmodule
