`timescale 1ns / 1ps

module PS2StateController(input clk,
                          input data,
                          input parity_valid,
                          output shift_en,
                          output write_en,
                          output reset,
                          output frame_valid
                         );

reg[3:0] nextState;
reg[3:0] state;
reg data_latch;

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

always@(state) begin
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
            write_en <= 0;
            shift_en <= 0;
            reset <= 0;
            if (parity_valid && data_latch) begin //parity OK and stop bit
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
    state <= nextState;
    case (state) 
        STATE_START: begin
            if (data_latch == 0) begin
                nextState <= STATE_D0;
            end
            else begin
                nextState <= STATE_START;
            end
        end
        STATE_D0: begin
            nextState <= STATE_D1;
        end
        STATE_D1: begin
            nextState <= STATE_D2;
        end
        STATE_D2: begin
            nextState <= STATE_D3;
        end
        STATE_D3: begin
            nextState <= STATE_D4;
        end
        STATE_D4: begin
            nextState <= STATE_D5;
        end
        STATE_D5: begin
            nextState <= STATE_D6;
        end
        STATE_D6: begin
            nextState <= STATE_D7;
        end
        STATE_D7: begin
            nextState <= STATE_PARITY;
        end
        STATE_PARITY: begin
            if (parity_valid) begin
                nextState <= STATE_STOP;
            end
            else begin
                nextState <= STATE_START;
            end
        end
        STATE_STOP: begin
            nextState <= STATE_START;
        end
    endcase
end

always@(negedge clk) begin
    data_latch <= data;
end

endmodule

