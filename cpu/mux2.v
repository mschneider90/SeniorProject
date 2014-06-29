
module mux2 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] in_a, in_b, 
              input              mux_sel, 
              output [WIDTH-1:0] mux_out);

  assign y = s ? d1 : d0; 
endmodule
