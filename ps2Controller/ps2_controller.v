`timescale 1ns / 1ps

module PS2Controller #(DATA_WIDTH = 8)
                    (input data_in,
                     input clk_ps2,
                     input clk_50MHz,
                     input int_ack,
                     output int_req,
                     output [DATA_WIDTH-1:0] data_out);
                     
parameter SCANCODE_BREAK = 8'hF0;
parameter SCANCODE_MAKE  = 8'hE0;
                     
wire [DATA_WIDTH-1:0] interface_out;
wire interface_valid;

wire r0_we;
wire r1_we;
wire r2_we;

wire [DATA_WIDTH-1:0] r0_out;
wire [DATA_WIDTH-1:0] r1_out;
wire [DATA_WIDTH-1:0] r2_out;

wire [1:0] output_mux_sel;
wire [DATA_WIDTH-1:0] output_mux_out;

wire output_en;

//~~~~~~~~ PS2 scan codes can have one to three scancodes ~~~~~~~~
//"Make" (press) scancodes:
//One code (regular key): <code>
//Two codes (extended key) <E0> <code>
assign is_two_scancode_make = r1_out & SCANCODE_MAKE;

//"Break" (release) scancodes:
//Two codes (regular key): <F0> <code>
//Three codes (extended key): <F0> <E0> <code>
wire is_two_scancode_break;
wire is_three_scancode_break;

//Break codes
assign is_three_scancode_break = r2_out & SCANCODE_BREAK;
assign is_two_scancode_break =   r1_out & SCANCODE_BREAK;



                     
PS2Interface ps2_if(.clk_ps2(clk_ps2),
                    .data_in(data_in),
                    .data_out(interface_out),
                    .valid(interface_valid));

DFlipFlop #(.DATA_WIDTH(8)) reg_0(.d_in(interface_out),
                                  .write_en(r0_we),
                                  .clk(clk_50MHz),
                                  .q_out(r0_out));
                                  
DFlipFlop #(.DATA_WIDTH(8)) reg_1(.d_in(interface_out),
                                  .write_en(r1_we),
                                  .clk(clk_50MHz),
                                  .q_out(r1_out));

DFlipFlop #(.DATA_WIDTH(8)) reg_2(.d_in(interface_out),
                                  .write_en(r2_we),
                                  .clk(clk_50MHz),
                                  .q_out(r2_out));
                                  
mux4to1 #(.DATA_WIDTH(8)) output_mux(.in_a(r0_out),
                                     .in_b(r1_out),
                                     .in_c(r2_out),
                                     .in_d(8'h55), //unused
                                     .mux_sel(output_mux_sel),
                                     .mux_out(output_mux_out));
                                     
TriBuffer #(.DATA_WIDTH(8)) out_buf(.buf_in(output_mux_out),
                                    .output_en(output_en), 
                                    .buf_out(data_out));
 

endmodule
