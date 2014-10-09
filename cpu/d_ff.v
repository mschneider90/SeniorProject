module d_reg #(parameter WIDTH = 8)
              (input      clk, reset, en,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);
               
initial begin
    q <= 0;
end

always @(posedge clk, posedge reset)
    if (reset) begin 
        q <= 0;
    end
    else begin
        if (en) begin
            q <= d;
        end
        else begin
            q <= q;
        end
    end
endmodule
