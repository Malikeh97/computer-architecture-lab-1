module Addr_Map(
  input[31:0] ALU_result_in,
  output[31:0] mapped_addr
);

assign mapped_addr = ALU_result_in - 32'd1024;

endmodule
