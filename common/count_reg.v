`timescale 1ns / 1ps

module count_reg #(parameter D_WIDTH = 8)
                  (input[D_WIDTH-1:0] count_load,
                   input en,
                   input load,
                   input rst,
                   input clk,
                   output reg[D_WIDTH-1:0] count);
                        
always@(posedge clk) begin
    if (rst) begin
        count <= 0;
    end
    else begin
        if (en) begin
            if (load) begin
                count <= count_load;
            end
            else begin
                count <= count + 1;
            end
         end
    end
end


endmodule

module count_regp #(parameter D_WIDTH = 8)
                  (input[D_WIDTH-1:0] count_load,
                   input en,
                   input load,
                   input rst,
                   input clk,
                   output reg[D_WIDTH-1:0] count);
                        
always@(posedge clk) begin
    if (rst) begin
        count <= 0;
    end
    else begin
        if (en) //if enable signal is high, then the counter counts. 
        begin
                count <= count + 1;
        end
        if (load) 
        begin
                count <= count_load; //if load is high, the counter loads the value in "count_load"
        end
    end
end


endmodule
