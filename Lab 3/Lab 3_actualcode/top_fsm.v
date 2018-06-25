`timescale 1ns / 1ps

module top_fsm(
	input clk,
	input rst,
	input pause,
	input [1:0]sel,
	input adjust,
	input [3:0] num,
	output reg [7:0] seven_seg,
	output reg [3:0] anode_count
   );

wire [3:0] sec0_count;
wire [3:0] sec1_count;
wire [3:0] min0_count;
wire [3:0] min1_count;

wire [7:0] seven_seg_min1;
wire [7:0] seven_seg_min0;
wire [7:0] seven_seg_sec1;
wire [7:0] seven_seg_sec0;

wire one_hz, two_hz, threehundred_hz;

wire rst_state, pause_state;

reg [1:0] count = 0;
	
debouncer rst_btn(
	.button(rst),
	.clk(clk),
	.button_output(rst_state)
	);

debouncer pause_btn(
	.button(pause),
	.clk(clk),
	.button_output(pause_state)
	);

clock_dividers divs(
	.onehundred_MHz_clk(clk),
	.rst(rst_state),
	.one_hz_clk(one_hz),
	.two_hz_clk(two_hz),
	.threehundred_hz_clk(threehundred_hz)
	);

counter stopwatch(
	.reset(rst_state),
	.pause(pause_state),
	.adjust(adjust),
	.select(sel),
	.clk(threehundred_hz),
	.num(num),
	.min0(min0_count),
	.min1(min1_count),
	.sec0(sec0_count),
	.sec1(sec1_count)
	);


/////////////////////////////////////////////////
// get 7-segment displays for each digit
/////////////////////////////////////////////////

seven_segment minute1(
	.digit(min1_count),
	.seven_seg(seven_seg_min1)
	);
	
seven_segment minute0 (
	.digit(min0_count),
	.seven_seg(seven_seg_min0)
	);
	
seven_segment second1 (
	.digit(sec1_count),
	.seven_seg(seven_seg_sec1)
	);
	
seven_segment second0(
	.digit(sec0_count),
	.seven_seg(seven_seg_sec0)
	);
	
wire [7:0] blank_digit = 8'b11111111;

/////////////////////////////////////////////
// rapidly cycle through digits
/////////////////////////////////////////////


always @ (posedge threehundred_hz) begin
	if (adjust) begin
		if (count == 3) begin
			anode_count <= 4'b0111;
			if (sel == 3 && adjust) begin
				if (two_hz) begin
					seven_seg <= seven_seg_min1;
				end
				else begin
					seven_seg <= blank_digit;
				end
			end
			else begin
				seven_seg <= seven_seg_min1;
			end
			count <= count + 1;
		end
		else if (count == 2) begin
			anode_count <= 4'b1011;
			if (sel == 2 && adjust) begin
				if (two_hz) begin
					seven_seg <= seven_seg_min0;
				end
				else begin
					seven_seg <= blank_digit;
				end
			end
			else begin
				seven_seg <= seven_seg_min0;
			end
			count <= count + 1;
		end
		else if (count == 1) begin
			anode_count <= 4'b1101;
			if (sel == 1 && adjust) begin
				if (two_hz) begin
					seven_seg <= seven_seg_sec1;
				end
				else begin
					seven_seg <= blank_digit;
				end
			end
			else begin
				seven_seg <= seven_seg_sec1;
			end
			count <= count + 1;
		end
		else if (count == 0) begin
			anode_count <= 4'b1110;
			if (sel == 0 && adjust) begin
				if (two_hz) begin
					seven_seg <= seven_seg_sec0;
				end
				else begin
					seven_seg <= blank_digit;
				end
			end
			else begin
				seven_seg <= seven_seg_sec0;
			end
			count <= count + 1;
		end
	end
	else begin
		if (count == 3) begin
			anode_count <= 4'b0111;
			seven_seg <= seven_seg_min1;
			count <= count + 1;
		end
		if (count == 2) begin
			anode_count <= 4'b1011;
			seven_seg <= seven_seg_min0;
			count <= count + 1;
		end
		if (count == 1) begin
			anode_count <= 4'b1101;
			seven_seg <= seven_seg_sec1;
			count <= count + 1;
		end
		if (count == 0) begin
			anode_count <= 4'b1110;
			seven_seg <= seven_seg_sec0;
			count <= count + 1;
		end
	end
end 
endmodule
