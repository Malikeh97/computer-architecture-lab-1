module Sign_Extend #(parameter length = 16) (
  input  [length - 1:0] a,
  output [31:0] w
);

reg [(32 - length - 1):0] sign1;
reg [(32 - length - 1):0] sign0;
integer i;

initial begin
  for (i = 0; i < (32 - length); i = i + 1) begin
    sign1[i] = 1'b1;
    sign0[i] = 1'b0;
  end
end

assign w = (a[length - 1]) ? {sign1, a[length - 1:0]} : {sign0, a[length - 1:0]};
endmodule
