module dmem(input         clk, we,
            input  [31:0] addr, data_w,
            output [31:0] data_r);

  reg  [31:0] RAM[63:0];
  wire [7:0] addr;

  assign addr = addr[7:2];
  assign data_r = RAM[addr]; // word aligned
 
  always @(posedge clk)
    if (we)
      RAM[addr] <= data_w;
endmodule
