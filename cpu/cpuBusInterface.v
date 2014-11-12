`timescale 1ns / 1ps

module cpuBusInterface(input clk,
                       input reset,
                       input memop,
                       input bus_ack,
                       input bus_we,
                       input bus_wait,
                       output reg bus_req,
                       output pc_stall,
                       output reg data_out,
                       output reg imem_out,
                       output reg imem_we,
                       output reg sel_pc,
                       output reg bus_addr_write);

parameter STATE_IDLE = 0;
parameter STATE_MASTER_REQ = 1;
parameter STATE_MASTER_ADDR = 2;
parameter STATE_MASTER_WAIT = 3;
parameter STATE_MASTER_DATA = 4;
parameter STATE_MASTER_FINISH = 5;
parameter STATE_SLAVE_WRITE_WAIT = 6;
parameter STATE_SLAVE_READ_WAIT = 7;
parameter STATE_SLAVE_READ = 8;
parameter STATE_SLAVE_WRITE = 9;
parameter STATE_SLAVE_FINISH = 10;

reg[3:0] currentState;
reg[3:0] nextState;

initial begin
    currentState <= STATE_IDLE;
    nextState <= STATE_IDLE;
end                        

// Need to react faster than one clock cycle for stalling pc when a memop is detected
reg pc_stall_en;
assign pc_stall = (memop && currentState == STATE_IDLE)? 1 : (pc_stall_en);

always@(*) begin
    case (currentState) 
        STATE_IDLE: begin
            if (reset) begin
                if (bus_ack) begin
                    if (bus_we) begin
                        nextState <= STATE_SLAVE_WRITE_WAIT;
                    end
                    else begin
                        nextState <= STATE_SLAVE_READ_WAIT;
                    end
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
            else begin
                if (memop) begin
                    nextState <= STATE_MASTER_REQ;
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
        end
        STATE_MASTER_REQ: begin
            if (bus_ack) begin
                nextState <= STATE_MASTER_ADDR;
            end
            else begin
                nextState <= STATE_MASTER_REQ;
            end
        end
        STATE_MASTER_ADDR: begin
            nextState <= STATE_MASTER_WAIT;
        end
        STATE_MASTER_WAIT: begin
            if (bus_wait) begin
                nextState <= STATE_MASTER_WAIT;
            end
            else begin
                nextState <= STATE_MASTER_DATA;
            end
        end
        STATE_MASTER_DATA: begin //Only support burst length of 1 at the moment
            nextState <= STATE_MASTER_FINISH;
        end
        STATE_MASTER_FINISH: begin // One last state to allow the bus controller to catch up
            nextState <= STATE_IDLE;
        end
        STATE_SLAVE_READ_WAIT: begin
            nextState <= STATE_SLAVE_READ;
        end
        STATE_SLAVE_WRITE_WAIT: begin
            nextState <= STATE_SLAVE_WRITE;
        end
        STATE_SLAVE_READ: begin
            nextState <= STATE_SLAVE_FINISH;
        end
        STATE_SLAVE_WRITE: begin
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
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            if (bus_ack) begin
                bus_addr_write <= 1;
            end
            else begin
                bus_addr_write <= 0;
            end
        end
        STATE_MASTER_REQ: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
        STATE_MASTER_ADDR: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
        STATE_MASTER_WAIT: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 1;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
        STATE_MASTER_DATA: begin
            bus_req <= 1;
            pc_stall_en <= 1;
            data_out <= 1;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
        STATE_MASTER_FINISH: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 1;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
        STATE_SLAVE_READ_WAIT: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 0;
            bus_addr_write <= 0;
        end
        STATE_SLAVE_WRITE_WAIT: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 0;
            bus_addr_write <= 0;
        end
        STATE_SLAVE_READ: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 1;
            sel_pc <= 0;
            bus_addr_write <= 0;
        end
        STATE_SLAVE_WRITE: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 1;
            imem_out <= 0;
            sel_pc <= 0;
            bus_addr_write <= 0;
        end
        STATE_SLAVE_FINISH: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 0;
            bus_addr_write <= 0;
        end
        default: begin
            bus_req <= 0;
            pc_stall_en <= 0;
            data_out <= 0;
            imem_we <= 0;
            imem_out <= 0;
            sel_pc <= 1;
            bus_addr_write <= 0;
        end
    endcase
end

always@(posedge clk) begin
    currentState <= nextState;
end

endmodule
