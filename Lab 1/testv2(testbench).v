`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:44:16 04/17/2018
// Design Name:   fpcvt
// Module Name:   /home/ise/Lab1V2/testv2.v
// Project Name:  Lab1V2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fpcvt
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testv2;

	// Inputs
	reg [11:0] twos_complement;

	// Outputs
	wire sign;
	wire [2:0] exponent;
	wire [3:0] significand;

	// Instantiate the Unit Under Test (UUT)
	fpcvt uut (
		.twos_complement(twos_complement), 
		.sign(sign), 
		.exponent(exponent), 
		.significand(significand)
	);

	initial begin
		// Initialize Inputs
		twos_complement = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		twos_complement = -40;
		
		#100;
		
		twos_complement = 125;
		
		#100;
		
		twos_complement = 56;
		
		#100
		
		twos_complement = -2048;
		
		#100
		
		twos_complement = 2047;

	end
      
endmodule

