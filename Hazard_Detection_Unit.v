module Hazard_Detection_Unit(
  input [4:0]src1,
  input [4:0]src2,
  input [4:0]Exe_Dest,
  input Exe_WB_EN,
  input [4:0]Mem_Dest,
  input Mem_WB_EN,
  input is_immediate,
  input MEM_R_EN,
  input MEM_W_EN,
  input [1:0] Branch_Type,
  input forward_en,
  output reg hazard_detected
);

always @ ( * ) begin
  hazard_detected <= 1'b0;
  if(forward_en == 1'b0) begin
    if((src1 == Exe_Dest && Exe_WB_EN && Exe_Dest != 0) || (src1 == Mem_Dest && Mem_WB_EN && Mem_Dest != 0))
      hazard_detected <= 1'b1;
    else if ((src2 == Exe_Dest && (!is_immediate || (is_immediate && (MEM_W_EN || (Branch_Type == 2'b10)))) && Exe_WB_EN && Exe_Dest != 0) || (src2 == Mem_Dest && (!is_immediate || (is_immediate && (MEM_W_EN || (Branch_Type == 2'b10)))) && Mem_WB_EN && Mem_Dest != 0))
      hazard_detected <= 1'b1;
  end
  if (((src2 == Exe_Dest && (is_immediate && MEM_R_EN)) && Exe_WB_EN && Exe_Dest != 0) || ((src2 == Mem_Dest && (is_immediate && MEM_R_EN)) && Mem_WB_EN && Mem_Dest != 0))
    hazard_detected <= 1'b1;
end
endmodule
