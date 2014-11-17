`timescale 1ns / 1ps

module cpuBusInterface(input clk,
                       input memop,
                       input bus_ack,
                       input bus_wait,
                       output reg bus_req,
                       output pc_stall,
                       output reg data_out);

parameter STATE_IDLE = 0;
parameter STATE_REQ = 1;
parameter STATE_ADDR = 2;
parameter STATE_WAIT = 3;
parameter STATE_DATA = 4;
parameter STATE_FINISH = 5;

reg[2:0] currentState;
reg[2:0] nextState;

initial begin
    currentState <= 0;
    nextState <= 0;
end

// Need to react faster than one clock cycle for stalling pc when a memop is detected
reg pc_stall_en;
assign pc_stall = (memop && currentState == STATE_IDLE)? 1 : pc_stall_en;

always@(*) begin
    case (currentState) 
        STATE_IDLE: begin
            if (memop) begin
                nextState <= STATE_REQ;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_REQ: begin
            if (bus_ack) begin
                nextState <= STATE_ADDR;
            end
            else begin
                nextState <= STATE_REQ;
            end
        end
        STATE_ADDR: begin
            nextState <= STATE_WAIT;
        end
        STATE_WAIT: begin
            if (bus_wait) begin
                nextState <= STATE_WAIT;
            end
            else begin
                nextState <= STATE_DATA;
            end
        end
        STATE_DATA: begin //Only support burst length of 1 at the moment
            nextState <= STATE_FINISH;
        end
        STATE_FINISH: begin // One last state to allow the bus controller to catch up
            nextState <= STATE_IDLE;
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
        end
        STATE_REQ: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
        end
        STATE_ADDR: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
        end
        STATE_WAIT: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 1;
        end
        STATE_DATA: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 1;
        end
        STATE_FINISH: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 1;
        end
        default: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
        end
    endcase
end

always@(posedge clk) begin
    currentState <= nextState;
end

endmodule
