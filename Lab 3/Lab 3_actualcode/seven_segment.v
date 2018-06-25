`timescale 1ns / 1ps

module seven_segment(
	input wire [3:0] digit,
	output wire [7:0] seven_seg
    );

reg[7:0] SevenSeg;

always @ (*) begin
case(digit)    
	 4'd0: SevenSeg = 8'b11000000;
    4'd1: SevenSeg = 8'b11111001;
    4'd2: SevenSeg = 8'b10100100;
    4'd3: SevenSeg = 8'b10110000;
    4'd4: SevenSeg = 8'b10011001;
    4'd5: SevenSeg = 8'b10010010;
    4'd6: SevenSeg = 8'b10000010;
    4'd7: SevenSeg = 8'b11111000;
    4'd8: SevenSeg = 8'b10000000;
    4'd9: SevenSeg = 8'b10010000;
    default: SevenSeg = 8'b11111111;
endcase
end
assign seven_seg = SevenSeg;

endmodule
