`timescale 1ns / 1ps

module clock_dividers(
	input wire onehundred_MHz_clk,
	input wire rst,
	output wire one_hz_clk,
	output wire two_hz_clk,
	output wire threehundred_hz_clk
    );
	 
	reg one_hz_clk_reg;
	reg two_hz_clk_reg;
	reg threehundred_hz_clk_reg;

	reg [31:0] one_counter;
	reg [31:0] two_counter;
	reg [31:0] threehundred_counter;	
	
	always @ (posedge(onehundred_MHz_clk) or posedge(rst))
	begin
		if(rst)
		begin
			one_counter <= 32'b0;
			one_hz_clk_reg <= 0;
			two_counter <= 32'b0;
			two_hz_clk_reg <= 0;
			threehundred_counter <= 32'b0;
			threehundred_hz_clk_reg <= 0;
		end
		else begin
			if(one_counter == 100000000)
			begin
				one_counter <= 32'b0;
				one_hz_clk_reg <= ~one_hz_clk;
			end
			else begin
				one_counter <= one_counter + 1;
				one_hz_clk_reg <= one_hz_clk;
			end
			if(two_counter == 50000000)
			begin
				two_counter <= 32'b0;
				two_hz_clk_reg <= ~two_hz_clk;
			end
			else begin
				two_counter <= two_counter + 1;
				two_hz_clk_reg <= two_hz_clk;
			end
			if (threehundred_counter == 333333) begin
				threehundred_counter <= 32'b0;
				threehundred_hz_clk_reg <= ~threehundred_hz_clk;
			end
			else begin
				threehundred_counter <= threehundred_counter + 1;
				threehundred_hz_clk_reg <= threehundred_hz_clk;
			end	
		end	
	end

	assign two_hz_clk = two_hz_clk_reg;
	assign one_hz_clk = one_hz_clk_reg;
	assign threehundred_hz_clk = threehundred_hz_clk_reg;

endmodule
