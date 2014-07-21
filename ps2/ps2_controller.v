`timescale 1ns / 1ps

module PS2Controller #(DATA_WIDTH = 8)
                    (input data_in,
                     input clk_ps2,
                     input clk_50MHz,
                     input int_ack,
                     output int_req,
                     output [DATA_WIDTH-1:0] data_out);
                     
parameter WRITE_ENABLE = 1;
                     
wire interface_valid;

wire [DATA_WIDTH-1:0] interface_out;
wire [DATA_WIDTH-1:0] reg_out_out;
wire [DATA_WIDTH-1:0] reg_sync_out;

wire output_en;

PS2StateController ps2_ctrl(.clk(clk_50MHz),
                            .interface_valid(interface_valid),
                            .output_enable(output_en)
                           );

PS2Interface ps2_if(.clk_ps2(clk_ps2),
                    .data_in(data_in),
                    .data_out(interface_out),
                    .valid(interface_valid));
                    
//Use the "double flopping" technique to deal with the synchronization issues
//caused by multiple clock domains
//See: http://www.engr.sjsu.edu/nlashkarian/AFPGA/Crossing_Clock_Domains.pdf
DFlipFlop #(.DATA_WIDTH(8)) reg_sync(.d_in(interface_out),
                                     .write_en(WRITE_ENABLE),
                                     .clk(clk_50MHz),
                                     .q_out(sync_reg_out));

DFlipFlop #(.DATA_WIDTH(8)) reg_out(.d_in(sync_reg_out),
                                    .write_en(WRITE_ENABLE),
                                    .clk(clk_50MHz),
                                    .q_out(reg_out_out));
                                     
TriBuffer #(.DATA_WIDTH(8)) out_buf(.buf_in(output_mux_out),
                                    .output_en(output_en), 
                                    .buf_out(data_out));
 

endmodule
