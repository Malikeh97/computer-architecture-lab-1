module Control_Unit(
	input[5:0] opcode,
	output reg[3:0] Exe_Cmd,
	output reg mem_read,
	output reg mem_write,
	output reg WB_Enable,
	output reg is_immediate,
	output reg [1:0] Branch_Type
);

parameter [5:0] NOP = 6'd0,
					 ADD = 6'd1,
					 SUB = 6'd3,
					 AND = 6'd5,
					 OR = 6'd6,
					 NOR = 6'd7,
					 XOR = 6'd8,
					 SLA = 6'd9,
					 SLL = 6'd10,
					 SRA = 6'd11,
					 SRL = 6'd12,
					 ADDI = 6'd32,
					 SUBI = 6'd33,
					 LD = 6'd36,
					 ST = 6'd37,
					 BEZ = 6'd40,
					 BNE = 6'd41,
					 JMP = 6'd42;

always @(opcode) begin
	{ Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0;
	case(opcode)
		NOP:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'bxxxx000000;
		ADD:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0000001000;
		SUB:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0010001000;
		AND:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0100001000;
		OR:   { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0101001000;
		NOR:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0110001000;
		XOR:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0111001000;
		SLA:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b1000001000;
		SLL:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b1000001000;
		SRA:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b1001001000;
		SRL:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b1010001000;
		ADDI: { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0000001100;
		SUBI: { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0010001100;
		LD:   { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0000100000;
		ST:   { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'b0000010000;
		BEZ:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'bxxxx000001;
		BNE:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'bxxxx000010;
		JMP:  { Exe_Cmd, mem_read, mem_write, WB_Enable, is_immediate, Branch_Type } = 10'bxxxx000011;
	endcase
end

endmodule
