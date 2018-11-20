module ID_Stage(
	input clk,
	input rst,
	input[31:0] Instruction,
	input WB_Write_Enable,
	input[4:0] WB_Dest,
	input[31:0] WB_Data,
	output[4:0] Dest,
	output[31:0] Reg2,
	output[31:0] Val2,
	output[31:0] Val1,
	output[3:0] EXE_CMD,
	output MEM_R_EN,
	output MEM_W_EN,
	output WB_EN,
	output[1:0] Branch_Type
);

wire is_immediate;
wire[31:0] reg2;
wire[31:0] sign_extended_immediate;

assign Val2 = is_immediate ? sign_extended_immediate : reg2;
assign Dest = is_immediate ? Instruction[20:16] : Instruction[15:11];
assign Reg2 = reg2;

Control_Unit cu(Instruction[31:26], EXE_CMD, MEM_R_EN, MEM_W_EN, WB_EN, is_immediate, Branch_Type);
Registers_File rf(clk, rst, Instruction[25:21], Instruction[20:16], WB_Dest, WB_Data, WB_Write_Enable, Val1, reg2);
Sign_Extend se(Instruction[15:0], sign_extended_immediate);

endmodule
