`timescale 1ns / 1ps

module cpuBusInterface(input clk,
                       input memop,
                       input bus_ack,
                       input bus_wait,
                       input bus_we,
                       input reset,
                       output reg bus_req,
                       output pc_stall,
                       output reg data_out,
                       output reg instr_out,
                       output reg instr_addr_we,
                       output reg instr_addr_rst,
                       output reg instr_we);

parameter STATE_IDLE = 0;

// When CPU is operating in master mode
parameter STATE_REQ = 1;
parameter STATE_ADDR = 2;
parameter STATE_WAIT = 3;
parameter STATE_DATA = 4;
parameter STATE_FINISH = 5;

// When CPU is operating in slave mode
parameter STATE_SLAVE_WAIT_READ = 6;
parameter STATE_SLAVE_WAIT_WRITE = 7;
parameter STATE_SLAVE_READ_DATA = 8;
parameter STATE_SLAVE_WRITE_DATA = 9;
parameter STATE_SLAVE_FINISH = 10;

reg[3:0] currentState;
reg[3:0] nextState;

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
            if (reset) begin //Can only write/read instr mem when reset
                if (bus_ack) begin
                    if (bus_we) begin
                        nextState <= STATE_SLAVE_WAIT_WRITE;
                    end
                    else begin
                        nextState <= STATE_SLAVE_WAIT_READ;
                    end
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
            else begin
                if (memop) begin
                    nextState <= STATE_REQ;
                end
                else begin
                    nextState <= STATE_IDLE;
                end
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
        STATE_SLAVE_WAIT_READ: begin
            nextState <= STATE_SLAVE_READ_DATA;
        end
        STATE_SLAVE_WAIT_WRITE: begin
            nextState <= STATE_SLAVE_WRITE_DATA;
        end
        STATE_SLAVE_READ_DATA: begin
            nextState <= STATE_SLAVE_FINISH;
        end
        STATE_SLAVE_WRITE_DATA: begin
            nextState <= STATE_SLAVE_FINISH;
        end
        STATE_SLAVE_FINISH: begin
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
            if (reset && bus_ack) begin
                instr_addr_we <= 1;
            end
            else begin
                instr_addr_we <= 0;
            end
            instr_addr_rst <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_REQ: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
            instr_addr_we <= 0;
            instr_addr_rst <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_ADDR: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
            instr_addr_we <= 0;
            instr_addr_rst <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_WAIT: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 1;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_DATA: begin
            bus_req <= 0;
            pc_stall_en <= 1;
            data_out <= 1;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_FINISH: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 1;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_SLAVE_WAIT_READ: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_SLAVE_WAIT_WRITE: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
        STATE_SLAVE_READ_DATA: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 1;
        end
        STATE_SLAVE_WRITE_DATA: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 1;
            instr_out <= 0;
        end
        default: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            instr_addr_rst <= 0;
            instr_addr_we <= 0;
            instr_we <= 0;
            instr_out <= 0;
        end
    endcase
end

always@(posedge clk) begin
    currentState <= nextState;
end

endmodule
