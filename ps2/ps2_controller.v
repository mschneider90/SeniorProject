`timescale 1ns / 1ps

module PS2Controller #(parameter DATA_WIDTH = 8,
                       BUS_WIDTH = 32,
                       CTRL_WIDTH = 8)
                    (input ps2_data_in,
                     input clk_ps2,
                     input clk,
                     input[BUS_WIDTH-1:0] bus_in,
                     input ack,
                     input[CTRL_WIDTH-1:0] bus_ctrl_in,
                     output[BUS_WIDTH-1:0] bus_out,
                     output[CTRL_WIDTH-1:0] ctrl_out);
                       
wire interface_valid;

wire [DATA_WIDTH-1:0] interface_out;
wire [DATA_WIDTH-1:0] sync_reg_out;
wire [DATA_WIDTH-1:0] ps2_data;

reg reset;

PS2Interface ps2_if(.clk_ps2(clk_ps2),
                    .data_in(ps2_data_in),
                    .data_out(interface_out),
                    .valid(interface_valid));
                    
//Use the "double flopping" technique to deal with the synchronization issues
//caused by multiple clock domains
//See: http://www.engr.sjsu.edu/nlashkarian/AFPGA/Crossing_Clock_Domains.pdf
d_reg_sync #(.WIDTH(DATA_WIDTH)) reg_sync(.d(interface_out),
                            .en(1),
                            .reset(reset),
                            .clk(clk),
                            .q(sync_reg_out));

reg ps2_data_we;
d_reg_sync #(.WIDTH(DATA_WIDTH)) reg_out(.d(sync_reg_out),
                           .en(ps2_data_we),
                           .reset(reset),
                           .clk(clk),
                           .q(ps2_data));
                           
reg last_data_we;
wire [DATA_WIDTH-1:0] last_data;
d_reg_sync #(.WIDTH(DATA_WIDTH)) last_data_reg(.d(ps2_data), //Prevents "double dipping" from one PS/2 frame
                           .en(last_data_we),
                           .reset(reset),
                           .clk(clk),
                           .q(last_data));                                     
												
reg bus_wait_out;
assign ctrl_out[0] = bus_wait_out;

// PS/2 Scan Codes
// Break code shared by all of the following keys
parameter PS2_BREAK = 8'hF0;

// Player 1: E W A S D
parameter PS2_E = 8'h24;
parameter PS2_W = 8'h1D;
parameter PS2_A = 8'h1C;
parameter PS2_S = 8'h1B;
parameter PS2_D = 8'h23;

// Player 2: 7 8 4 5 6 (_KEYPAD_)
parameter PS2_KP7 = 8'h6C;
parameter PS2_KP8 = 8'h75;
parameter PS2_KP4 = 8'h6B;
parameter PS2_KP5 = 8'h73;
parameter PS2_KP6 = 8'h74;

wire break_key; //Toggles based on whether or not we've received a BREAK code
reg break_rst;
reg break_we;
d_reg_sync #(.WIDTH(1)) breakKeyReg(.d(1),
                               .en(break_we),
                               .reset(break_rst),
                               .clk(clk),
                               .q(break_key));
wire break_key_L;
assign break_key_L = ~break_key; //For the key registers. Set if break_key is low, reset if it's high

reg key_rst;

wire e_we;
wire e_pressed;
d_reg_sync #(.WIDTH(1)) key_e(.d(break_key_L),
                         .en(e_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(e_pressed));

wire w_we;                         
wire w_pressed;
d_reg_sync #(.WIDTH(1)) key_w(.d(break_key_L),
                         .en(w_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(w_pressed));

wire a_we;                         
wire a_pressed;
d_reg_sync #(.WIDTH(1)) key_a(.d(break_key_L),
                         .en(a_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(a_pressed));
wire s_we;                        
wire s_pressed;
d_reg_sync #(.WIDTH(1)) key_s(.d(break_key_L),
                         .en(s_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(s_pressed));
                        
wire d_we;                        
wire d_pressed;
d_reg_sync #(.WIDTH(1)) key_d(.d(break_key_L),
                         .en(d_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(d_pressed));

wire kp7_we;
wire kp7_pressed;
d_reg_sync #(.WIDTH(1)) key_kp7(.d(break_key_L),
                         .en(kp7_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(kp7_pressed));

wire kp8_we;
wire kp8_pressed;
d_reg_sync #(.WIDTH(1)) key_kp8(.d(break_key_L),
                         .en(kp8_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(kp8_pressed));

wire kp4_we;
wire kp4_pressed;
d_reg_sync #(.WIDTH(1)) key_kp4(.d(break_key_L),
                         .en(kp4_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(kp4_pressed));

wire kp5_we;
wire kp5_pressed;
d_reg_sync #(.WIDTH(1)) key_kp5(.d(break_key_L),
                         .en(kp5_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(kp5_pressed));

wire kp6_we;
wire kp6_pressed;
d_reg_sync #(.WIDTH(1)) key_kp6(.d(break_key_L),
                         .en(kp6_we),
                         .reset(key_rst),
                         .clk(clk),
                         .q(kp6_pressed));
 
reg key_dec_en; 
KeyDecoder key_dec (.key_code(ps2_data),
                    .en(key_dec_en),
                    .e_we(e_we),
                    .w_we(w_we),
                    .a_we(a_we),
                    .s_we(s_we),
                    .d_we(d_we),
                    .kp7_we(kp7_we),
                    .kp8_we(kp8_we),
                    .kp4_we(kp4_we),
                    .kp5_we(kp5_we),
                    .kp6_we(kp6_we));

// Read mux for bus interface
wire [3:0] addr;             
mux10to1 read_mux(.in_0(e_pressed),
                  .in_1(w_pressed),
                  .in_2(a_pressed),
                  .in_3(s_pressed),
                  .in_4(d_pressed),
                  .in_5(kp7_we),
                  .in_6(kp8_we),
                  .in_7(kp4_we),
                  .in_8(kp5_we),
                  .in_9(kp6_we),
                  .sel(addr),
                  .mux_out(bus_out));
                  
// Stores address from bus
reg addr_we;
d_reg_sync #(.WIDTH(4)) addr_reg(.d(bus_in[3:0]),
                         .en(addr_we),
                         .reset(reset),
                         .clk(clk),
                         .q(addr));
                  
// PS/2 side of the interface                  
parameter STATE_RESET = 0;
parameter STATE_IDLE = 1;
parameter STATE_PS2_SYNC = 2;
parameter STATE_PS2_DATA = 3;
parameter STATE_PS2_PROCESSKEY = 4;

reg [2:0] currentState;
reg [2:0] nextState;

// Bus side of the interface
parameter STATE_WAIT_FOR_ACK = 0;
parameter STATE_READ_WAIT = 1;
parameter STATE_READ_DATA = 2;
parameter STATE_FINISH = 3;
                                    
reg [1:0] currentBusState;
reg [1:0] nextBusState;

initial begin
	currentState <= STATE_RESET;
	nextState <= STATE_RESET;
    
    currentBusState <= STATE_WAIT_FOR_ACK;
    nextBusState <= STATE_WAIT_FOR_ACK;
end

always@(posedge clk) begin
	currentState <= nextState;
    currentBusState <= nextBusState;
end
 
// PS/2 Interface next state logic
always@(*) begin
	case (currentState)
        STATE_RESET: begin
            nextState <= STATE_IDLE;
        end
		STATE_IDLE: begin
			if (interface_valid) begin
                nextState <= STATE_PS2_SYNC;
			end
			else begin
				nextState <= STATE_IDLE;
            end
		end
		STATE_PS2_SYNC: begin
			nextState <= STATE_PS2_DATA;
		end
		STATE_PS2_DATA: begin
			if (ps2_data == last_data) begin
				nextState <= STATE_IDLE;
			end
			else begin
                if (ps2_data == PS2_BREAK) begin
                    nextState <= STATE_IDLE;
                end
                else begin
                    nextState <= STATE_PS2_PROCESSKEY;
                end
			end
		end
		STATE_PS2_PROCESSKEY: begin
			nextState <= STATE_IDLE;
		end
        default: begin
            nextState <= STATE_RESET;
        end
	endcase
end

// PS/2 Interface control signals
always@(*) begin
	case (currentState) 
        STATE_RESET: begin
            reset <= 1;
            ps2_data_we <= 0;
            break_rst <= 1;
            break_we <= 0;
            key_dec_en <= 0;
            key_rst <= 1;
            last_data_we <= 0;
        end
		STATE_IDLE: begin
            reset <= 0;
			ps2_data_we <= 0;
            break_rst <= 0;
            break_we <= 0;
            key_dec_en <= 0;
            key_rst <= 0;
            last_data_we <= 0;
		end
		STATE_PS2_SYNC: begin
            reset <= 0;
			ps2_data_we <= 1;
            break_rst <= 0;
            break_we <= 0;
            key_dec_en <= 0;
            key_rst <= 0;
            last_data_we <= 0;
		end
		STATE_PS2_DATA: begin
            reset <= 0;
			ps2_data_we <= 0;
            break_rst <= 0;
            if (ps2_data == PS2_BREAK) begin
                break_we <= 1;
            end
            else begin
                break_we <= 0;
            end
            key_dec_en <= 0;
            key_rst <= 0;
            last_data_we <= 1;
		end
		STATE_PS2_PROCESSKEY: begin
            reset <= 0;
			ps2_data_we <= 0;
            break_rst <= 1;
            break_we <= 0;
            key_dec_en <= 1;
            key_rst <= 0;
            last_data_we <= 0;
		end
        default: begin
            reset <= 0;
			ps2_data_we <= 0;
            break_rst <= 0;
            break_we <= 0;
            key_dec_en <= 0;
            key_rst <= 0;
            last_data_we <= 0;
        end
	endcase
end

// Bus interface next state logic
always@(*) begin
    case (currentBusState) 
        STATE_WAIT_FOR_ACK: begin
            if (ack) begin
                nextState <= STATE_READ_WAIT;
            end
            else begin
                nextState <= STATE_WAIT_FOR_ACK;
        end
        STATE_READ_WAIT: begin
            nextState <= STATE_READ_DATA;
        end
        STATE_READ_DATA: begin
            nextState <= STATE_FINISH;
        end
        STATE_FINISH: begin
            nextState <= STATE_WAIT_FOR_ACK;
        end
    endcase
end

// Bus interface control signals
always@(*) begin
    case (currentBusState) begin
        STATE_WAIT_FOR_ACK: begin
            addr_we <= 1;
        end
        STATE_READ_WAIT: begin
            addr_we <= 0;
        end
        STATE_READ_DATA: begin
            addr_we <= 0;
        end
        STATE_FINISH: begin
            addr_we <= 0;
        end
    endcase
end

endmodule
