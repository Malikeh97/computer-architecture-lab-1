module ALU(
  input[31:0] in1,
  input[31:0] in2,
  input[3:0] cmd,
  output reg[31:0] result
);

  parameter [3:0] NOP = 4'bxxxx,
                  ADD = 4'b0000,
                  SUB = 4'b0010,
                  AND = 4'b0100,
                  OR = 4'b0101,
                  NOR = 4'b0110,
                  XOR = 4'b0111,
                  SLA = 4'b1000,
                  SLL = 4'b1000,
                  SRA = 4'b1001,
                  SRL = 4'b1010,
                  ADDI = 4'b0000,
                  SUBI = 4'b0010,
                  LD = 4'b0000,
                  ST = 4'b0000,
                  BEZ = 4'bxxxx,
                  BNE = 4'bxxxx,
                  JMP = 4'bxxxx;

always @(cmd) begin
  case(cmd)
   ADD: result <= in1 + in2;
   SUB: result <= in1 - in2;
   AND: result <= in1 & in2;
   OR: result <= in1 | in2;
   NOR: result <= ~(in1 | in2);
   XOR: result <= in1 ^ in2;
   SLA: result <= in1 <<< in2;
   SLL: result <= in1 << in2;
   SRA: result <= $signed(in1) >>> in2;
   SRL: result <= in1 >> in2;
  endcase
end

endmodule
