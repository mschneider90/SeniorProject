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
               output [1:0] aluop);

  reg [13:0] controls;

  assign {regwrite, regdst, alusrc, branch, memwrite,
          memtoreg, jump, jumpreg, link, mult, mfhi, mflo, aluop} = controls;

  always @(*)
    case(op)
      6'b000000: begin  //Rtype
			case (funct)
				6'b011001: controls <= 14'b00000000010000; //MULTU 
				6'b010000: controls <= 14'b11000000001000; //MFHI 
				6'b010010: controls <= 14'b11000000000100; //MFLO
				6'b001000: controls <= 14'b00000001000000; //JR
				default: controls <= 14'b11000000000010;
			endcase
		end
      6'b100011: controls <= 14'b10100100000000; //LW
      6'b101011: controls <= 14'b00101000000000; //SW
      6'b000100: controls <= 14'b00010000000001; //BEQ
      6'b001000: controls <= 14'b10100000000000; //ADDI
      6'b000010: controls <= 14'b00000010000000; //J
		6'b000011: controls <= 14'b10000010100000; //JAL
      default:  begin //unsupported opcode
    		controls <= 14'bxxxxxxxxxxxxxx;
		end 
    endcase
endmodule