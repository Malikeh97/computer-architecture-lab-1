module Forward_Unit(
  input [4:0] src1,
  input [4:0] src2,
  input [4:0] Exe_Dest,
  // input Exe_WB_EN,
  input [4:0] Mem_Dest,
  input Mem_WB_EN,
  input [4:0] WB_Dest,
  input WB_WB_EN,
  input forward_en,
  input is_immediate,
  input MEM_W_EN,
  input [1:0] Branch_Type,
  output reg[1:0] sel1,
  output reg[1:0] sel2,
  output reg[1:0] sel3
);

always @ ( * ) begin
  sel1 <= 2'b00;
  sel2 <= 2'b00;
  sel3 <= 2'b00;

  if(forward_en) begin
    if((src1 == Mem_Dest && Mem_WB_EN && Mem_Dest != 0))
      sel1 <= 2'b01;
    else if (src1 == WB_Dest && WB_WB_EN && WB_Dest != 0)
      sel1 <= 2'b10;

    if (is_immediate == 0) begin
      if ((src2 == Mem_Dest && Mem_WB_EN && Mem_Dest != 0))
        sel2 <= 2'b01;
      else if ((src2 == WB_Dest && WB_WB_EN && WB_Dest != 0))
        sel2 <= 2'b10;
    end

    if((Exe_Dest == Mem_Dest && Mem_WB_EN && Mem_Dest != 0))
      sel3 <= 2'b01;
    else if (Exe_Dest == WB_Dest && WB_WB_EN && WB_Dest != 0)
      sel3 <= 2'b10;

  end
end
endmodule
