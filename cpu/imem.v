module imem(input clk,
            input we,
            input  [5:0] addr,
            output [31:0] data_r,
            input [31:0] data_w);

  reg  [31:0] RAM[63:0];
  
  assign data_r = RAM[addr]; // word aligned

  always@(posedge clk) begin
    if (we) begin
        RAM[addr] <= data_w;
    end
    else begin
        RAM[addr] <= RAM[addr];
    end
  end
  
  
endmodule
