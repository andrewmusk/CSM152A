`timescale 1ns / 1ps


module counter(
	input wire reset,
	input wire pause,
	input wire adjust,
	input wire [1:0] select,
	input wire clk,
	input wire [3:0] num,
	output wire [3:0] min0,
	output wire [3:0] min1,
	output wire [3:0] sec0,
	output wire [3:0] sec1
    );

	reg [3:0] min1_count = 4'b0000;
	reg [3:0] min0_count = 4'b0000;
	reg [3:0] sec1_count = 4'b0000;
	reg [3:0] sec0_count = 4'b0000;
	
	reg [7:0] counter = 0;
	reg paused = 0;
	reg wasAdjusting = 0;
	
	always @(posedge clk) begin
		if (~paused) begin
			if (~paused && counter >= 300) begin
					$display("made it");
					// increment seconds
					if (sec0_count == 9 && sec1_count == 5) begin
						// reset seconds
						sec0_count <= 0;
						sec1_count <= 0;
						// increment minutes
						if (min0_count == 9 && min1_count == 9) begin
							// reset minutes
							min0_count <= 4'b0;
							min1_count <= 4'b0;
						end
						else if (min0_count == 9) begin
							// overflow min
							min0_count <= 4'b0;
							min1_count <= min1_count + 1;
						end
						else begin
							min0_count <= min0_count + 1;
						end
					end
					else if (sec0_count == 9) begin
						// seconds overflow
						sec0_count <= 4'b0;
						sec1_count <= sec1_count + 1;
					end
					else begin
						sec0_count <= sec0_count + 1;
					end
					counter <= 0;
				//end
			end
			counter <= counter + 1;
		end
	end
	
	
	always @ (posedge pause or posedge adjust or posedge reset/* or negedge clk*/) begin
		if (reset) begin
			$display("made it reset");
			min0_count <= 4'b0000;
			min1_count <= 4'b0000;
			sec0_count <= 4'b0000;
			sec1_count <= 4'b0000;
			paused <= 0;
			counter <= 0;
		end
		else if (~adjust && wasAdjusting) begin
			$display("made it adjust");
			paused <= 0;
			wasAdjusting <= 0;
		end
		else begin
			$display("made it other");
			if (pause && ~adjust) begin
				paused <= ~paused;
			end
			else if (adjust) begin
				paused <= 1;
				wasAdjusting <= 1;
				if (pause) begin
					case(select)
						2'b00: sec0_count <= num;
						2'b01: sec1_count <= num;
						2'b10: min0_count <= num;
						2'b11: min1_count <= num;
						default: ;
					endcase
				end
			end
			//else begin
				/*if (~paused && counter >= 300) begin
					$display("made it");
					// increment seconds
					if (sec0_count == 9 && sec1_count == 5) begin
						// reset seconds
						sec0_count <= 0;
						sec1_count <= 0;
						// increment minutes
						if (min0_count == 9 && min1_count == 9) begin
							// reset minutes
							min0_count <= 4'b0;
							min1_count <= 4'b0;
						end
						else if (min0_count == 9) begin
							// overflow min
							min0_count <= 4'b0;
							min1_count <= min1_count + 1;
						end
						else begin
							min0_count <= min0_count + 1;
						end
					end
					else if (sec0_count == 9) begin
						// seconds overflow
						sec0_count <= 4'b0;
						sec1_count <= sec1_count + 1;
					end
					else begin
						sec0_count <= sec0_count + 1;
					end
					counter <= 0;
				end
				counter <= counter + 1;*/
			//end
		end
	end
	/*
	always @ (posedge clk) begin
		if (~paused) begin
			// increment seconds
			if (sec0_count == 9 && sec1_count == 5) begin
				// reset seconds
				sec0_count <= 0;
				sec1_count <= 0;
				
				// increment minutes
				if (min0_count == 9 && min1_count == 9) begin
					// reset minutes
					min0_count <= 4'b0;
					min1_count <= 4'b0;
				end
				else if (min0_count == 9) begin
					// overflow min
					min0_count <= 4'b0;
					min1_count <= min1_count + 1;
				end
				else begin
					min0_count <= min0_count + 1;
				end
			end
			else if (sec0_count == 9) begin
				// seconds overflow
				sec0_count <= 4'b0;
				sec1_count <= sec1_count + 1;
			end
			else begin
				sec0_count <= sec0_count + 1;
			end
		end	
	end
	*/
	
	assign min1 = min1_count;
	assign min0 = min0_count;
	assign sec1 = sec1_count;
	assign sec0 = sec0_count;

endmodule
