`timescale 1ns / 1ps

module PS2InterfaceStateController(input clk,
                          input data,
                          input parity_valid,
                          output reg shift_en,
                          output reg write_en,
                          output reg reset,
                          output reg frame_valid
                         );

reg[3:0] next_state;
reg[3:0] state;

parameter STATE_START = 0;
parameter STATE_D0 = 1;
parameter STATE_D1 = 2;
parameter STATE_D2 = 3;
parameter STATE_D3 = 4;
parameter STATE_D4 = 5;
parameter STATE_D5 = 6;
parameter STATE_D6 = 7;
parameter STATE_D7 = 8;
parameter STATE_PARITY = 9;
parameter STATE_STOP = 10;

initial begin
    state <= STATE_START;
    next_state <= STATE_START;
end

always@(*) begin
    case(state)
        STATE_START: begin
            write_en <= 0;
            shift_en <= 0;
            reset <= 1;
            frame_valid <= 0;
        end
        STATE_D0: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D1: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D2: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D3: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D4: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D5: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D6: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_D7: begin
            write_en <= 0;
            shift_en <= 1;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_PARITY: begin
            write_en <= 0;
            shift_en <= 0;
            reset <= 0;
            frame_valid <= 0;
        end
        STATE_STOP: begin
            write_en <= 1;
            shift_en <= 0;
            reset <= 0;
            if (data && parity_valid) begin //stop bit
                frame_valid <= 1;
            end 
            else begin
                frame_valid <= 0;
            end
        end
        default: begin
            write_en <= 0;
            shift_en <= 0;
            reset <= 0;
            frame_valid <= 0;
        end
    endcase
end

always@(posedge clk) begin
    state <= next_state;
end

always@(negedge clk) begin
    case (state) 
        STATE_START: begin
            if (data == 1'b0) begin
                next_state <= STATE_D0;
            end
            else begin
                next_state <= STATE_START;
            end
        end
        STATE_D0: begin
            next_state <= STATE_D1;
        end
        STATE_D1: begin
            next_state <= STATE_D2;
        end
        STATE_D2: begin
            next_state <= STATE_D3;
        end
        STATE_D3: begin
            next_state <= STATE_D4;
        end
        STATE_D4: begin
            next_state <= STATE_D5;
        end
        STATE_D5: begin
            next_state <= STATE_D6;
        end
        STATE_D6: begin
            next_state <= STATE_D7;
        end
        STATE_D7: begin
            next_state <= STATE_PARITY;
        end
        STATE_PARITY: begin
            next_state <= STATE_STOP;
        end
        STATE_STOP: begin
            next_state <= STATE_START;
        end
    endcase
end

endmodule

