module sl2(input  [31:0] in,
           output [31:0] out_shifted);

  // shift left by 2
  assign y = {a[29:0], 2'b00};
endmodule
