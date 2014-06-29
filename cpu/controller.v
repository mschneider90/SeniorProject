module controller(input  [5:0] op, funct,
                  input        zero,
                  output       memtoreg, memwrite,
                  output       pcsrc, alusrc,
                  output       regdst, regwrite,
                  output       jump, jumpreg, link,
						output       mult, mfhi, mflo,
                  output [2:0] alucontrol);

  wire [1:0] aluop;
  wire       branch;

  maindec md(.op(op),
             .funct(funct),
				 .memtoreg(memtoreg),
				 .memwrite(memwrite),
				 .branch(branch),
             .alusrc(alusrc),
				 .regdst(regdst),
				 .regwrite(regwrite),
				 .jump(jump),
				 .jumpreg(jumpreg),
				 .link(link),
				 .mult(mult),
				 .mfhi(mfhi),
				 .mflo(mflo),
				 .aluop(aluop));
  aludec  ad(.funct(funct),
             .aluop(aluop),
				 .alucontrol(alucontrol));

  assign pcsrc = branch & zero;
endmodule
