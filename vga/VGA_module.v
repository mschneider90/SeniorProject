`timescale 1ns/100ps 

module VGA_module #(parameter COLOR_DEPTH = 8,
                    BUS_WIDTH = 32,
                    CTRL_WIDTH = 8)
                   (output[COLOR_DEPTH-1:0] rgb,
                    output vsync,
                    output hsync,
                    input clk25MHz,
                    input reset,
                    input bus_ack,
                    input[BUS_WIDTH-1:0] bus_in,
                    input[CTRL_WIDTH-1:0] ctrl_in,
                    output bus_req,
                    output[CTRL_WIDTH-1:0] ctrl_out,
                    output[BUS_WIDTH-1:0] bus_out);
                    
assign ctrl_out = 0; // burst length 1 and read

wire output_valid;
wire [COLOR_DEPTH-1:0] pixel;

wire [10:0] row;
wire [10:0] col;

wire buf0_we;
wire [COLOR_DEPTH-1:0] buf0_out;
d_reg_sync #(.WIDTH(COLOR_DEPTH)) buf0(.clk(clk25MHz),
                .en(buf0_we),
                .reset(reset),
                .d(bus_in),
                .q(buf0_out));
 
wire buf1_we; 
wire [COLOR_DEPTH-1:0] buf1_out;
d_reg_sync #(.WIDTH(COLOR_DEPTH)) buf1(.clk(clk25MHz),
                .en(buf1_we),
                .reset(reset),
                .d(bus_in),
                .q(buf1_out));
 
wire buf_sel; 
mux21 #(.D_WIDTH(COLOR_DEPTH)) pix_mux(.in_a(buf0_out),
                                       .in_b(buf1_out),
                                       .sel(buf_sel),
                                       .out(pixel));

sync_gen sgen(.clk25MHz(clk25MHz),
              .vsync_L(vsync),
              .hsync_L(hsync),
              .output_valid(output_valid),
              .rst(reset),
              .col(col),
              .row(row));
              
color_gen cgen(.pixel(pixel),
               .rgb(rgb),
               .output_valid(output_valid));
                            
VGABusInterface bus_if(.clk(clk25MHz),
                .row(row),
                .col(col),
                .reset(reset),
                .vga_output_valid(output_valid),
                .bus_ack(bus_ack),
                .bus_req(bus_req),
                .bus_wait(ctrl_in[0]),
                .buf_sel(buf_sel),
                .buf0_we(buf0_we),
                .buf1_we(buf1_we),
                .bus_out(bus_out));

endmodule
