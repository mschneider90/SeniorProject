module alu(input      [31:0] in_a, in_b, 
           input      [2:0]  alu_op, 
           output reg [31:0] alu_out,
           output            alu_zero);

  wire [31:0] b2, sum, slt;

  assign b2 = alu_op[2] ? ~in_b:in_b; 
  assign sum = in_a + b2 + alu_op[2];
  assign slt = alu_out[31];

  always@(*)
    case(alu_op[1:0])
      2'b00: alu_out <= in_a & in_b;
      2'b01: alu_out <= in_a | in_b;
      2'b10: alu_out <= sum;
      2'b11: alu_out <= slt;
    endcase

  assign alu_zero = (alu_out == 32'b0);
endmodule
