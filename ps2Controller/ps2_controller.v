`timescale 1ns / 1ps

module PS2Controller #(parameter DATA_WIDTH = 8)
                       (input clk,
                        input data_in,
                        output[DATA_WIDTH-1:0] data_out,
                        output valid 
                       );
                       
wire[DATA_WIDTH-1:0] sreg_out;
wire parity_valid;
wire shift_en;
wire write_en;
wire reset;
                       
ShiftReg s_reg(.clk(clk),
               .d(data_in),
               .q(sreg_out),
               .en(shift_en),
               .reset(reset));
               
OddParityCheck p_check(.serial_in(data_in),
                       .clk(clk),
                       .reset(reset),
                       .parity_valid(parity_valid));
                       
DFlipFlop #(.DATA_WIDTH(8)) d_reg(.d_in(sreg_out[DATA_WIDTH-1:0]),
                                  .clk(clk),
                                  .write_en(write_en),
                                  .q_out(data_out));
                                  
PS2StateController control(.clk(clk),
                           .data(data_in),
                           .shift_en(shift_en),
                           .write_en(write_en),
                           .reset(reset),
                           .parity_valid(parity_valid),
                           .frame_valid(valid));
                            
endmodule
