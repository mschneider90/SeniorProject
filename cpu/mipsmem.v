//------------------------------------------------
// mipsmemsingle.v
// David_Harris@hmc.edu 23 October 2005
// External memories used by MIPS single-cycle
// processor
//------------------------------------------------

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

module imem(input  [5:0] addr,
            output [31:0] data_r);

  reg  [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile.dat",RAM);
    end

  assign data_r = RAM[addr]; // word aligned
endmodule

// imem must currently be created with CoreGen for Xilinx synthesis
// or loaded from imem.v for simulation