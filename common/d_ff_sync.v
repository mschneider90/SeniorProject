// D register with synchronous reset

module d_reg_sync #(parameter WIDTH = 8)
              (input      clk, reset, en,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

always @(posedge clk)
    if (reset) begin 
        q <= 0;
    end
    else begin
        if (en) begin
            q <= d;
        end
    end
endmodule
