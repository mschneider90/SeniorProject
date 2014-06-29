module datapath #(parameter dwidth = 32)
               (input         clk, reset,
                input         memtoreg, pcsrc,
                input         alusrc, regdst,
                input         regwrite, jump, jumpreg,
					 input         link, mult,
					 input         mfhi, mflo,
                input  [2:0]  alucontrol,
                output        zero,
                output [dwidth-1:0] pc,
                input  [dwidth-1:0] instr,
                output [dwidth-1:0] alumult_out, writedata,
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
  flopr #(dwidth) pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(pc, 32'b100, pcplus4);
  sl2         immsh(signimm, signimmsh);
  adder       pcadd2(pcplus4, signimmsh, pcbranch);
  mux2 #(dwidth)  pcbrmux(pcplus4, pcbranch, pcsrc,
                      pcnextbr);
  mux_4to1 #(dwidth) pcmux (.in_A(pcplus4), .in_B(pcfromj), .in_C(pcbranch),
                      .in_D(pcfromrf), .mux_sel(pcmux_ctrl), .out(pcnext));
  encoder4to2 enc(.in(enc_in), .out(pcmux_ctrl));

//~~~~~~~~~~~~~~~~~ register file logic~~~~~~~~~~~~~~~~~~~~~~
				
  regfile     rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]),
                 .ra2(instr[20:16]), .wa3(rf_writeAddr),
                 .wd3(rf_writeData), .rd1(srca), .rd2(writedata));
  mux2 #(5)   wrmux(instr[20:16], instr[15:11],
                    regdst, writereg);
  mux2 #(dwidth)  resmux(alumult_out, readdata,
                     memtoreg, result);
  //selects between writing PC+4 (return addr) or result to RF
  mux2 #(dwidth)  retres_mux(.d0(result), .d1(pcplus4), .s(link), .y(rf_writeData));
  //selects between R31 or immediate value for addr
  mux2 #(5)   r31imm_mux(.d0(writereg), .d1(5'b11111), .s(link), .y(rf_writeAddr));
  signext     se(instr[15:0], signimm);

//~~~~~~~~~~~~~~~~ ALU logic ~~~~~~~~~~~~~~~~~~~~~~~~
  mux2 #(dwidth)  srcbmux(writedata, signimm, alusrc,
                      srcb);
  alu         alu(srca, srcb, alucontrol,
                  aluout, zero);
						
//~~~~~~~~~~~~~~~Multiplier logic~~~~~~~~~~~~~~~~~~~~
  multiplier  mult_module(.in_A(srca), .in_B(writedata), .write_en(mult), .clk(clk),
                          .out_hi(hi), .out_lo(lo));
  //Selects between hi and lo output registers
  mux2 #(dwidth) hilomux(.d0(lo), .d1(hi), .s(mfhi), .y(hilo_out));
  //Selects between ALU and MULT
  mux2 #(dwidth) alumultmux(.d0(aluout), .d1(hilo_out), .s(mfhi | mflo), .y(alumult_out));
endmodule
