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
               output [1:0] aluop);

  reg [14:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, jumpreg, link, mult, mfhi, mflo, aluop, memop} = controls;

  always @(*)
    case(op)
      6'b000000: begin  //Rtype
			case (funct)
				6'b011001: controls <= 15'b000000000100000; //MULTU 
				6'b010000: controls <= 15'b110000000010000; //MFHI 
				6'b010010: controls <= 15'b110000000001000; //MFLO
				6'b001000: controls <= 15'b000000010000000; //JR
				default: controls <=   15'b110000000000100;
			endcase
		end
      6'b100011: controls <=   15'b101001000000001; //LW
      6'b101011: controls <=   15'b001010000000001; //SW
      6'b000100: controls <=   15'b000100000000010; //BEQ
      6'b001000: controls <=   15'b101000000000000; //ADDI
      6'b000010: controls <=   15'b000000100000000; //J
		6'b000011: controls <= 15'b100000101000000; //JAL
      default:  begin //unsupported opcode
    		controls <=        15'bxxxxxxxxxxxxxxx;
		end 
    endcase
endmodule