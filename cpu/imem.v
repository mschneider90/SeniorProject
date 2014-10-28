module imem #(parameter WIDTH = 32,
              parameter DEPTH = 64)
             (input  [5:0] addr_r,
              input  [5:0] addr_w,
              input  [5:0] addr_r2,
              input we,
              input clk,
              input [31:0] data_w,
              output [31:0] data_r,
              output [31:0] data_r2);

    reg  [WIDTH-1:0] RAM[DEPTH-1:0];
 
    // Read port
    assign data_r = RAM[addr_r];
    assign data_r2 = RAM[addr_r2];
  
    // Write port
    always@(posedge clk) begin
        if (we) begin
            RAM[addr_w] <= data_w;
        end
        else begin
            RAM[addr_w] <= RAM[addr_w];
        end
    end
endmodule
