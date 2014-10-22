`timescale 1ns / 1ps

module uartInterface #(parameter BUS_WIDTH = 32,
                       parameter CTRL_WIDTH = 8)
                      (input clk50MHz,
                       input[BUS_WIDTH-1:0] bus_in,
                       input[CTRL_WIDTH-1:0] ctrl_in,
                       output reg bus_req,
                       input bus_ack,
                       output[BUS_WIDTH-1:0] bus_out,
                       output[CTRL_WIDTH-1:0] ctrl_out,
                       input rx,
                       output tx);
                       
wire bus_wait_in;
assign bus_wait_in = ctrl_in[0];
                       
reg we;
assign ctrl_out = {3'b000,
                   3'b000, //burst length = 1
                   we,
                   1'b0 };
            
reg byte_count_en;
reg byte_count_rst;
wire[2:0] byteCount;            
count_reg #(.D_WIDTH(3)) byteCounter   (.en(byte_count_en),
                                        .rst(byte_count_rst),
                                        .clk(clk50MHz),
                                        .count(byteCount));
                               
wire [BUS_WIDTH-1:0] bus_data; 
reg busData_we;
reg busData_rst;                              
d_reg #(.D_WIDTH(BUS_WIDTH)) busDataReg (.clk(clk50MHz),
                                         .en(busData_we),
                                         .reset(busData_rst),
                                         .d(bus_in),
                                         .q(bus_data));
       
wire data_rx_valid;
wire [7:0] data_rx;   
wire busy;    
reg data_tx_valid;
wire [7:0] data_tx;
uart uartModule(.clk50MHz(clk50MHz),
                .rx(rx),
                .tx(tx),
                .data_out_valid(data_rx_valid),
                .data_in_valid(data_tx_valid),
                .data_out(data_rx),
                .data_in(data_tx),
                .busy(busy));
                
mux_4to1 #(.width(8)) tx_mux (.in_A(bus_data[7:0]),
                       .in_B(bus_data[15:8]),
                       .in_C(bus_data[23:16]),
                       .in_D(bus_data[31:24]),
                       .mux_sel(byteCount[1:0]),
                       .out(data_tx));
                       
// Address registers
wire [BUS_WIDTH-1:0] addr;
reg [3:0] addr_we;
reg addr_rst;
d_reg #(.WIDTH(8)) addr_0(.clk(clk50MHz),
                          .en(addr_we[0]),
                          .reset(addr_rst),
                          .d(data_rx),
                          .q(addr[7:0]));

d_reg #(.WIDTH(8)) addr_1(.clk(clk50MHz),
                          .en(addr_we[1]),
                          .reset(addr_rst),
                          .d(data_rx),
                          .q(addr[15:8]));
                          
d_reg #(.WIDTH(8)) addr_2(.clk(clk50MHz),
                          .en(addr_we[2]),
                          .reset(addr_rst),
                          .d(data_rx),
                          .q(addr[23:16]));
                          
d_reg #(.WIDTH(8)) addr_3(.clk(clk50MHz),
                          .en(addr_we[3]),
                          .reset(addr_rst),
                          .d(data_rx),
                          .q(addr[31:24]));
                      
// Data registers
wire [BUS_WIDTH-1:0] data;
reg[3:0] data_we;
reg data_rst;
d_reg #(.WIDTH(8)) data_0(.clk(clk50MHz),
                          .en(data_we[0]),
                          .reset(data_rst),
                          .d(data_rx),
                          .q(data[7:0]));

d_reg #(.WIDTH(8)) data_1(.clk(clk50MHz),
                          .en(data_we[1]),
                          .reset(data_rst),
                          .d(data_rx),
                          .q(data[15:8]));
                          
d_reg #(.WIDTH(8)) data_2(.clk(clk50MHz),
                          .en(data_we[2]),
                          .reset(data_rst),
                          .d(data_rx),
                          .q(data[23:16]));
                          
d_reg #(.WIDTH(8)) data_3(.clk(clk50MHz),
                          .en(data_we[3]),
                          .reset(data_rst),
                          .d(data_rx),
                          .q(data[31:24]));
     
// Mux bus output     
reg bus_out_addr;
assign bus_out = (bus_out_addr)? addr : data;
                
parameter STATE_IDLE = 0;
parameter STATE_UART_RX_ADDR = 1;
parameter STATE_UART_RX_WRITE_DATA = 2;
parameter STATE_BUS_REQ = 3;
parameter STATE_BUS_PRESENT_ADDR = 4;
parameter STATE_BUS_WAIT = 5;
parameter STATE_BUS_WRITE_DATA = 6;
parameter STATE_BUS_READ_DATA = 7;
parameter STATE_BUS_FINISH = 8;
parameter STATE_UART_TX_DATA = 9;

// UART protocol constants
// Must match values in MooseBox Serial Communicator code
parameter READ_COMMAND = 8'h55;
parameter WRITE_COMMAND = 8'h56;

reg [3:0] currentState;
reg [3:0] nextState;

initial begin
    currentState <= STATE_IDLE;
    nextState <= STATE_IDLE;
end

always@(posedge clk50MHz) begin
    currentState <= nextState;
end
    
always@(*) begin
    case (currentState)
        STATE_IDLE: begin
            if (data_rx_valid) begin
                if (data_rx == READ_COMMAND || data_rx == WRITE_COMMAND) begin
                    nextState <= STATE_UART_RX_ADDR;
                end
                else begin
                    nextState <= STATE_IDLE;
                end
            end
            else begin
                nextState <= STATE_IDLE;
            end
        end
        STATE_UART_RX_ADDR: begin
            //Wait for four bytes to be received, proceed to STATE_BUS_REQ
            if (byteCount == 4) begin
                if (we) begin
                    nextState <= STATE_UART_RX_WRITE_DATA;
                end
                else begin
                    nextState <= STATE_BUS_REQ;
                end
            end
            else begin
                nextState <= STATE_UART_RX_ADDR;
            end
        end
        STATE_UART_RX_WRITE_DATA: begin
            //Wait for four bytes to be received, proceed to STATE_BUS_REQ
            if (byteCount == 4) begin
                nextState <= STATE_BUS_REQ;
            end
            else begin
                nextState <= STATE_UART_RX_WRITE_DATA;
            end
        end
        STATE_BUS_REQ: begin
            if (bus_ack) begin
                nextState <= STATE_BUS_PRESENT_ADDR;
            end
            else begin
                nextState <= STATE_BUS_REQ;
            end
        end
        STATE_BUS_PRESENT_ADDR: begin
            nextState <= STATE_BUS_WAIT;
        end
        STATE_BUS_WAIT: begin
            if (bus_wait_in) begin
                nextState <= STATE_BUS_WAIT;
            end
            else begin
                if (we) begin
                    nextState <= STATE_BUS_WRITE_DATA;
                end
                else begin
                    nextState <= STATE_BUS_READ_DATA;
                end
            end
        end
        STATE_BUS_WRITE_DATA: begin
            nextState <= STATE_BUS_FINISH;
        end
        STATE_BUS_READ_DATA: begin
            nextState <= STATE_BUS_FINISH;
        end
        STATE_BUS_FINISH: begin
            if (we) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_UART_TX_DATA;
            end
        end
        STATE_UART_TX_DATA: begin
            if (byteCount == 4) begin
                nextState <= STATE_IDLE;
            end
            else begin
                nextState <= STATE_UART_TX_DATA;
            end
        end
        default: begin
            nextState <= STATE_IDLE;
        end
    endcase
end         

always@(*) begin
    case (currentState) 
        STATE_IDLE: begin
            data_we <= 4'b0;
            data_rst <= 1;
            addr_we <= 4'b0;
            addr_rst <= 1;
            byte_count_en <= 0;
            byte_count_rst <= 1;
            bus_out_addr <= 0;
            bus_req <= 0;
            data_tx_valid <= 0;
            if (data_rx == WRITE_COMMAND) begin
                we <= 1;
            end
            else begin
                we <= 0;
            end
            busData_rst <= 1;
            busData_we <= 0;
        end
        STATE_UART_RX_ADDR: begin
            data_we <= 4'b0;
            data_rst <= 0;
            if (data_rx_valid) begin
                byte_count_en <= 1;
                case (byteCount) 
                    3'b000: addr_we <= 4'b0001;
                    3'b001: addr_we <= 4'b0010;
                    3'b010: addr_we <= 4'b0100;
                    3'b011: addr_we <= 4'b1000;
                    default: addr_we <= 4'b0000;
                endcase
            end
            else begin
                byte_count_en <= 0;
                addr_we <= 4'b0;
            end
            addr_rst <= 0;
            if (byteCount == 4) begin
                byte_count_rst <= 1;
            end
            else begin
                byte_count_rst <= 0;
            end
            bus_out_addr <= 0;
            bus_req <= 0;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        STATE_UART_RX_WRITE_DATA: begin
            if (data_rx_valid) begin
                byte_count_en <= 1;
                case (byteCount) 
                    3'b000: data_we <= 4'b0001;
                    3'b001: data_we <= 4'b0010;
                    3'b010: data_we <= 4'b0100;
                    3'b011: data_we <= 4'b1000;
                    default: data_we <= 4'b0000;
                endcase
            end
            else begin
                byte_count_en <= 0;
                data_we <= 4'b0;
            end
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            if (byteCount == 4) begin
                byte_count_rst <= 1;
            end
            else begin
                byte_count_rst <= 0;
            end
            bus_out_addr <= 0;
            bus_req <= 0;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        STATE_BUS_REQ: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 1;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        STATE_BUS_PRESENT_ADDR: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 1;
            bus_req <= 1;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        STATE_BUS_WAIT: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 1;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        STATE_BUS_WRITE_DATA: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_req <= 1;
            data_tx_valid <= 0;
            busData_we <= 0;
            busData_rst <= 0;
        end 
        STATE_BUS_READ_DATA: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 1;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 1;
            busData_rst <= 0;
        end
        STATE_BUS_FINISH: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 0;
            data_tx_valid <= 0;
            we <= we;
        end
        STATE_UART_TX_DATA: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 0;
            if (!busy) begin
                byte_count_en <= 1;
                data_tx_valid <= 1;
            end
            else begin
                byte_count_en <= 0;
                data_tx_valid <= 0;
            end
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
        default: begin
            data_we <= 4'b0;
            data_rst <= 0;
            addr_we <= 4'b0;
            addr_rst <= 0;
            byte_count_en <= 0;
            byte_count_rst <= 0;
            bus_out_addr <= 0;
            bus_req <= 0;
            data_tx_valid <= 0;
            we <= we;
            busData_we <= 0;
            busData_rst <= 0;
        end
    endcase
end       
endmodule
