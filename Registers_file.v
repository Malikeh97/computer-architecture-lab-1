module Registers_File (
	input clk,
	input rst,
	input[4:0] src1,
	input[4:0] src2,
	input[4:0] dest,
	input[31:0] Write_Val,
	input Write_EN,
	output[31:0] reg1,
	output[31:0] reg2
);

reg[31:0] register[31:0];

integer i;
initial begin
	for(i = 0; i < 32; i = i + 1)
		register[i] = i;
end

assign reg1 = register[src1];
assign reg2 = register[src2];

always @(negedge clk, posedge rst) begin
	if (rst)
		for(i = 0; i < 32; i = i + 1)
			register[i] = i;
	else if (Write_EN == 1)
		register[dest] <= Write_Val;
end

endmodule