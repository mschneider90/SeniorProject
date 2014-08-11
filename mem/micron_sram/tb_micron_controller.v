`timescale 1ns / 1ps

module tb_micron_controller();

reg clk50MHz;
reg[15:0] baddr;
wire bwait;
wire[15:0] maddr;
wire moe_L;
wire mwe_L;
wire madv_L;
wire mclk;
wire mub_L;
wire mlb_L;
wire mce_L;
wire mcre;

wire[15:0] bdata;
wire[15:0] mdata;

reg[15:0] mdata_reg;

assign mdata = (mdata_reg == 16'hFFFF)? 'bz : mdata_reg;
                          
micron_controller ctrl(.clk50MHz(clk50MHz),
                       .baddr(baddr),
                       .bburst(2'b11),
                       .bwait(bwait),
                       .maddr(maddr),
                       .moe_L(moe_L),
                       .mwe_L(mwe_L),
                       .madv_L(madv_L),
                       .mclk(mclk),
                       .mub_L(mub_L),
                       .mlb_L(mlb_L),
                       .mce_L(mce_L),
                       .mcre(mcre),
                       .mwait(0)
                      );
                     
micron_sram ram (.clk(mclk),
                 .addr(maddr),
                 .adv_L(madv_L),
                 .ce_L(mce_L),
                 .oe_L(moe_L),
                 .we_L(mwe_L),
                 .mem_wait(mem_wait),
                 .data(mdata),
                 .ub_L(1),
                 .lb_L(1)); 
                 
wire[7:0] counter;
reg rst;
  
count_reg cntr(.en(1), .rst(rst), .clk(clk50MHz), .count(counter), .load(0));
                      
initial begin
    clk50MHz <= 0;
    baddr <= 0;
    mdata_reg <= 16'hFFFF;
    rst = 1;
end

always@(counter) begin
    case (counter) 
        0: begin
            rst = 0;
            baddr <= 16'hFFFB; //Write
        end
        1: begin
            baddr <= 16'h0000; //Starting addr
        end
        2: begin
            //Wait 1
        end
        3: begin
            //Wait 2
        end
        4: begin
            //Wait 3
        end
        5: begin
            //Wait 4
        end
        6: begin
            mdata_reg <= 16'h0001; //data 1
        end
        7: begin
            mdata_reg <= 16'h0002; //data 2
        end
        8: begin
            mdata_reg <= 16'h0003; //data 3
        end
        9: begin
            mdata_reg <= 16'h0004; //data 4
        end
        10: begin
            mdata_reg <= 16'hFFFF; //disable 
        end
        11: begin
            baddr <= 16'hFFFA; //read
        end
        12: begin
            baddr <= 16'h0000; //addr
        end
    endcase
end

always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule
