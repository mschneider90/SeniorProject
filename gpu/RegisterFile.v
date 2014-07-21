`timescale 1ns / 1ps

module RegisterFile #(parameter D_WIDTH = 16,
                      parameter A_WIDTH = 4,
							 parameter RF_DEPTH = 4)
							(input[D_WIDTH-1:0]  write_data,
							 input[A_WIDTH-1:0]  read_addr,
							 input[A_WIDTH-1:0]  write_addr,
							 input               write_enable
							 input               clk
							 output[D_WIDTH-1:0] read_data);
							 					 
reg[D_WIDTH-1:0] data_in;	
reg[D_WIDTH-1:0] data_out;									 
reg[D_WIDTH-1:0] reg_file[RF_DEPTH-1:0];

assign read_data = reg_file[read_addr];
assign reg_file[write_addr] = data_in;

always@(posedge clk) begin
	if (write_enable)
		data_in <= write_data;
	
	data_out <= reg_file[read_addr];
end

endmodule
