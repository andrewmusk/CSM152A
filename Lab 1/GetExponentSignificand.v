`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:49 04/17/2018 
// Design Name: 
// Module Name:    GetExponentSignificand 
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
module GetExponentSignificand(magnitude, wire_exp, MostSignificantCarryBit, wire_significand);
	// inputs, outputs, and local storage
	input[11:0] magnitude;
	// The	 next	 (fifth)	 bit	 then	 tells	 us	 whether	 to	 round	 up	 or	 down
	output MostSignificantCarryBit;
	output[2:0] wire_exp;
	output[3:0] wire_significand;
	reg takes;
	reg[3:0] temp;
	reg round_check;
   reg[3:0] significand_temp;
	
	// leading zeroes
	always @* begin
		if (magnitude[11]) begin
			temp = 4'b1000; // 8 
		end
		else if (magnitude[10]) begin
			temp = 4'b0111; // 7
		end
		else if (magnitude[9]) begin
			temp = 4'b0110;
		end
		else if (magnitude[8]) begin
			temp = 4'b0101;
		end
		else if (magnitude[7]) begin
			temp = 4'b0100;
		end
		else if (magnitude[6]) begin
			temp = 4'b0011;
		end
		else if (magnitude[5]) begin
			temp = 4'b0010;
		end
		else if (magnitude[4]) begin
			temp = 4'b0001;
		end	
		else 
			temp = 4'b0000;
		
		// find the significand 
		case (temp)
			4'b0111: begin
				significand_temp = magnitude[10:7];
			end
			4'b0110: begin
				significand_temp = magnitude[9:6];
			end
			4'b0101: begin
				significand_temp = magnitude[8:5];
			end
			4'b0100: begin
				significand_temp = magnitude[7:4];
			end
			4'b0011: begin
				significand_temp = magnitude[6:3];
			end
			4'b0010: begin
				significand_temp = magnitude[5:2];
			end
			4'b0001: begin
				significand_temp = magnitude[4:1];
			end
			default: begin
				significand_temp = magnitude[3:0];
			end
		endcase
		
		case (temp)
			4'b0111: begin
				round_check = magnitude[6]; 
			end
			4'b0110: begin
				round_check = magnitude[5]; 
			end
			4'b0101: begin
				round_check = magnitude[4]; 
			end
			4'b0100: begin
				round_check = magnitude[3]; 
			end
			4'b0011: begin
				round_check = magnitude[2]; 
			end
			4'b0010: begin
				round_check = magnitude[1]; 
			end
			4'b0001: begin
				round_check = magnitude[0]; 
			end
			default: begin
				round_check = 0; 
			end
		endcase

		if (temp == 4'b1000) begin
			round_check = 0;
			temp = 4'b0111;
			significand_temp = 4'b1111;
		end
	end

	assign wire_significand = significand_temp;
	assign wire_exp = temp;
	assign MostSignificantCarryBit = round_check;

endmodule
