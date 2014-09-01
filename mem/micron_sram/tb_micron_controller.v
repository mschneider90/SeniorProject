`timescale 1ns / 1ps

module tb_micron_controller();

reg clk50MHz;
reg[19:0] baddr;
wire bwait;
wire[19:0] maddr;
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
reg bwe_L;

assign mdata = (mdata_reg == 16'hFFFF)? 'bz : mdata_reg;
                          
micron_controller ctrl(.clk50MHz(clk50MHz),
                       .baddr(baddr),
                       .bburst(2'b11),
                       .benable_L(0),
                       .bwe_L(bwe_L),
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
    clk50MHz <= 1;
    baddr <= 0;
    mdata_reg <= 16'hFFFF;
    rst <= 1;
    bwe_L <= 0;
end

parameter DATA_1 = 1;
parameter DATA_2 = 2;
parameter DATA_3 = 3;
parameter DATA_4 = 4;

reg[1:0] errors;

always@(counter) begin
    case (counter) 
        0: begin
            rst <= 0;
            errors <= 0;
            baddr <= 0;
            bwe_L <= 0;
        end
        1: begin
            //Wait 1
        end
        2: begin
            //Wait 2
        end
        3: begin
            //Wait 3
        end
        4: begin
            mdata_reg <= DATA_1; //data 1
        end
        5: begin
            mdata_reg <= DATA_2; //data 2
        end
        6: begin
            mdata_reg <= DATA_3; //data 3
        end
        7: begin
            mdata_reg <= DATA_4; //data 4
        end
        8: begin
            mdata_reg <= 16'hFFFF; //disable 
            baddr <= 0;
            bwe_L <= 1;
        end
        9: begin
            //wait 1
        end
        10: begin
            //wait 2
        end
        11: begin
            //wait 3
        end
        12: begin
            //data 1
            if (mdata != DATA_1) begin
                errors <= errors + 1;
            end
        end
        13: begin 
            //data 2
            if (mdata != DATA_2) begin
                errors <= errors + 1;
            end
        end
        14: begin
            //data 3
            if (mdata != DATA_3) begin
                errors <= errors + 1;
            end
        end
        15: begin
            //data 4
            if (mdata != DATA_4) begin
                errors <= errors + 1;
            end
        end
        16: begin
            if (errors == 0) begin
                $display("PASS");
            end
            else begin
                $display("FAIL");
            end
        end
    endcase
end

always begin
    #5 clk50MHz = ~clk50MHz;
end

endmodule
