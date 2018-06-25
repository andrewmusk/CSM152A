`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:20 04/17/2018 
// Design Name: 
// Module Name:    SignMagnitudeConverter 
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
module SignMagnitudeConverter(twos_complement, magnitude, sign);    
	// inputs and outputs
	input[11:0] twos_complement;
	output[11:0] magnitude;
	output sign;
	reg[11:0] temp;
	reg[3:0] check_overflow;
	
	always @* begin
	// flip and add 1 if twos_complement MSB is high
		if (twos_complement[11])
			temp = ~twos_complement + 12'b000000000001;
		else
			temp = twos_complement;
	end
	
	assign sign = twos_complement[11];
	assign magnitude = temp;
endmodule
