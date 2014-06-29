//--------------------------------------------------------------
// mips.v
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Single-cycle MIPS processor
//--------------------------------------------------------------

// files needed for simulation:
//  mipsttest.v
//  mipstop.v
//  mipsmem.v
//  mips.v
//  mipsparts.v

// single-cycle MIPS processor
module mips #(parameter dwidth = 32)
           (input clk, reset,
            output [dwidth-1:0] pc,
            input  [dwidth-1:0] instr,
            output        memwrite,
            output [dwidth-1:0] alumult_out, writedata,
            input  [dwidth-1:0] readdata);

  wire        memtoreg,
              pcsrc, zero,
              alusrc, regdst, regwrite, jump, jumpreg, link,
				  mult, mfhi, mflo;
  wire [2:0]  alucontrol;
 
  controller c(.op(instr[31:26]), .funct(instr[5:0]), .zero(zero),
               .memtoreg(memtoreg), .memwrite(memwrite), .pcsrc(pcsrc),
               .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .jumpreg(jumpreg),
               .link(link), .mult(mult), .mfhi(mfhi), .mflo(mflo), .alucontrol(alucontrol));
  datapath dp(.clk(clk), .reset(reset), .memtoreg(memtoreg), .pcsrc(pcsrc),
              .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .jumpreg(jumpreg),
              .link(link), .mult(mult), .mfhi(mfhi), .mflo(mflo), .alucontrol(alucontrol),
              .zero(zero), .pc(pc), .instr(instr),
              .alumult_out(alumult_out), .writedata(writedata), .readdata(readdata));
endmodule







