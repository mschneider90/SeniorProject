`timescale 1ns/100ps 

module VGA_module #(parameter COLOR_DEPTH = 8,
                    BUS_WIDTH = 32,
                    CTRL_WIDTH = 8)
                   (output[COLOR_DEPTH-1:0] rgb,
                    output vsync,
                    output hsync,
                    input clk25MHz,
                    input reset,
                    input bus_master_ack,
                    input bus_slave_en,
                    input[BUS_WIDTH-1:0] bus_in,
                    input[CTRL_WIDTH-1:0] ctrl_in,
                    output bus_req,
                    output[CTRL_WIDTH-1:0] ctrl_out,
                    output[BUS_WIDTH-1:0] bus_out);
                    
assign ctrl_out = 8'b00010000; // burst length 16 and read

wire output_valid;
wire [COLOR_DEPTH-1:0] pixel;

wire [10:0] row;
wire [10:0] col;

// Two pixel buffers. We can read 16 bits = two pixels from memory at a time
wire buf0_we;
wire [15:0] buf0_out;
wire [3:0] buffer_write_addr; //16 words
wire [3:0] buffer_read_addr; //16 words

pixelbuff #(.WIDTH((COLOR_DEPTH * 2))) buffer0( //16 wide by 8 deep pixel buffer. 
              .data_in(bus_in[15:0]),
              .clk(clk25MHz),
              .we(buf0_we),
              .write_address(buffer_write_addr[3:0]),
              .read_address(buffer_read_addr[3:0]),
              .data_out(buf0_out)
              );

/*
d_reg_sync #(.WIDTH(COLOR_DEPTH * 2)) buf0(.clk(clk25MHz),
                .en(buf0_we),
                .reset(reset),
                .d(bus_in),
                .q(buf0_out));
*/ 


wire buf_byte_sel; // shared between both buffers  
wire[COLOR_DEPTH-1:0] buf0_byte_out;            
mux21 #(.D_WIDTH(COLOR_DEPTH)) buf0_byte_mux(.in_a(buf0_out[7:0]),
                                       .in_b(buf0_out[15:8]),
                                       .sel(buf_byte_sel),
                                       .out(buf0_byte_out));
 
wire buf1_we; 
wire [15:0] buf1_out;
pixelbuff #(.WIDTH((COLOR_DEPTH * 2))) buffer1( //16 wide by 8 deep pixel buffer. 
              .data_in(bus_in[15:0]),
              .clk(clk25MHz), 
              .we(buf1_we),
              .write_address(buffer_write_addr[3:0]),
              .read_address(buffer_read_addr[3:0]),
              .data_out(buf1_out)
              );
/*
d_reg_sync #(.WIDTH(COLOR_DEPTH * 2)) buf1(.clk(clk25MHz),
                .en(buf1_we),
                .reset(reset),
                .d(bus_in),
                .q(buf1_out));
 */               
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
					
wire [31:0] framebuffer_addr;
wire slave_data_we;
wire master_idle;
                            
VGABusInterface bus_if(.clk(clk25MHz), // master state machine
                .row(row),
                .col(col),
                .reset(reset),
                .vga_output_valid(output_valid),
					 .base_addr(framebuffer_addr),
                .bus_ack(bus_master_ack),
                .bus_req(bus_req),
                .bus_wait(ctrl_in[0]),
                .buf_sel(buf_sel),
                .buf_byte_sel(buf_byte_sel),
                .buf0_we(buf0_we),
                .buf1_we(buf1_we),
                .buf_read_addr(buffer_read_addr[3:0]),
                .buf_write_addr(buffer_write_addr[3:0]),
                .bus_out(bus_out),
				.idle(master_idle));
					 
//vga framebuffer select register
d_reg #(.WIDTH(32)) vga_reg0(
	.clk		(clk25MHz),
	.reset	(reset),
	.en		(slave_data_we),
	.d 		(bus_in),
	.q			(framebuffer_addr)
);

vga_slave_interface vga_slave_busint( // slave state machine
		.bus_in		(bus_in),
		.ack			(bus_slave_en),
		.clk			(clk25MHz),
		.ctrl_in    (ctrl_in),
		.data_we		(slave_data_we)
);



endmodule
