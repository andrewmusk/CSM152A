`timescale 1ns / 1ps
module timer(
	input _50MHz_clk,
	input player,
	input move,
	input _1Hz_clk,
	output reg [7:0] seven_segment,
	output reg [3:0] anode_count,
	output player_change
   );

reg [3:0] sec_0;
reg [3:0] sec_1;
reg [1:0] count;
reg [7:0] seven_seg_sec_1;
reg [7:0] seven_seg_sec_0;
reg [7:0] seven_seg_one = 8'b11111001;
reg [7:0] seven_seg_two = 8'b10100100;
reg [7:0] seven_seg_p = 8'b10001100;
reg [3:0] an_cnt;
reg [7:0] sev_seg;
reg change = 0;
reg old_move = 0;

assign player_change = change;

initial begin
	sec_1 <= 3;
	sec_0 <= 0;
	count <= 0;	
end


always @ (posedge _50MHz_clk) begin
	case(count) 
		0: begin
			anode_count <= 4'b1110;
			seven_segment <= seven_seg_sec_0;
		end
		1: begin
			anode_count <= 4'b1101;
			seven_segment <= seven_seg_sec_1;
		end
		2: begin
			anode_count <= 4'b1011;
			if (player == 0)
				seven_segment <= seven_seg_one;
			else
				seven_segment <= seven_seg_two;
		end
		3: begin
			anode_count <= 4'b0111;
			seven_segment <= seven_seg_p;
		end
	endcase
	count <= count + 1;
end


always @ (posedge _1Hz_clk) begin
	if (move != old_move) begin
		sec_1 <= 3;
		sec_0 <= 0;
		old_move <= ~old_move;
	end
	else if (sec_1 == 0 && sec_0 == 0) begin
		sec_1 <= 3;
		change <= ~change;
	end
	else if (sec_0 == 0) begin
		sec_1 <= sec_1 - 1;
		sec_0 <= 9;
	end
	else begin
		sec_0 <= sec_0 - 1;
	end
end

always @ (*) begin
	case(sec_0)    
		 4'd0: seven_seg_sec_0 = 8'b11000000;
		 4'd1: seven_seg_sec_0 = 8'b11111001;
		 4'd2: seven_seg_sec_0 = 8'b10100100;
		 4'd3: seven_seg_sec_0 = 8'b10110000;
		 4'd4: seven_seg_sec_0 = 8'b10011001;
		 4'd5: seven_seg_sec_0 = 8'b10010010;
		 4'd6: seven_seg_sec_0 = 8'b10000010;
		 4'd7: seven_seg_sec_0 = 8'b11111000;
		 4'd8: seven_seg_sec_0 = 8'b10000000;
		 4'd9: seven_seg_sec_0 = 8'b10010000;
	endcase
end

always @ (*) begin
	case(sec_1)    
		 4'd0: seven_seg_sec_1 = 8'b11000000;
		 4'd1: seven_seg_sec_1 = 8'b11111001;
		 4'd2: seven_seg_sec_1 = 8'b10100100;
		 4'd3: seven_seg_sec_1 = 8'b10110000;
		 4'd4: seven_seg_sec_1 = 8'b10011001;
		 4'd5: seven_seg_sec_1 = 8'b10010010;
		 4'd6: seven_seg_sec_1 = 8'b10000010;
		 4'd7: seven_seg_sec_1 = 8'b11111000;
		 4'd8: seven_seg_sec_1 = 8'b10000000;
		 4'd9: seven_seg_sec_1 = 8'b10010000;
	endcase
end

endmodule
