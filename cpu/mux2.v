
module mux2 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] in_a, in_b, 
              input              mux_sel, 
              output [WIDTH-1:0] mux_out);

  assign mux_out = mux_sel ? in_b : in_a; 
endmodule
