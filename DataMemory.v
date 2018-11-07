module DataMemory(
  input clk,
  input MEM_R_EN_in,
  input MEM_W_EN_in,
  input[31:0] mapped_addr,
  input[31:0] ST_val,
  output[31:0] Mem_read_value
);

reg [31:0] mem[63:0];

//read from memory
assign Mem_read_value = MEM_R_EN_in ? mem[ mapped_addr[31:2] ] : 32'bx;

//write in memory
always @(posedge clk) begin
  if(MEM_W_EN_in) begin
    mem[ mapped_addr[31:2] ] <= ST_val;
  end
end

endmodule
