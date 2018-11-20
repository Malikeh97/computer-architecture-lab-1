module WB_Stage(
  input clk,
  input WB_en_in,
  input MEM_R_EN,
  input[31:0] ALU_result,
  input[31:0] Mem_read_value,
  input[4:0] Dest_in,
  output WB_en,
  output[31:0] Write_value,
  output[4:0] Dest
);

assign WB_en = MEM_R_EN && ALU_result >= 1280 ? 1'b0 : WB_en_in;
assign Write_value = MEM_R_EN ? Mem_read_value : ALU_result;
assign Dest = Dest_in;

endmodule
