module Sign_Extend(
  input[15:0] a,
  output[31:0] w
);

assign w = a[15] ? {16'b1111111111111111, a} : {16'b0, a};
endmodule
