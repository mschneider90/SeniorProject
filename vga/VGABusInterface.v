`timescale 1ns / 1ps

module VGABusInterface(input clk,
                       input [10:0] row,
                       input [10:0] col,
                       input bus_ack,
                       input reset,
                       input bus_wait,
                       output reg bus_req,
                       output buf_sel,
                       output buf0_we,
                       output buf1_we,
                       output [31:0] bus_out);
                       
parameter RES_X = 640;
parameter RES_Y = 480;
                       
wire [31:0] pix_addr;
assign pix_addr = row * RES_X + col;

wire [31:0] pix_addr_reduced;
assign pix_addr_reduced = pix_addr >> 4;

assign bus_out = pix_addr_reduced;

wire currentBuf;
assign buf_sel = currentBuf;
reg switch_buf;
d_reg_sync #(.WIDTH(1)) currentPixBuf(.clk(clk),
                                      .en(switch_buf),
                                      .reset(reset),
                                      .d(~currentBuf),
                                      .q(currentBuf));

wire [31:0] last_addr; 
reg last_addr_we;
d_reg_sync #(.WIDTH(32)) lastAddrReg(.clk(clk),
                                      .en(last_addr_we),
                                      .reset(reset),
                                      .d(pix_addr_reduced),
                                      .q(last_addr));
                                      
reg buf_we;
assign buf0_we = ((buf_sel != 1) && buf_we)? 1 : 0; // Buffer not selected, so write to it
assign buf1_we = ((buf_sel != 0) && buf_we)? 1 : 0;

parameter STATE_IDLE = 0;
parameter STATE_PRESENT_ADDR = 1;
parameter STATE_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_FINISH = 4;

reg [2:0] currentState;
reg [2:0] nextState;

always@(posedge clk) begin
    currentState <= nextState;
end

// Next state logic
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (pix_addr_reduced != last_addr) begin
                if (bus_ack) begin
                    nextState <= STATE_PRESENT_ADDR;
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_PRESENT_ADDR: begin
            nextState <= STATE_WAIT;
        end
        STATE_WAIT: begin
            if (bus_wait) begin
                nextState <= STATE_WAIT;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_READ_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_FINISH: begin
            nextState <= STATE_IDLE;
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

// Current state outputs
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (pix_addr_reduced != last_addr) begin
                bus_req <= 1;
                switch_buf <= 1;
            end
            else begin
                bus_req <= 0;
                switch_buf <= 0;
            end
            buf_we <= 0;
            last_addr_we <= 0;
        end
        STATE_PRESENT_ADDR: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 1;
            switch_buf <= 0;
        end
        STATE_WAIT: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
        end
        STATE_READ_DATA: begin
            bus_req <= 0;
            buf_we <= 1;
            last_addr_we <= 0;
            switch_buf <= 0;
        end
        STATE_FINISH: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
        end
        default: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
        end
    endcase
end

endmodule
