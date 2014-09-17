module top(input         clk, reset, bus_wait,
           output [31:0] writedata, dataadr, 
           output        memwrite);

  wire [31:0] pc, instr, readdata;
  
  //TODO this is out of date
  mips mips(.clk(clk), 
            .reset(reset),
            .pc(pc),
            .instr(instr),
            .memwrite(memwrite),
            .alumult_out(dataadr),
            .writedata(writedata),
            .readdata(readdata),
            .bus_wait(bus_wait));
            
  imem imem(.addr(pc[7:2]),
            .data_r(instr));
            
  dmem dmem(.clk(clk),
            .we(memwrite),
            .addr(dataadr),
            .bus_wait(bus_wait),
            .data_w(writedata),
            .data_r(readdata));

endmodule
