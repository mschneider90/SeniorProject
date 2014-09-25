module mips #(parameter dwidth = 16,
              parameter awidth = 32,
              parameter iwidth = 32)
           (input clk, reset,
            output [dwidth-1:0] pc,       //TODO remove pc and instr once we support reading
            input  [iwidth-1:0] instr,    //from ROM over bus interface
            input               bus_wait,
            input               bus_ack,
            input  [4:0]        debug_ra4,
            output              bus_write,
            output [1:0]        bus_burst_length,
            output [awidth-1:0] bus_addr,
            output              bus_req,
            output [dwidth-1:0] debug_rd4,
            inout  [dwidth-1:0] bus_data);

  wire        memtoreg,
              pcsrc, zero,
              alusrc, regdst, regwrite, jump, jumpreg, link,
              mult, mfhi, mflo, memop;
  wire [2:0]  alucontrol;
  wire [dwidth-1:0] readdata;
  wire [dwidth-1:0] writedata;
  
  //TODO make all bus outputs hi-z unless they are active
  assign bus_burst_length = 2'b00; //Always read/write one word at a time
  
  assign bus_data = (bus_write)? writedata : 'bz;
  
  //Delay bus data by two clock cycles to correctly interface with bus
  wire [dwidth-1:0] bus_data_delayed;
  d_reg #(dwidth) read_data_delay_1(.clk(clk),
                                  .reset(reset),
                                  .en(1),
                                  .d(bus_data),
                                  .q(bus_data_delayed));

  d_reg #(dwidth) read_data_delay_2(.clk(clk),
                                  .reset(reset),
                                  .en(1),
                                  .d(bus_data_delayed),
                                  .q(readdata));
  
  cpuBusInterface bus_if(.clk(clk),
                         .memop(memop),
                         .bus_ack(bus_ack),
                         .bus_wait(bus_wait),
                         .bus_req(bus_req),
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
              .pc_stall(pc_stall),
              .debug_ra4(debug_ra4),
              .debug_rd4(debug_rd4));
endmodule







