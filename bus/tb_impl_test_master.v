`timescale 1ns / 1ps
module tb_impl_test_master #(parameter BUS_WIDTH = 32,
                     parameter CTRL_WIDTH = 8)
                    (input [BUS_WIDTH-1:0] bus_in,
					 input writeTransfer,
                     input en,
                     input [1:0] debug_sel,
                     input ack,
                     input clk,
                     input ready_in,
                     output reg req,
                     output reg [BUS_WIDTH-1:0] bus_out,
                     input [CTRL_WIDTH-1:0] ctrl_in,
                     output[CTRL_WIDTH-1:0] ctrl_out,
                     output reg[7:0] debug_out);
                     
parameter STATE_REQ = 1;
parameter STATE_PRESENT_ADDR = 2;
parameter STATE_SLAVE_WAIT = 3;
parameter STATE_WRITE_DATA = 4;
parameter STATE_READ_DATA = 5;
parameter STATE_FINISH = 6;
parameter STATE_IDLE = 0;

parameter BURST_LENGTH_ACTUAL = 1;
parameter BURST_LENGTH_BUS = 3'b000; //burst of 1

reg [3:0] nextState;
reg [3:0] currentState;
reg [3:0] counter;

reg we;
always@(posedge clk) begin
    if (currentState == STATE_IDLE) begin
        we <= writeTransfer;
    end
    else begin
        we <= we;
    end
end
assign ctrl_out = {3'b000, //not used
                   BURST_LENGTH_BUS, 
                   we,     
                   1'b0 };    //wait 
                  
wire wait_in;
assign wait_in = ctrl_in[0];
 
initial begin
    nextState <= 0;
    currentState <= 0;
    counter <= 0;
end

always@(posedge clk) begin
    currentState <= nextState;
end

reg[31:0] data[3:0];
reg data_we;
always@(posedge clk) begin
    if (data_we) begin
        data[counter] <= bus_in;
    end
    else begin
        data[counter] <= data[counter];
    end
end

always@(debug_sel, data[0], data[1], data[2], data[3]) begin
    debug_out <= data[debug_sel];
end

//counter
reg counter_en;
always@(posedge clk) begin
    if (counter_en) begin
        counter <= counter + 1;
    end
    else begin
        counter <= 0;
    end
end

reg [31:0] addr_magazine [3:0];
reg [31:0] data_magazine [3:0];

initial begin //init addr and data magazines
    addr_magazine[0] <= 32'h01000020;
    addr_magazine[1] <= 32'h01000021;
    addr_magazine[2] <= 32'h01000022;
    addr_magazine[3] <= 32'h01000023;
    
    data_magazine[0] <= 32'h00000CEB;
    data_magazine[1] <= 32'h00000000;
    data_magazine[2] <= 32'h00000000;
    data_magazine[3] <= 32'h00000000;
end

reg[2:0] round_counter;
reg round_count_en;
initial begin
    round_counter <= 0;
	 round_count_en <= 1;
end


always@(posedge clk) begin
	 if (round_counter == 2) 
			begin
				round_count_en <= 0;
		 end
//    if (round_count_en == 1) begin
 //       round_counter <= round_counter + 1;
 //   end
   // else begin
   //     round_counter <= round_counter;
   // end

end

//bus data mux
reg bus_data_sel;
always@(*) begin
    if (bus_data_sel == 0) begin //ADDRESS
        bus_out <= addr_magazine[round_counter];   //put adddress here
    end
    else begin
        bus_out <= data_magazine[round_counter];//counter + 1; //ouput 1, 2, 3, 4, etc // put data here
    end
end

//Outputs
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            req <= 0;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;
            //round_count_en <= 0;
        end
        STATE_REQ: begin
            req <= 1;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;
            //round_count_en <= 0;
        end
        STATE_PRESENT_ADDR: begin
            req <= 1;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;
            //round_count_en <= 0;
        end
        STATE_SLAVE_WAIT: begin
            req <= 1;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;
            //round_count_en <= 0;
        end
        STATE_WRITE_DATA: begin
            req <= 1;
            counter_en <= 1;
            data_we <= 0;
            bus_data_sel <= 1;
				//if (round_count_en == 1) begin
				//	round_counter <= round_counter + 1;
				//end
            //round_count_en <= 0;
        end
        STATE_READ_DATA: begin
            req <= 1;
            counter_en <= 1;
            data_we <= 1;
            bus_data_sel <= 0;
            //round_count_en <= 0;
        end
        STATE_FINISH: begin
            req <= 0;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;

            
				//if (round_counter == 3) 
				//	begin
				//		round_count_en <= 0;
				//	end
            
				//else 
				//begin
            //    round_count_en <= 1;
            //end
        
		  
		  end
        default: begin
            req <= 0;
            counter_en <= 0;
            data_we <= 0;
            bus_data_sel <= 0;
            round_count_en <= 1;
        end
    endcase
end

//Next State Logic
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (en && ready_in) begin
                nextState <= STATE_REQ;
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
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
                if (we) begin
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
            if (counter == BURST_LENGTH_ACTUAL - 1) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_WRITE_DATA;
            end
        end
        STATE_READ_DATA: begin
            if (counter == BURST_LENGTH_ACTUAL - 1) begin
                nextState <= STATE_FINISH;
            end
            else begin
                nextState <= STATE_READ_DATA;
            end
        end
        STATE_FINISH: begin
            nextState <= STATE_IDLE;
        end
        default: nextState <= STATE_IDLE;
    endcase
end

endmodule
