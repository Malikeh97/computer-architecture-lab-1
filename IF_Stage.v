module IF_Stage(
	input clk,
	input rst,
	input Br_tacken,
	input[31:0] Br_Addr,
	output[31:0] PC,
	output[31:0] Instruction
);

reg[31:0] pc = 32'b0;
reg[31:0] ROM[127:0];

initial begin
	ROM[1] = 32'b10000000000000010000011000001010;
	ROM[2] = 32'b00000100000000010001000000000000;
	ROM[3] = 32'b00001100000000010001100000000000;
	ROM[4] = 32'b00010100010000110010000000000000;
	ROM[5] = 32'b10000100011001010001101000110100;
	ROM[6] = 32'b00011000011001000010100000000000;
	ROM[7] = 32'b00011100101000000011000000000000;
	ROM[11] = 32'b10010100001000100000000000000000;
	ROM[12] = 32'b10010000001001010000000000000000;
	ROM[13] = 32'b10100000101000000000000000000001;
	ROM[14] = 32'b00100000101000010011100000000000;
	ROM[16] = 32'b00100100011010110011100000000000;
	ROM[48] = 32'b10100100001000111111111111110001;
	ROM[64] = 32'b10101000000000001111111111111111;
end

always  @(posedge clk, posedge rst)begin
	if(rst) pc <= 32'b0;
	else pc <= Br_tacken ? Br_Addr: pc + 32'd4;
end

assign PC = pc;
assign Instruction = ROM[PC[31:2]];

endmodule
