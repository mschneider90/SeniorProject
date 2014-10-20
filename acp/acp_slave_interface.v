////////////////////////////////////////////////////////////////////////////////////
// Engineer: Michael Schneider. Modified for use with moosebox ACP by paul mayzeles
// Module Name:    acp: the moosebox Audio Co-Processor
// (C) Paul Mayzeles and Michael Schneider. 2014. 
// This code may be used freely as long as the original authors are credited. 
// You may also send us gifts or money if you'd like. 

module acp_mem_interface #(parameter BUS_WIDTH = 32,
                     parameter CTRL_WIDTH = 8)
                    (input [BUS_WIDTH-1:0] bus_in,
                     input ack,
                     input clk,
                     //output [BUS_WIDTH-1:0] bus_out,
                     input [CTRL_WIDTH-1:0] ctrl_in,
                     output [CTRL_WIDTH-1:0] ctrl_out,
							output reg addr_write,
							output reg data_we);
                     
reg [3:0] currentState;
reg [3:0] nextState;

parameter LATENCY = 4;

parameter STATE_WAIT_FOR_ACK = 0;
parameter STATE_WRITE_WAIT = 1;
parameter STATE_READ_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_WRITE_DATA = 4;
parameter STATE_FINISH = 5;

wire we;
assign we = ctrl_in[1];

reg wait_out;
assign ctrl_out = {7'b0,
                   wait_out
                  };

reg [3:0] burst_length;

reg [3:0] counter;
reg [3:0] latencyCounter;

reg [31:0] data [7:0];
//reg data_we;

initial begin
    currentState <= 0;
    nextState <= 0;
    counter <= 0;
end

always@(posedge clk) begin
    currentState <= nextState;
end

reg latency_counter_en;
reg counter_en;

//counters
//output reg addr_write;
always@(posedge clk) begin
    if (counter_en) begin
        if (addr_write) begin
            counter <= bus_in;
        end
        else begin
            counter <= counter + 1;
        end
    end
    else begin
        counter <= counter;
    end
end

reg latency_counter_reset;
always@(posedge clk) begin
    if (latency_counter_reset) begin
        latencyCounter <= 0;
    end
    else begin
        if (latency_counter_en) begin
            latencyCounter <= latencyCounter + 1;
        end
        else begin
            latencyCounter <= latencyCounter;
        end
    end
end

reg burst_write;
always@(posedge clk) begin
    if (burst_write) begin
        burst_length <= ctrl_in[4:2];
    end
    else begin
        burst_length <= burst_length;
    end
end

//Data R/W
//assign bus_out = data[counter];

/* 
always@(posedge clk) begin
    if (data_we) begin
        data[counter] <= bus_in;
    end
    else begin
        data[counter] <= data[counter];
    end
end
*/ 

// Outputs
always@(*) begin
    case (currentState)
        STATE_WAIT_FOR_ACK: begin
            addr_write <= 1;
            burst_write <= 1;
            latency_counter_en <= 0;
            latency_counter_reset <= 1;
            counter_en <= 1;
            wait_out <= 0;
            data_we <= 0;
        end
        STATE_READ_WAIT: begin
            addr_write <= 0;
            burst_write <= 0;
            latency_counter_en <= 1;
            latency_counter_reset <= 0;
            counter_en <= 0;
            data_we <= 0;
            
            if (latencyCounter <= LATENCY - 2) begin
                wait_out <= 1;
            end
            else begin
                wait_out <= 0;
            end
        end
        STATE_WRITE_WAIT: begin
            addr_write <= 0;
            burst_write <= 0;
            latency_counter_en <= 1;
            latency_counter_reset <= 0;
            counter_en <= 0;
            data_we <= 0;
            
            if (latencyCounter <= LATENCY - 2) begin
                wait_out <= 1;
            end
            else begin
                wait_out <= 0;
            end
        end
        STATE_READ_DATA: begin
            addr_write <= 0;
            burst_write <= 0;
            counter_en <= 1;
            latency_counter_en <= 0;
            latency_counter_reset <= 0;
            wait_out <= 0;
            data_we <= 0;
        end
        STATE_WRITE_DATA: begin
            addr_write <= 0;
            burst_write <= 0;
            counter_en <= 1;
            latency_counter_en <= 0;
            latency_counter_reset <= 0;
            wait_out <= 0;
            data_we <= 1;
        end
        STATE_FINISH: begin
            addr_write <= 0;
            burst_write <= 0;
            latency_counter_en <= 0;
            latency_counter_reset <= 0;
            counter_en <= 0;
            wait_out <= 0;
            data_we <= 0;
        end
        default: begin
            addr_write <= 0;
            burst_write <= 0;
            latency_counter_en <= 0;
            latency_counter_reset <= 0;
            counter_en <= 0;
            wait_out <= 0;
            data_we <= 0;
        end
    endcase
end

// next state logic
always@(*) begin
    case (currentState)
        STATE_WAIT_FOR_ACK: begin
            if (ack) begin
                if (we) begin
                    nextState <= STATE_WRITE_WAIT;
                end
                else begin
                    nextState <= STATE_READ_WAIT;
                end
            end
            else begin
                nextState <= STATE_WAIT_FOR_ACK;
            end
        end
        STATE_READ_WAIT: begin
            if (latencyCounter == LATENCY - 1) begin
                nextState <= STATE_READ_DATA;
            end
            else begin
                nextState <= STATE_READ_WAIT;
            end
        end
        STATE_WRITE_WAIT: begin
            if (latencyCounter == LATENCY- 1) begin
                nextState <= STATE_WRITE_DATA;
            end 
            else begin
                nextState <= STATE_WRITE_WAIT;
            end
        end
        STATE_READ_DATA: begin
            if (counter == (1 << burst_length) - 1) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_WRITE_DATA: begin
            if (counter == (1 << burst_length) - 1) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
        end
        STATE_FINISH: begin
            if (ack) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_WAIT_FOR_ACK;
            end
        end
    endcase
end

endmodule
