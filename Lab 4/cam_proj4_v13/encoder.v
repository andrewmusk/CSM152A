`timescale 1ns / 1ps

module encoder(
		input [7:0] data,
		input clk,
		output reg [2:0] dec
    );

always @(posedge clk) begin
		case(data)
			8'b00000001: dec = 3'b001;
			8'b00000010: dec = 3'b010;
			8'b00000100: dec = 3'b011;
			8'b00001000: dec = 3'b100;
			8'b00010000: dec = 3'b101;
			8'b00100000: dec = 3'b110;
			8'b01000000: dec = 3'b111;
			default: dec = 3'b000;
		endcase
end

endmodule
