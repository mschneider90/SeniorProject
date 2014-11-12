module maindec(input  [5:0] op,
               input  [5:0] funct,
               output       memtoreg, memwrite,
               output       branch, alusrc,
               output       regdst, regwrite,
               output       jump,
               output       jumpreg,
               output       link,
               output       mult,
               output       mfhi,
               output       mflo,
               output       memop,
               output       branchop,
               output [1:0] aluop);

  reg [15:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, jumpreg, link, mult, mfhi, mflo, aluop, memop, branchop} = controls;

  always @(*)
    case(op)
      6'b000000: begin  //Rtype
			case (funct)
				6'b011001: controls <= 16'b0000000001000000; //MULTU 
				6'b010000: controls <= 16'b1100000000100000; //MFHI 
				6'b010010: controls <= 16'b1100000000010000; //MFLO
				6'b001000: controls <= 16'b0000000100000001; //JR
				default: controls <=   16'b1100000000001000;
			endcase
		end
      6'b100011: controls <=   16'b1010010000000010; //LW
      6'b101011: controls <=   16'b0010100000000010; //SW
      6'b000100: controls <=   16'b0001000000000101; //BEQ
      6'b001000: controls <=   16'b1010000000000000; //ADDI
      6'b000010: controls <=   16'b0000001000000001; //J
		6'b000011: controls <= 16'b1000001010000001; //JAL
      default:  begin //unsupported opcode
    		controls <=        'b0;
		end 
    endcase
endmodule