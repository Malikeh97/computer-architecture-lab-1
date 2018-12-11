module MEM_Stage(
  input clk,
  input rst,
  input MEM_R_EN_in,
  input MEM_W_EN_in,
  input[31:0] ALU_result_in,
  input[31:0] ST_val,
  output[31:0] Mem_read_value,
  output ready,
  inout[15:0] SRAM_DQ,
  output[17:0] SRAM_ADDR,
  output SRAM_UB_N,
  output SRAM_LB_N,
  output SRAM_WE_N,
  output SRAM_CE_N,
  output SRAM_OE_N
);

wire[31:0] mapped_addr;


Addr_Map addr_map(.ALU_result_in(ALU_result_in), .mapped_addr(mapped_addr));

module Sram_Controller(.clk(clk), .rst(rst), .wr_en(MEM_W_EN_in), .rd_en(MEM_R_EN_in),
                       .address(mapped_addr), .writeData(ST_val), .readData(Mem_read_value),
                       .ready(ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR),
                       .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N),
                       .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_CE_N));

// DataMemory datamemory(.clk(clk), .MEM_R_EN_in(MEM_R_EN_in), .MEM_W_EN_in(MEM_W_EN_in),
                      // .mapped_addr(mapped_addr), .ST_val(ST_val), .Mem_read_value(Mem_read_value));

endmodule
