module regfile #(parameter width = 32)
              (input         clk, 
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
  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
  assign debug_rd4 = (debug_ra4 != 0) ? rf[debug_ra4] : 0;
endmodule
