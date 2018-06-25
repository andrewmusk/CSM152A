`timescale 1ns / 1ps
module clock(
    input clk_in, 
    output clk_out50,
	 output clk_out1, 
	 output clk_out300
    );

reg out_clk50;
reg out_clk1; 
reg out_clk300;
reg [31:0] counter; 
reg [31:0] counter_300;

initial begin
	counter <= 0;
	out_clk50 <= 0;
	out_clk1 <=0;
	out_clk300 <= 0;
end

always @(posedge clk_in) begin
	out_clk50 <= ~out_clk50;
	if (counter == 55000000 ) begin
		counter <= 0;
		out_clk1 <= ~out_clk1;
	end
	else
		counter <= counter + 1;
	if (counter_300 == 233333) begin
		counter_300 <= 0;
		out_clk300 <= ~out_clk300;
	end
	else
		counter_300 <= counter_300 + 1;
end


assign clk_out1 = out_clk1;  
assign clk_out50 = out_clk50;
assign clk_out300 = out_clk300; 

endmodule
