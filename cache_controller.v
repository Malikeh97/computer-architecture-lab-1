module cache_controller(
  input clk,
  input rst,

  //memory stage unit
  input [31:0] address,
  input [31:0] wdata,
  input MEM_R_EN,
  input MEM_W_EN,
  output [31:0] rdata,
  output ready,
  output cache_hit,

  //SRAM controller
  output [31:0] sram_address,
  output [31:0] sram_wdata,
  input [63:0] sram_rdata,
  input sram_ready
);


reg[31:0] data_1h[0:63];
reg[31:0] data_1l[0:63];
reg[0:63] v_1;
reg[8:0] tag_1[0:63];

reg[31:0] data_0h[0:63];
reg[31:0] data_0l[0:63];
reg[0:63] v_0;
reg[8:0] tag_0[0:63];
reg[0:63] LRU;

wire hit, hit0, hit1;
assign hit0 = (address[17:9] == tag_0[address[8:3]]) && v_0[address[8:3]] && MEM_W_EN == 0;
assign hit1 = (address[17:9]  == tag_1[address[8:3]]) && v_1[address[8:3]]  && MEM_W_EN == 0;
assign hit = hit0 || hit1 || (MEM_R_EN == 0 && MEM_W_EN == 0);
assign ready = sram_ready || hit;
assign rdata = (hit0 && address[2] == 1) ? data_0h[address[8:3]] :
               (hit0 && address[2] == 0) ? data_0l[address[8:3]] :
               (hit1 && address[2] == 1) ? data_1h[address[8:3]] :
               (hit1 && address[2] == 0) ? data_1l[address[8:3]] :
               (address[2] == 1) ? sram_rdata[63:32] :
               (address[2] == 0) ? sram_rdata[31:0] : 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

assign sram_address = address;
assign sram_wdata = wdata;
assign cache_hit = hit;

integer i;
always @(posedge clk, posedge rst) begin
  if (rst) begin
  	 v_0 <= 0;
	 v_1 <= 0;
	 LRU <= 0;
  end
  else begin
    if (MEM_W_EN) begin
      if (tag_0[address[8:3]] == address[17:9] && v_0[address[8:3]] == 1)
        v_0[address[8:3]] <= 0;
      else if (tag_1[address[8:3]] == address[17:9] && v_1[address[8:3]] == 1)
        v_1[address[8:3]] <= 0;
    end
    else if (sram_ready) begin
      if (LRU[address[8:3]] == 0) begin
        v_0[address[8:3]] <= 1;
        tag_0[address[8:3]] <= address[17:9];
        data_0l[address[8:3]] <= sram_rdata[31:0];
        data_0h[address[8:3]] <= sram_rdata[63:32];
      end
      else if (LRU[address[8:3]] == 1) begin
        v_1[address[8:3]] <= 1;
        tag_1[address[8:3]] <= address[17:9];
        data_1l[address[8:3]] <= sram_rdata[31:0];
        data_1h[address[8:3]] <= sram_rdata[63:32];
      end
      LRU[address[8:3]] <= LRU[address[8:3]] + 1;
    end
  end
end

endmodule
