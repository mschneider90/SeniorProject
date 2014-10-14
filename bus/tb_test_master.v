// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
// OUT OF DATE
// SEE tb_impl_test_master.v
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module tb_test_master #(parameter BUS_WIDTH = 32,
                     parameter CTRL_WIDTH = 8,
                     parameter WRITE_TRANSFER = 1)
                    (input [BUS_WIDTH-1:0] bus_in,
                     input ack,
                     input clk,
                     output reg req,
                     output reg [BUS_WIDTH-1:0] bus_out,
                     input [CTRL_WIDTH-1:0] ctrl_in,
                     output[CTRL_WIDTH-1:0] ctrl_out);
                     
parameter STATE_REQ = 0;
parameter STATE_PRESENT_ADDR = 1;
parameter STATE_SLAVE_WAIT = 2;
parameter STATE_WRITE_DATA = 3;
parameter STATE_READ_DATA = 4;
parameter STATE_IDLE = 5;

parameter BURST_LENGTH = 4;

reg [3:0] nextState;
reg [3:0] currentState;
reg [3:0] counter;

reg we;
assign ctrl_out = {3'b000, //not used
                   3'b010, //burst = 4
                   we,     
                   1'b0 };    //wait 
                  
wire wait_in;
assign wait_in = ctrl_in[0];
 
initial begin
    nextState <= 0;
    currentState <= 0;
    counter <= 0;
    we <= 0;
end

always@(posedge clk) begin
    currentState <= nextState;
end

//counter
reg counter_en;
always@(posedge clk) begin
    if (counter_en) begin
        counter = counter + 1;
    end
end

//Outputs
always@(*) begin
    case (currentState)
        STATE_REQ: begin
            req <= 1;
            counter_en <= 0;
        end
        STATE_PRESENT_ADDR: begin
            bus_out <= 2;
            we <= WRITE_TRANSFER;
            counter_en <= 0;
        end
        STATE_SLAVE_WAIT: begin
            bus_out <= 0;
        end
        STATE_WRITE_DATA: begin
            bus_out <= counter;
            counter_en <= 1;
        end
        STATE_READ_DATA: begin
            counter_en <= 1;
        end
        STATE_IDLE: begin
            req <= 0;
            counter_en <= 0;
        end
    endcase
end

//Next State Logic
always@(*) begin
    case (currentState)
        STATE_REQ: begin
            if (ack) begin
                nextState <= STATE_PRESENT_ADDR;
            end 
            else begin
                nextState <= STATE_REQ;
            end
        end
        STATE_PRESENT_ADDR: begin
            nextState <= STATE_SLAVE_WAIT;
        end
        STATE_SLAVE_WAIT: begin //Wait for slave to lower WAIT
            if (wait_in == 0) begin
                if (WRITE_TRANSFER) begin
                    nextState <= STATE_WRITE_DATA;
                end
                else begin
                    nextState <= STATE_READ_DATA;
                end
            end
            else begin
                nextState <= STATE_SLAVE_WAIT;
            end
        end
        STATE_WRITE_DATA: begin
            if (counter == BURST_LENGTH - 1) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
        end
        STATE_READ_DATA: begin
            if (counter == BURST_LENGTH - 1) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_IDLE: begin
            nextState <= STATE_IDLE;
        end
    endcase
end

endmodule
