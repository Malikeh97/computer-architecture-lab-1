module EXE_Stage(
	input clk,
	input[3:0] EXE_CMD,
	input[31:0] val1,
	input[31:0] val2,
	input[31:0] val_src2,
	input[31:0] PC,
	input[1:0] Br_type,
	input[1:0] sel1,
	input[1:0] sel2,
  input[1:0] sel3,
	input[31:0] MEM_ALU_Result,
	input[31:0] Write_Value,
	output[31:0] ALU_result,
	output[31:0] Br_Addr,
	output Br_taken
);

wire[31:0] Val1, Val2, Src2_Val;

assign Val1 = (sel1 == 2'b00) ? val1 :
							(sel1 == 2'b01) ? MEM_ALU_Result : Write_Value;

assign Val2 = (sel2 == 2'b00) ? val2 :
 							(sel2 == 2'b01) ? MEM_ALU_Result : Write_Value;

assign Src2_Val = (sel3 == 2'b00) ? val_src2 :
									(sel3 == 2'b01) ? MEM_ALU_Result : Write_Value;



ALU alu( Val1, Val2, EXE_CMD, ALU_result);
ConditionCheck CC( Val1, Src2_Val, Br_type, Br_taken);
CalcJumpDest CJD( Val2, PC, Br_Addr);



endmodule
