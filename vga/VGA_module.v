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

// Two pixel buffers. We can read 16 bits = two pixels from memory at a time
wire buf0_we;
wire [(COLOR_DEPTH * 2)-1:0] buf0_out;
d_reg_sync #(.WIDTH(COLOR_DEPTH * 2)) buf0(.clk(clk25MHz),
                .en(buf0_we),
                .reset(reset),
                .d(bus_in),
                .q(buf0_out));

wire buf_byte_sel; // shared between both buffers  
wire[COLOR_DEPTH-1:0] buf0_byte_out;            
mux21 #(.D_WIDTH(COLOR_DEPTH)) buf0_byte_mux(.in_a(buf0_out[7:0]),
                                       .in_b(buf0_out[15:8]),
                                       .sel(buf_byte_sel),
                                       .out(buf0_byte_out));
 
wire buf1_we; 
wire [(COLOR_DEPTH * 2)-1:0] buf1_out;
d_reg_sync #(.WIDTH(COLOR_DEPTH * 2)) buf1(.clk(clk25MHz),
                .en(buf1_we),
                .reset(reset),
                .d(bus_in),
                .q(buf1_out));
                
wire[COLOR_DEPTH-1:0] buf1_byte_out;          
mux21 #(.D_WIDTH(COLOR_DEPTH)) buf1_byte_mux(.in_a(buf1_out[7:0]),
                                       .in_b(buf1_out[15:8]),
                                       .sel(buf_byte_sel),
                                       .out(buf1_byte_out));
 
wire buf_sel; 
mux21 #(.D_WIDTH(COLOR_DEPTH)) pix_mux(.in_a(buf0_byte_out),
                                       .in_b(buf1_byte_out),
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
                .vsync(vsync),
                .row(row),
                .col(col),
                .reset(reset),
                .vga_output_valid(output_valid),
                .bus_ack(bus_ack),
                .bus_req(bus_req),
                .bus_wait(ctrl_in[0]),
                .buf_sel(buf_sel),
                .buf_byte_sel(buf_byte_sel),
                .buf0_we(buf0_we),
                .buf1_we(buf1_we),
                .bus_out(bus_out));

endmodule
