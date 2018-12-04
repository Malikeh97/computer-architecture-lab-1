module Hazard_Detection_Unit(
  input [4:0]src1,
  input [4:0]src2,
  input [4:0]Exe_Dest,
  input Exe_WB_EN,
  input [4:0]Mem_Dest,
  input Mem_WB_EN,
  input is_immediate,
  input MEM_W_EN,
  input [1:0] Branch_Type,
  output hazard_detected
);

reg hazard = 1'b0;
always @ ( * ) begin
	hazard <= 1'b0;
	if((src1 == Exe_Dest && Exe_WB_EN && Exe_Dest != 0) || (src1 == Mem_Dest && Mem_WB_EN && Mem_Dest != 0))
		hazard <= 1'b1;
	else if ((src2 == Exe_Dest && (!is_immediate || (is_immediate && (MEM_W_EN || (Branch_Type == 2'b10)))) && Exe_WB_EN && Exe_Dest != 0) || (src2 == Mem_Dest && (!is_immediate || (is_immediate && (MEM_W_EN || (Branch_Type == 2'b10)))) && Mem_WB_EN && Mem_Dest != 0))
		hazard <= 1'b1;
end

assign hazard_detected = hazard;

endmodule
