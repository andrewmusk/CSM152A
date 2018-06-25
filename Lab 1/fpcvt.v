`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:43 04/17/2018 
// Design Name: 
// Module Name:    fpcvt 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fpcvt(twos_complement, sign, exponent, significand);
	// inputs and outputs
	input[11:0] twos_complement;
	output sign;
	output[2:0] exponent;
	output[3:0] significand;

	// wires to hold transient values
	wire[11:0] magnitude;
	wire[2:0] wire_exp;
	wire[3:0] wire_significand;
	wire MostSignificantCarryBit;

// instantating the submodules
// get the sign (after conversion from two's comp to sign magnitude
SignMagnitudeConverter SignMagnitudeConverter_Module(.twos_complement(twos_complement), .magnitude(magnitude), .sign(sign));
                
GetExponentSignificand GetExponentSignificand_Module(.magnitude(magnitude), .wire_exp(wire_exp), .MostSignificantCarryBit(MostSignificantCarryBit), .wire_significand(wire_significand));
                  
Round Round_Module(.wire_exp(wire_exp), .wire_significand(wire_significand), .MostSignificantCarryBit(MostSignificantCarryBit), .significand(significand), .exponent(exponent));

endmodule
