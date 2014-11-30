`timescale 1ns / 1ps

module VGABusInterface(input clk,
                       input [10:0] row,
                       input [10:0] col,
                       input bus_ack,
                       input reset,
                       input bus_wait,
                       input vga_output_valid,
                       input [31:0] base_addr,
                       output reg bus_req,
                       output buf_sel,
                       output buf_byte_sel,
                       output buf0_we,
                       output buf1_we,
                       output [2:0] buf_read_addr,
                       output [2:0] buf_write_addr,
					   output idle,
                       output [31:0] bus_out);
                   
localparam RES_X = 320;
localparam RES_Y = 240;

localparam BASE_ADDR = 32'h00001050;
localparam BURST_LENGTH = 8;

                       
wire [31:0] pix_addr;  // For selecting each byte
assign buf_read_addr[2:0] = pix_addr[3:1];

/* //left this unmodified from 80*240 mode 
assign pix_addr = (row >> 1) * RES_X + (col) >> 3); //multiplies row >> 1 by 160 //((((row >> 1) << 2) + (row >> 1)) << 5 ) + (col >> 2);

wire [31:0] pix_addr_reduced; // For determining what buffer we should be in
assign pix_addr_reduced = pix_addr >> 1;

assign bus_out =  (base_addr + pix_addr_reduced); //(( BASE_ADDR + pix_addr_reduced >= 32'h0000391F)) ? BASE_ADDR : BASE_ADDR + pix_addr_reduced;        //{BASE_ADDR + pix_addr_reduced};
*/


assign pix_addr = (row >> 1) * RES_X + (col >> 1); // row >> 1: 480 >> 1 = 240 rows. col >>1: 640 >> 1 = 320 columns. 

wire [31:0] pix_addr_reduced; // For determining what buffer we should be in
//assign pix_addr_reduced = pix_addr >> 1;
assign pix_addr_reduced = pix_addr >> 4; //with bigger buffers, we access the buss less. 
                                         //16 pix buffers mean we only get every 16th PIXEL address, or every 8th PHYSICAL (16-bit/word) address.  


assign bus_out =  (base_addr + (pix_addr_reduced << 3)); //the bus should only ask for every 8th PHYSICAL address. (pix_addr >> 4) << 3 = (each digit repeated 16 times) 0,8,16 


wire currentBuf;
//assign buf_sel = currentBuf;
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
 

//Counter for burst length 
reg burst_count_en;
wire burst_count_geq;
wire[2:0] burst_counter;
reg burst_count_reset;
count_reg b_counter(.count_load(0),
                    .en(burst_count_en),
                    .rst(burst_count_reset),
                    .clk(clk),
                    .count(burst_counter),
                    .load(0));

assign burst_count_geq = (burst_counter >= BURST_LENGTH - 1) ? 1 : 0;
//assign buff_write_address = burst_counter[2:0]; 
assign buf_write_addr[2:0] = burst_counter[2:0];

reg buf_we;
assign buf0_we = ((buf_sel != 0) && buf_we)? 1 : 0; // Buffer not selected, so write to it
assign buf1_we = ((buf_sel != 1) && buf_we)? 1 : 0;

assign buf_byte_sel = ~pix_addr[0]; // The LSb of the pixel address selects between the higher and lower byte of the buffer
//assign buf_sel = pix_addr[1];
assign buf_sel = pix_addr[4]; //pix_addr[4] switches the buffer every 16 pixels

parameter STATE_IDLE = 0;
parameter STATE_PRESENT_ADDR = 1;
parameter STATE_WAIT = 2;
parameter STATE_READ_DATA = 3;
parameter STATE_FINISH = 4;

reg [2:0] currentState;
reg [2:0] nextState;

// output the state
assign idle = (currentState == STATE_IDLE && !bus_req);

initial begin
	currentState <= STATE_IDLE;
	nextState <= STATE_IDLE;
end

always@(posedge clk) begin
    currentState <= nextState;
end

// Next state logic
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (pix_addr_reduced != last_addr) begin
                if (vga_output_valid) begin
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
            if(burst_count_geq)  //if we have reached the burst count signal condition,
                begin
                    nextState <= STATE_FINISH; //we are done with the page read. 
                end
            else 
                begin
                    nextState <= STATE_READ_DATA; //if we have not reached the burst count signal condition, continue reading page data,.
                end
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
            if (pix_addr_reduced != last_addr && vga_output_valid) begin
                bus_req <= 1;
            end
            else begin
                bus_req <= 0;
            end
            switch_buf <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            burst_count_en <= 0;
            burst_count_reset <= 1;
        end
        STATE_PRESENT_ADDR: begin
            bus_req <= 1;
            buf_we <= 0;
            last_addr_we <= 1;
            switch_buf <= 0;
            burst_count_en <= 0;
            burst_count_reset <= 0;
        end
        STATE_WAIT: begin
            bus_req <= 1;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
            burst_count_en <= 0;
            burst_count_reset <= 0;
        end
        STATE_READ_DATA: begin
            bus_req <= 1;
            buf_we <= 1;
            last_addr_we <= 0;
            switch_buf <= 0;
            burst_count_en <= 1;
            burst_count_reset <= 0;
        end
        STATE_FINISH: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
            burst_count_en <= 0;
            burst_count_reset <= 1;
        end
        default: begin
            bus_req <= 0;
            buf_we <= 0;
            last_addr_we <= 0;
            switch_buf <= 0;
            burst_count_en <= 0;
            burst_count_reset <= 1;
        end
    endcase
end

endmodule
