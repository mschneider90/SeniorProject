

module d_reg #(parameter WIDTH = 16)
              (input      clk, 
				   input      reset, 
					input      en,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

always @(posedge clk, posedge reset)
    if (reset) begin 
        q <= 0;
    end
    else begin
        if (en) begin
            q <= d;
        end
    end
endmodule
