`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:26 04/17/2018 
// Design Name: 
// Module Name:    Round 
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
module Round(wire_exp, wire_significand, MostSignificantCarryBit, significand, exponent);
	// inputs and outputs
	input[2:0] wire_exp;
	input[3:0] wire_significand;
	input MostSignificantCarryBit;
	output[2:0] exponent;
	output[3:0] significand;
	reg[3:0] y;
	reg[1:0] x;
	reg[3:0] temp_exp;
	reg[4:0] sum;

	always @* begin
		if (x[1])
			y = 4'b1000;
	end

	always @* begin
		if (wire_exp == 3'b111 && wire_significand == 4'b1111  && MostSignificantCarryBit) begin
			sum = 5'b01111;
			temp_exp = 4'b0111;
		end
		else begin
			if (MostSignificantCarryBit) begin
				sum = wire_significand + 1;
			end
			else begin
				sum = wire_significand;				
			end 
			if (sum[4]) begin
				temp_exp = wire_exp + 1;
				sum = sum >> 1;
			end
			else
				temp_exp = wire_exp;	
		end
	end
 
	assign significand = sum[3:0];
	assign exponent = temp_exp;

endmodule
