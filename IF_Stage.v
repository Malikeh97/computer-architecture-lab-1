module IF_Stage(
	input clk,
	input rst,
	output[31:0] PC,
	output[31:0] Instruction
);

reg[31:0] pc = 32'b0;
reg[31:0] ROM[127:0];
	
initial begin	
	ROM[0] = 32'b00000000001000100000000000000000;
	ROM[1] = 32'b00000000011001000000000000000000;
	ROM[2] = 32'b00000000101001100000000000000000;
	ROM[3] = 32'b00000000111010000001000000000000;
	ROM[4] = 32'b00000001001010100001100000000000;
	ROM[5] = 32'b00000001011011000000000000000000;
	ROM[6] = 32'b00000001101011100000000000000000;
end
	
always  @(posedge clk, posedge rst)begin
	if(rst) pc <= 32'b0;
	else pc <= pc + 32'd4;
end

assign PC = pc;
assign Instruction = ROM[PC[31:2]];

endmodule
