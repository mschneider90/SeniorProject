// RAM with a synchronous read
// The read is synchronous so we can infer a block RAM
// The read clock can be twice as fast as the write clock so we can read in a single cycle
// See Xilinx XST guide, pg 197

module imem #(parameter D_WIDTH = 32,
              parameter A_WIDTH = 12)
           (input clk100MHz,
            input clk_write,
            input we,
            input  [A_WIDTH-1:0] addr,
            output [D_WIDTH-1:0] data_r,
            input [D_WIDTH-1:0] data_w);

  parameter RAM_DEPTH = 4096;
  reg [D_WIDTH-1:0] RAM[RAM_DEPTH-1:0];
  
  always@(posedge clk_write) begin
    if (we) begin
        RAM[addr] <= data_w;
    end
  end
  
  reg [A_WIDTH-1:0] read_addr;
  always@(posedge clk100MHz) begin
    read_addr <= addr;
  end
  
  assign data_r = RAM[read_addr];
  
endmodule
