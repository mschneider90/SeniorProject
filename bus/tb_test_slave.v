module tb_test_slave #(parameter BUS_WIDTH = 32,
                     parameter CTRL_WIDTH = 8)
                    (input [BUS_WIDTH-1:0] bus_in,
                     input ack,
                     input clk,
                     output reg [BUS_WIDTH-1:0] bus_out,
                     input [CTRL_WIDTH-1:0] ctrl_in,
                     output [CTRL_WIDTH-1:0] ctrl_out);
                     
reg [3:0] currentState;
reg [3:0] nextState;

parameter LATENCY = 4;

parameter STATE_WAIT_FOR_ACK = 0;
parameter STATE_WRITE_WAIT = 1;
parameter STATE_READ_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_WRITE_DATA = 4;
parameter STATE_IDLE = 5;

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

integer i;
initial begin
    currentState <= 0;
    nextState <= 0;
    counter <= 0;
    latencyCounter <= 0;
    
    for (i = 0; i < 8; i = i + 1) begin
        data[i] = i;
    end
end

always@(posedge clk) begin
    currentState <= nextState;
end

//counters
always@(posedge clk) begin
    if (counter_en) begin
        counter <= counter + 1;
    end
    if (latency_counter_en) begin
        latencyCounter <= latencyCounter + 1;
    end
end

// Outputs
reg latency_counter_en;
reg counter_en;
always@(*) begin
    case (currentState)
        STATE_WAIT_FOR_ACK: begin
            if (ack) begin
                counter <= bus_in; //starting address
                burst_length <= ctrl_in[4:2];
            end
            latency_counter_en <= 0;
            counter_en <= 0;
            wait_out <= 0;
            latencyCounter <= 0;
            counter <= 0;
        end
        STATE_READ_WAIT: begin
            latency_counter_en <= 1;
            counter_en <= 0;
            if (latencyCounter <= LATENCY - 2) begin
                wait_out <= 1;
            end
            else begin
                wait_out <= 0;
            end
        end
        STATE_WRITE_WAIT: begin
            latency_counter_en <= 1;
            counter_en <= 0;
            if (latencyCounter <= LATENCY - 2) begin
                wait_out <= 1;
            end
            else begin
                wait_out <= 0;
            end
        end
        STATE_READ_DATA: begin
            counter_en <= 1;
            latency_counter_en <= 0;
            bus_out <= data[counter];
            wait_out <= 0;
        end
        STATE_WRITE_DATA: begin
            counter_en <= 1;
            latency_counter_en <= 0;
            data[counter] <= bus_in;
            wait_out <= 0;
        end
        STATE_IDLE: begin
            latency_counter_en <= 0;
            counter_en <= 0;
            wait_out <= 0;
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
        end
        STATE_WRITE_WAIT: begin
            if (latencyCounter == LATENCY- 1) begin
                nextState <= STATE_WRITE_DATA;
            end 
        end
        STATE_READ_DATA: begin
            if (counter == (1 << burst_length) - 1) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_WRITE_DATA: begin
            if (counter == (1 << burst_length) - 1) begin
                nextState <= STATE_WAIT_FOR_ACK;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
        end
        STATE_IDLE: begin
            nextState <= STATE_WAIT_FOR_ACK;
        end
    endcase
end

endmodule
