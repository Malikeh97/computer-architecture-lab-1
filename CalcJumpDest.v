module CalcJumpDest (
  input[31:0] val2,
  input[31:0] PC,
  output[31:0] Br_Addr
  );
  assign Br_Addr = val2 * 4 + PC + 4;
endmodule
