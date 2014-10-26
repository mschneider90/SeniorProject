`timescale 1ns / 1ps

module PS2Interface #(parameter DATA_WIDTH = 8)
                     (input clk_ps2,
                      input data_in,
                      output[DATA_WIDTH-1:0] data_out,
                      output valid 
                     );
                       
wire[DATA_WIDTH-1:0] sreg_out;
wire parity_valid;
wire shift_en;
wire write_en;
wire reset;
                       
ShiftReg s_reg(.clk(clk_ps2),
               .d(data_in),
               .q(sreg_out),
               .en(shift_en),
               .reset(reset));
               
OddParityCheck p_check(.serial_in(data_in),
                       .clk(clk_ps2),
                       .reset(reset),
                       .parity_valid(parity_valid));
                       
d_reg #(.WIDTH(8)) d_reg(.d(sreg_out[DATA_WIDTH-1:0]),
                         .reset(data_out_reset),
                         .clk(clk_ps2),
                         .en(write_en),
                         .q(data_out));
                                  
PS2InterfaceStateController control(.clk(clk_ps2),
                                    .data(data_in),
                                    .shift_en(shift_en),
                                    .write_en(write_en),
                                    .reset(reset),
                                    .data_out_reset(data_out_reset),
                                    .parity_valid(parity_valid),
                                    .frame_valid(valid));
                            
endmodule
