module imem(input  [5:0] addr,
            output [31:0] data_r);

  reg  [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile.dat",RAM);
    end

  assign data_r = RAM[addr]; // word aligned
endmodule
