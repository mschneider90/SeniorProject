module mips #(parameter dwidth = 32,
              parameter awidth = 32,
              parameter iwidth = 32,
              parameter cwidth = 8)
           (input clk, reset,
            input  [cwidth-1:0] bus_ctrl_in,
            input               bus_ack,
            input  [4:0]        debug_ra4,
            output [cwidth-1:0] bus_ctrl_out,
            output              bus_req,
            output [dwidth-1:0] debug_rd4,
            input  [dwidth-1:0] bus_data_in,
            output [dwidth-1:0] bus_data_out);

  wire        memtoreg,
              pcsrc, zero,
              alusrc, regdst, regwrite, jump, jumpreg, link,
              mult, mfhi, mflo, memop;
  wire [2:0]  alucontrol;
  wire [dwidth-1:0] readdata;
  wire [dwidth-1:0] writedata;
  wire pc_stall;
  wire bus_write;
  
  wire[iwidth-1:0] pc;
  wire[iwidth-1:0] instr;
  
  assign bus_ctrl_out = {3'b000, //not used 
                         3'b000, //burst length of 1
                         bus_write,
                         1'b0 }; //wait
                         
  // Selects between outputting address and data
  wire [dwidth-1:0] bus_addr;
  wire data_out;
  wire [dwidth-1:0] data_addr_mux_out;
  mux2 #(.WIDTH(dwidth)) data_addr_mux (.in_a(bus_addr),
                                   .in_b(writedata),
                                   .mux_sel(data_out),
                                   .mux_out(data_addr_mux_out));
                                   
  // Selects between CPU addr/reg and CPU instr memory
  wire instr_out;
  wire [iwidth-1:0] instr_bus_read;
  mux2 #(.WIDTH(dwidth)) reg_instr_mux (.in_a(data_addr_mux_out),
                                   .in_b(instr_bus_read),
                                   .mux_sel(instr_out),
                                   .mux_out(bus_data_out));

  assign bus_wait = bus_ctrl_in[0];
  
  //Delay bus data by one clock cycle to correctly interface with bus
  wire [dwidth-1:0] bus_data_delayed;
  wire [dwidth-1:0] bus_data_delayed_2;
  d_reg #(dwidth) read_data_delay_1(.clk(clk),
                                  .reset(reset),
                                  .en(1),
                                  .d(bus_data_in),
                                  .q(readdata));
 
  wire instr_we;
  wire instr_addr_rst;
  wire instr_addr_we;
  cpuBusInterface bus_if(.clk(clk),
                         .memop(memop),
                         .reset(reset),
                         .bus_ack(bus_ack),
                         .bus_wait(bus_wait),
                         .bus_we(bus_ctrl_in[1]),
                         .bus_req(bus_req),
                         .pc_stall(pc_stall),
                         .data_out(data_out),
                         .instr_out(instr_out),
                         .instr_we(instr_we),
                         .instr_addr_rst(instr_addr_rst),
                         .instr_addr_we(instr_addr_we)
                         );
    
  wire [5:0] instr_addr; //write address    
  d_reg #(dwidth) instrAddr(.clk(clk),
                            .reset(instr_addr_rst),
                            .en(instr_addr_we),
                            .d(bus_data_in),
                            .q(instr_addr));
  
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
  
  // Instruction memory
  imem instr_mem(.clk(clk),
                 .addr_r(pc[7:2]),
                 .data_r(instr),
                 .addr_r2(instr_addr),
                 .data_r2(instr_bus_read),
                 .addr_w(instr_addr),
                 .data_w(bus_data_in),
                 .we(instr_we)
                 );
endmodule







