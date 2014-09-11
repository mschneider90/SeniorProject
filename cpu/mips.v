module mips #(parameter dwidth = 32)
           (input clk, reset,
            output [dwidth-1:0] pc,       //TODO remove pc and instr once we support reading
            input  [dwidth-1:0] instr,    //from ROM over bus interface
            input               bus_wait,
            input               bus_ack,
            output              bus_write,
            output              bus_burst_length,
            output [dwidth-1:0] bus_addr,
            output              bus_req,
            inout  [dwidth-1:0] bus_data);

  wire        memtoreg,
              pcsrc, zero,
              alusrc, regdst, regwrite, jump, jumpreg, link,
              mult, mfhi, mflo, memop;
  wire [2:0]  alucontrol;
  wire [dwidth-1:0] readdata;
  wire [dwidth-1:0] writedata;
  
  assign bus_burst_length = 1; //Always read/write one word at a time
  
  assign bus_data = (bus_write)? writedata : 'bz;
  assign readdata = bus_data;
  
  cpuBusInterface bus_if(.clk(clk),
                         .memop(memop),
                         .bus_ack(bus_ack),
                         .bus_wait(bus_wait),
                         .bus_reg(bus_reg),
                         .pc_stall(pc_stall));
  
  controller c(.op(instr[31:26]),
               .funct(instr[5:0]),
               .zero(zero),
               .memtoreg(memtoreg),
               .memwrite(bus_write),
               .pcsrc(pcsrc),
               .alusrc(alusrc),
               .regdst(regdst),
               .regwrite(regwrite),
               .jump(jump),
               .jumpreg(jumpreg),
               .link(link),
               .mult(mult),
               .mfhi(mfhi),
               .mflo(mflo),
               .memop(memop),
               .alucontrol(alucontrol));
               
  datapath dp(.clk(clk),
              .reset(reset),
              .memtoreg(memtoreg),
              .pcsrc(pcsrc),
              .alusrc(alusrc),
              .regdst(regdst),
              .regwrite(regwrite),
              .jump(jump),
              .jumpreg(jumpreg),
              .link(link),
              .mult(mult),
              .mfhi(mfhi),
              .mflo(mflo),
              .alucontrol(alucontrol),
              .zero(zero),
              .pc(pc), 
              .instr(instr),
              .alumult_out(bus_addr),
              .writedata(writedata),
              .readdata(readdata),
              .pc_stall(pc_stall));
endmodule







