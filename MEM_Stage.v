module MEM_Stage(
  input clk,
  input MEM_R_EN_in,
  input MEM_W_EN_in,
  input[31:0] ALU_result_in,
  input[31:0] ST_val,
  output[31:0] Mem_read_value
);

wire[31:0] mapped_addr;


Addr_Map addr_map(.ALU_result_in(ALU_result_in), .mapped_addr(mapped_addr));
DataMemory datamemory(.clk(clk), .MEM_R_EN_in(MEM_R_EN_in), .MEM_W_EN_in(MEM_W_EN_in),
                      .mapped_addr(mapped_addr), .ST_val(ST_val), .Mem_read_value(Mem_read_value));

endmodule
