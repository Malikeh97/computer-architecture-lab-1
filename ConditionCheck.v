module ConditionCheck(
  	input[31:0] val1,
    input[31:0] val_src2,
    input[1:0] Br_type,
    output reg Br_taken
  );

parameter [1:0] BEZ = 2'b01,
                BNE = 2'b10,
                JMP = 2'b11,
                IDLE = 2'b00;

always @(val1, val_src2, Br_type) begin
	Br_taken <= 1'b0;
	case (Br_type)
		BEZ: if(val1 == 32'b0) Br_taken <= 1'b1;
		BNE: if(val1 != val_src2) Br_taken <= 1'b1;
		JMP: Br_taken <= 1'b1;
		IDLE: Br_taken <= 1'b0;
  endcase
end
endmodule
