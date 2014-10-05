`timescale 1ns / 1ps

module cpuBusInterface(input clk,
                       input memop,
                       input bus_ack,
                       input bus_wait,
                       output reg bus_req,
                       output reg pc_stall);

parameter STATE_IDLE = 0;
parameter STATE_REQ = 1;
parameter STATE_WAIT = 2;
parameter STATE_DATA = 3;

reg[1:0] currentState;
reg[1:0] nextState;

initial begin
    currentState = 0;
    nextState = 0;
end

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
                nextState <= STATE_WAIT;
            end
            else begin
                nextState <= STATE_REQ;
            end
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
            nextState <= STATE_IDLE;
        end
    endcase
end

always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            bus_req = 0;
            pc_stall = 0;
        end
        STATE_REQ: begin
            bus_req = 1;
            pc_stall = 1;
        end
        STATE_WAIT: begin
            bus_req = 1;
            pc_stall = 1;
        end
        STATE_DATA: begin
            bus_req = 0;
            pc_stall = 1;
        end
    endcase
end

always@(negedge clk) begin
    currentState <= nextState;
end

endmodule
