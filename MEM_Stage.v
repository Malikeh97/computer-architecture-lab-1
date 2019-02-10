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
wire[31:0] sram_address;
wire[31:0] sram_wdata;
wire[63:0] sram_rdata;
wire sram_ready, cache_hit;

Addr_Map addr_map(.ALU_result_in(ALU_result_in), .mapped_addr(mapped_addr));

cache_controller cache_ctrl(.clk(clk), .rst(rst), .address(mapped_addr), .wdata(ST_val),
                       .MEM_R_EN(MEM_R_EN_in), .MEM_W_EN(MEM_W_EN_in), .rdata(Mem_read_value),
                       .ready(ready), .cache_hit(cache_hit), .sram_address(sram_address), .sram_wdata(sram_wdata), .sram_rdata(sram_rdata),
                       .sram_ready(sram_ready));

Sram_Controller sram_controller(.clk(clk), .rst(rst), .wr_en(MEM_W_EN_in), .rd_en(MEM_R_EN_in),
                       .address(sram_address), .writeData(sram_wdata), .cache_hit(cache_hit), .readData(sram_rdata),
                       .ready(sram_ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR),
                       .SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N),
                       .SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N));

// DataMemory datamemory(.clk(clk), .MEM_R_EN_in(MEM_R_EN_in), .MEM_W_EN_in(MEM_W_EN_in),
                      // .mapped_addr(mapped_addr), .ST_val(ST_val), .Mem_read_value(Mem_read_value));

endmodule
