module datapath #(parameter dwidth = 32,
                  parameter iwidth = 32)
               (input         clk, reset,
                input         memtoreg, pcsrc,
                input         alusrc, regdst,
                input         regwrite, jump, jumpreg,
                input         link, mult,
                input         mfhi, mflo,
                input  [2:0]  alucontrol,
                input         pc_stall,
                input  [4:0]  debug_ra4,
                output        zero,
                output [dwidth-1:0] pc,
                input  [dwidth-1:0] instr,
                output [dwidth-1:0] alumult_out, writedata,
                output [dwidth-1:0] debug_rd4,
                input  [dwidth-1:0] readdata);

  wire [4:0]  writereg;
  wire [dwidth-1:0] pcnext, pcnextbr, pcplus4, pcbranch, pcimm, pcfromrf, pcfromj;
  wire [dwidth-1:0] signimm, signimmsh;
  wire [dwidth-1:0] srca, srcb;
  wire [dwidth-1:0] result;
  wire [dwidth-1:0] rf_writeData;
  wire [4:0] rf_writeAddr;
  wire [dwidth-1:0] hi;
  wire [dwidth-1:0] lo;
  wire [dwidth-1:0] hilo_out;
  wire [dwidth-1:0] aluout;
  wire [1:0] pcmux_ctrl;
  wire [3:0] enc_in;
  
//~~~~~~~~~~~~~~~~~ next PC logic~~~~~~~~~~~~~~~~~~~~~
  assign pcfromrf = srca;
  assign pcfromj = instr[25:0] << 2;
  assign enc_in = {jumpreg, pcsrc, jump, 1'b0};
  d_reg #(dwidth) pcreg(.clk(clk),
                        .en(~pc_stall), // Can stall PC to support multicycle mem accesses
                        .reset(reset),  
                        .d(pcnext),
                        .q(pc));
  adder pcadd1(.a(pc),
               .b(32'b100),
			   .sum(pcplus4));
  sl2 immsh(.in(signimm),
            .out_shifted(signimmsh));
  adder pcadd2(.a(pcplus4),
               .b(signimmsh),
               .sum(pcbranch));
  mux2 #(dwidth)  pcbrmux(.in_a(pcplus4),
                          .in_b(pcbranch),
                          .mux_sel(pcsrc),
                          .mux_out(pcnextbr));	  
  mux_4to1 #(dwidth) pcmux (.in_A(pcplus4),
                            .in_B(pcfromj),
                            .in_C(pcbranch),
                            .in_D(pcfromrf),
                            .mux_sel(pcmux_ctrl),
                            .out(pcnext));			 
  encoder4to2 enc(.in(enc_in),
                  .out(pcmux_ctrl));

//~~~~~~~~~~~~~~~~~ register file logic~~~~~~~~~~~~~~~~~~~~~~
				
  regfile #(32)  rf(.clk(clk),
                 .we3(regwrite),
                 .ra1(instr[25:21]),
                 .ra2(instr[20:16]),
                 .wa3(rf_writeAddr),
                 .wd3(rf_writeData),
                 .rd1(srca),
                 .rd2(writedata),
                 .debug_ra4(debug_ra4),
                 .debug_rd4(debug_rd4));
  mux2 #(5)   wrmux(.in_a(instr[20:16]),
                    .in_b(instr[15:11]),
                    .mux_sel(regdst),
                    .mux_out(writereg));
  mux2 #(dwidth)  resmux(.in_a(alumult_out),
                         .in_b(readdata),
                         .mux_sel(memtoreg),
                         .mux_out(result));
  //selects between writing PC+4 (return addr) or result to RF
  mux2 #(dwidth)  retres_mux(.in_a(result),
                             .in_b(pcplus4),
                             .mux_sel(link),
                             .mux_out(rf_writeData));
  //selects between R31 or immediate value for addr
  mux2 #(5)   r31imm_mux(.in_a(writereg),
                         .in_b(5'b11111),
                         .mux_sel(link),
                         .mux_out(rf_writeAddr));
  signext     se(.in(instr[15:0]),
                 .out_ext(signimm));

//~~~~~~~~~~~~~~~~ ALU logic ~~~~~~~~~~~~~~~~~~~~~~~~
  mux2 #(dwidth)  srcbmux(.in_a(writedata),
                          .in_b(signimm),
                          .mux_sel(alusrc),
                          .mux_out(srcb));
  alu alu(.in_a(srca),
          .in_b(srcb),
          .alu_op(alucontrol),
          .alu_out(aluout),
          .alu_zero(zero));
						
//~~~~~~~~~~~~~~~Multiplier logic~~~~~~~~~~~~~~~~~~~~
  multiplier  mult_module(.in_A(srca),
                          .in_B(writedata),
                          .write_en(mult),
                          .clk(clk),
                          .out_hi(hi),
                          .out_lo(lo));
  //Selects between hi and lo output registers
  mux2 #(dwidth) hilomux(.in_a(lo),
                         .in_b(hi),
                         .mux_sel(mfhi),
                         .mux_out(hilo_out));
  //Selects between ALU and MULT
  mux2 #(dwidth) alumultmux(.in_a(aluout),
                            .in_b(hilo_out),
                            .mux_sel(mfhi | mflo),
                            .mux_out(alumult_out));
endmodule
