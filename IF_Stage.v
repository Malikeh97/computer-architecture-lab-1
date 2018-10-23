module IF_Stage(
	input clk,
	input rst,
	output[31:0] PC,
	output[31:0] Instruction
);

reg[31:0] pc = 32'b0;
reg[31:0] ROM[127:0];

initial begin
	ROM[0] = 32'b00000100000000010001000000000000; // add -> reg[2] = reg[0] + reg[1]
	ROM[1] = 32'b10000000000000010000011000001010; // addi -> reg[1] = reg[0] + 3082
	ROM[2] = 32'b10010000001010110000000000000100; // lw
end

always  @(posedge clk, posedge rst)begin
	if(rst) pc <= 32'b0;
	else pc <= pc + 32'd4;
end

assign PC = pc;
assign Instruction = ROM[PC[31:2]];

endmodule
