`timescale 1ns / 1ps

module debouncer(
	input button,
	input clk,
	output button_output
    );
	 
reg output_reg = 0;
reg [15:0] incrementer;

always @ (posedge clk)
begin
	if (~button) begin
		incrementer <= 0;
		output_reg <= 0;
	end
	else begin
		incrementer <= incrementer + 1;
		if (incrementer == 16'hffff) begin
			output_reg <= 1;
			incrementer <= 0;
		end
	end
end

assign button_output = output_reg;

endmodule
