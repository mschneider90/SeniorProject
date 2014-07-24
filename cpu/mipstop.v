module top(input         clk, reset, 
           output [31:0] writedata, dataadr, 
           output        memwrite);

  wire [31:0] pc, instr, readdata;
  
  mips mips(.clk(clk), 
            .reset(reset),
				.pc(pc),
				.instr(instr),
				.memwrite(memwrite),
            .alumult_out(dataadr),
				.writedata(writedata),
				.readdata(readdata));
  imem imem(.addr(pc[7:2]),
            .data_r(instr));
  dmem dmem(.clk(clk),
            .we(memwrite),
 				.addr(dataadr),
				.data_w(writedata),
				.data_r(readdata));

endmodule
