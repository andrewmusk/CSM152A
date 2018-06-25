`timescale 1ns / 1ps

module debouncer(
	input btn,
	input clk,
	output btn_state
    );
	 
reg btn_state_reg = 0;

reg [15:0] counter;

always @ (posedge clk)
begin
	if(btn == 0) 
	begin
		counter <= 0;
		btn_state_reg <= 0;
	end
	else
	begin
		counter <= counter + 1'b1;
		if(counter == 16'b0111111111111111) 
		begin
			btn_state_reg <= 1;
			counter <= 0;
		end
	end
end

assign btn_state = btn_state_reg;

endmodule