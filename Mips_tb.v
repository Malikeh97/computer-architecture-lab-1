
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   12:20:34 10/29/2018
// Design Name:   matrix_multipy
// Module Name:   C:/cad/CA1/matrix_multiplier/matrix_multiply_tb.v
// Project Name:  matrix_multiplier
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: matrix_multipy
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module Mips_tb;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	MIPS mips(.CLOCK_50(clk), .SW({17'b0, rst}));


	initial begin
		clk = 0;
		rst = 0;

    #100 rst = 1;
    repeat(2) #100 clk = ~clk;
    #100 rst = 0;

    repeat(5000) #100 clk = ~clk;

		$stop;
	end

endmodule
