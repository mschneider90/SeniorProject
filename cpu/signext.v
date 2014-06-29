module signext(input  [15:0] in,
               output [31:0] out_ext);
              
  assign out_ext = {{16{in[15]}}, in};
endmodule