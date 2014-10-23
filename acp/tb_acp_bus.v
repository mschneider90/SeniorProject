`timescale 1ns / 1ps

module tb_acp_bus();
                        
parameter BUS_WIDTH = 32;
parameter CTRL_WIDTH = 8;

wire [BUS_WIDTH-1:0] bus;
wire [CTRL_WIDTH-1:0] ctrl;

reg clk50MHz;

wire [7:0] req;
assign req[6:0] = 0;

wire [7:0] ack;
wire [BUS_WIDTH-1:0] master_out; 
wire [CTRL_WIDTH-1:0] master_ctrl_out;                   
tb_impl_test_master master(.bus_in(bus),
                      .ack(ack[7]),
                      .clk(clk50MHz),
                      .req(req[7]),
                      .ready_in(1),
                      .writeTransfer(1),
                      .en(1),
                      .bus_out(master_out),
                      .ctrl_in(ctrl),
                      .ctrl_out(master_ctrl_out),
                      .debug_out(debug_out));
                     
wire [BUS_WIDTH-1:0] slave_out;  
wire [CTRL_WIDTH-1:0] slave_ctrl_out;     
acp		AudioCopper(
				.clk50MHz	(clk50MHz),
				.m_bus_in	(bus), 	//[31:0]
				.m_ack		(ack[4]),
				.m_ctrl_in	(ctrl), 	//[7:0]
				.m_ctrl_out (slave_ctrl_out), 	//[7:0]
				.audio_out 	(audio_out) 		//[7:0] see acp.ucf for NET list
);
// 		
                     
BusController controller(.req(req),
                         .clk(clk50MHz),
                         .ack(ack),
                         .bus_in_0(slave_out),
                         .bus_in_7(master_out),
                         .bus_out(bus),
                         .ctrl_in_0(slave_ctrl_out),
                         .ctrl_in_7(master_ctrl_out),
                         .ctrl_out(ctrl));
                                        
initial begin
    clk50MHz <= 0;
end

always begin
    #10 clk50MHz <= ~clk50MHz;
end



endmodule
