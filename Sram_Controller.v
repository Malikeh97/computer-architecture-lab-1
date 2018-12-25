module Sram_Controller(
  input clk,
  input rst,
  input wr_en,
  input rd_en,
  input[31:0] address,
  input[31:0] writeData,
  output reg [31:0] readData,
  output ready,
  inout[15:0] SRAM_DQ,
  output reg[17:0] SRAM_ADDR,
  output SRAM_UB_N,
  output SRAM_LB_N,
  output reg SRAM_WE_N,
  output SRAM_CE_N,
  output SRAM_OE_N
  );

reg[2:0] counter;
reg[15:0] DQ;

assign {SRAM_LB_N ,SRAM_UB_N ,SRAM_OE_N ,SRAM_CE_N} = 4'b0;

assign ready = ((rd_en == 0 && wr_en == 0) || counter == 5) ? 1'b1 : 1'b0;

assign SRAM_DQ = (wr_en  == 1) ? DQ : 16'bzzzzzzzzzzzzzzzz;

always@(posedge clk) begin
  if(rst) begin
	 SRAM_WE_N <= 1'b1;
    DQ <= 16'bzzzzzzzzzzzzzzzz;
    counter <= 3'd0 ;
  end
  if(rd_en == 1'b1) begin // read from SRAM
    if(counter == 3'd0)begin
      SRAM_WE_N <= 1'b1;
      DQ <= 16'bzzzzzzzzzzzzzzzz;
      SRAM_ADDR <= address[17:1];
      counter <= counter + 1;
    end
    else if(counter == 3'd1)begin
      SRAM_WE_N <= 1'b1;
      readData[31:16] <= SRAM_DQ;
      SRAM_ADDR <= address[17:1] + 1;
      counter <= counter + 1;
    end
    else if(counter == 3'd2)begin
      SRAM_WE_N <= 1'b1;
      readData[15:0] <= SRAM_DQ;
      counter <= counter + 1;
    end
    else if(counter == 3'd3 || counter == 3'd4)begin
      counter <= counter + 1;
    end
    else if(counter == 3'd5)begin
      counter <= 0;
    end
  end
  else if(wr_en == 1'b1) begin // write in SRAM
    if(counter == 3'd0)begin
      SRAM_WE_N <= 1'b0;
      DQ <= writeData[31:16]; //up
      SRAM_ADDR <= address[17:1]; //even
      counter <= counter + 1;
    end
    else if(counter == 3'd1)  begin
		SRAM_WE_N <= 1'b0;
		DQ <= writeData[15:0]; //low
		SRAM_ADDR <= address[17:1] + 1; //odd
		counter <= counter + 1;
    end
    else if(counter == 3'd2 || counter == 3'd3 || counter == 3'd4)  begin
		SRAM_WE_N <= 1'b1;
      counter <= counter + 1;
    end
    else if(counter == 3'd5) begin
	 SRAM_WE_N <= 1'b1;
      counter <= 0;
    end
  end
end

endmodule
