module regfile #(parameter width = 32)
              (input         clk, 
               input         reset,
               input         we3, 
               input  [4:0]  ra1, ra2, wa3, 
               input  [4:0]  debug_ra4,
               input  [width-1:0] wd3, 
               output [width-1:0] rd1, rd2, debug_rd4);

  reg [width-1:0] rf[31:0];
  
  integer i;
  //initialize all registers to 0
  initial begin
	for (i = 0; i < 32; i = i + 1) begin
		rf[i] = 0;
	end
  end

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

  always @(posedge clk)
    if (we3) rf[wa3] <= wd3;	

  //Reg 0 always has the value 0, hence the inline conditionals below
  wire [width-1:0] rd1_rf;
  wire [width-1:0] rd2_rf;
  assign rd1_rf = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2_rf = (ra2 != 0) ? rf[ra2] : 0;
  assign debug_rd4 = 0; //disable for now
  
  //Reg 31 is also "special"
  // Upon reading, it returns the value of a counter that increments every clock
  // Upon writing, it resets to 0
  wire [width-1:0] counter_out;
  parameter ADDR_R31 = 5'b11111;
  count_reg #(.D_WIDTH(width)) counter (
                     .count_load(0),
                     .en(1),
                     .load(we3 && wa3 == ADDR_R31),
                     .rst(reset),
                     .clk(clk),
                     .count(counter_out));
                     
  // Mux the RF and counter outputs
  mux2 #(.WIDTH(width)) output_mux_1(.in_a(rd1_rf),
                                     .in_b(counter_out),
                                     .mux_sel(ra1 == ADDR_R31),
                                     .mux_out(rd1));
  
  mux2 #(.WIDTH(width)) output_mux_2(.in_a(rd2_rf),
                                     .in_b(counter_out),
                                     .mux_sel(ra2 == ADDR_R31),
                                     .mux_out(rd2));  
  
endmodule
