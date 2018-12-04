module ID_Stage(
	input clk,
	input rst,
	input[31:0] Instruction,
	input WB_Write_Enable,
	input[4:0] WB_Dest,
	input[31:0] WB_Data,
	input Freeze,
	output[4:0] Dest,
	output[31:0] Reg2,
	output[31:0] Val2,
	output[31:0] Val1,
	output[3:0] EXE_CMD,
	output MEM_R_EN,
	output MEM_W_EN,
	output WB_EN,
	output[1:0] Branch_Type,
	output Is_Immediate,
	output MEM_W_EN2,
	output[1:0] Branch_Type2
);

wire is_immediate;
wire[31:0] reg2;
wire[31:0] sign_extended_immediate;
wire[3:0] exe_cmd;
wire mem_r_en, mem_w_en, wb_en;
wire[1:0] branch_type;

assign Val2 = is_immediate ? sign_extended_immediate : reg2;
assign Dest = is_immediate ? Instruction[20:16] : Instruction[15:11];
assign Reg2 = reg2;
assign EXE_CMD = Freeze ? 0 : exe_cmd;
assign MEM_R_EN = Freeze ? 0 : mem_r_en;
assign MEM_W_EN = Freeze ? 0 : mem_w_en;
assign WB_EN = Freeze ? 0 : wb_en;
assign Branch_Type = Freeze ? 0 : branch_type;

assign Is_Immediate = is_immediate;
assign MEM_W_EN2 = mem_w_en;
assign Branch_Type2 = branch_type;

Control_Unit cu(Instruction[31:26], exe_cmd, mem_r_en, mem_w_en, wb_en, is_immediate, branch_type);
Registers_File rf(clk, rst, Instruction[25:21], Instruction[20:16], WB_Dest, WB_Data, WB_Write_Enable, Val1, reg2);
Sign_Extend se(Instruction[15:0], sign_extended_immediate);

endmodule
