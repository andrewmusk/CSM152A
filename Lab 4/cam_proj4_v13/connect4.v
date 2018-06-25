`timescale 1ns / 1ps
module connect4(
    input clk,
    input [10:0] PixelX,
    input [10:0] PixelY,
	 input [7:0] columns,
    input select,
	 input _1Hz_clk,
	 input _300clk,
	 input reset,
	 output reg [7:0] seven_segment,
	 output reg [3:0] anode_count,
    output reg [2:0] R,
    output reg [2:0] G,
    output reg [2:0] B
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
reg player;
reg new_player;
reg game_over = 0;
reg time_out = 0;
reg old_time_out = 0;
reg change = 0;

always @ (posedge _300clk) begin
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


always @ (posedge _1Hz_clk or posedge reset) begin
	if (reset) begin
		player <= 0;
		sec_1 <= 3;
		sec_0 <= 0;
	end
	else begin
		if (player != new_player && change == 1) begin
			  $display("WE HAVE A CHANGE IN THE CURRENT PLAYER");
			sec_1 <= 3;
			sec_0 <= 0;
			  player <= new_player;
		end
		else if (sec_1 == 0 && sec_0 == 0) begin
			sec_1 <= 3;
			player <= ~player;
		end
		else if (sec_0 == 0) begin
			sec_1 <= sec_1 - 1;
			sec_0 <= 9;
		end
		else begin
			sec_0 <= sec_0 - 1;
		end
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

reg  blockState [41:0];
reg  blockColor [41:0];
reg  winner [41:0];
wire [2:0] currColumn;

reg [5:0] i;	
reg [5:0] j;
reg [5:0] k;
initial begin
	$display("This is the initial display");
	for (i = 0; i < 42; i = i + 1) begin 
      blockState[i] = 0; 
		blockColor[i] = 0;
		winner[i] = 0;
	end
	player = 0;
	new_player = 0;
	sec_1 = 3;
	sec_0 = 0;
	count = 0;
end

encoder _currentColumn(
	.data(columns[7:0]),
	.clk(clk),
	.dec(currColumn)
);

reg [2:0] height;
reg [5:0] index;

reg [5:0] position;

reg [5:0] v;
reg [2:0] vertCount;
reg [5:0] vertInit;
reg vertCheck1;
reg vertCheck2;

reg [5:0] h;
reg [2:0] horiCount;
reg [5:0] horiInit;

reg [5:0] l;
reg [2:0] leftCount;
reg [5:0] leftInit;

reg [5:0] r;
reg [2:0] rightCount;
reg [5:0] rightInit;

reg [2:0] checkCount;

reg [5:0] h1;
reg [5:0] r1;
reg [5:0] l1;

always @(posedge select or posedge reset) begin
	if (reset) begin
		for(k=0 ; k<42 ; k=k+1) begin
			blockState[k] = 0;
			blockColor[k] = 0;
		end
		new_player <= 0;
		change <= 0;
		$display("the blockstate is %b", blockState);
		$display("the block color is %b", blockColor);
	end
	else begin
		if (change) begin
			if(new_player == player) begin
				change <= 0;
			end
		end
		if (player != new_player && change == 0)
		begin
			new_player <= player;
		end
		 if(currColumn!=0 && game_over == 0)
		 begin
			height = 0;
			index = ((currColumn-1)*6);
			for(k=0 ; k<42 ; k=k+1) begin
				if(k<index || k > index+5) begin
				end
				else begin
					if(blockState[k]==1) begin
						height = height + 1;
					end
				end
			end
			if(height<7) begin
				position = 6*(currColumn-1) + height;
				blockState[position] = 1;
				blockColor[position] = player;
				$display("the blockstate is %b", blockState);
				$display("the block color is %b", blockColor);
				new_player <= ~new_player;
				change <= 1;
				vertCount = 0;
				horiCount = 0;
				leftCount = 0;
				rightCount = 0;
				
				vertInit = (position -3);
				for(v=0; v<42; v = v + 1) begin
					if((v >= vertInit) && v <= position) begin
						if(blockState[v]==1 && blockColor[v]==player) begin
							vertCount=vertCount+1;
						end
					end
				end
				
				horiInit = (position -18);
				for(h= 0; h < 42; h=h+6) begin
					if(h >= horiInit && h <= (position+18)) begin
						if(h>=0&&h<=41) begin
							if(blockState[h]==1 && blockColor[h]==player) begin
								horiCount=horiCount+1;
							end
						end
					end
				end

				leftInit = (position - 15);
				for(l = 0; l < 42 ; l = l+5) begin
					if(l >= leftInit && l <= (position + 15)) begin
						if(l>=0&&l<=41) begin
							if(blockState[l]==1 && blockColor[l]==player) begin
								leftCount=leftCount+1;
							end
						end
					end
				end
				
				rightInit = (position - 21);
				for(r = 0; r < 42 ; r = r + 7) begin
					if(r >= rightInit && r <= (position+21)) begin
						if(r>=0&&r<=41) begin
							if(blockState[r]==1 && blockColor[r]==player) begin
								rightCount = rightCount+1;
							end
						end
					end
				end
				
				$display("The diagonal count is %d", rightCount);
				checkCount = 0;
				if(vertCount == 4) begin
					for(v = 0; v < 42; v = v + 1) begin
						if(v >= vertInit && v <= position) begin
							winner[v] = 1;
						end
					end
				end
				
				if(horiCount == 4) begin
					for(h= 0; h < 42; h = h + 6) begin
						if(h >= horiInit && h <= (position+18)) begin
							if(h >= 0 && h <= 41) begin
								if(blockState[h] == 1 && blockColor[h] == player && checkCount<4) begin
									winner[h] = 1;
									checkCount = checkCount + 1;
								end
								if(blockState[h] == 0 || blockColor[h] != player) begin
									if(h < position) begin
										checkCount = 0;
										for(h1 = 0; h1 < 42 ; h1 = h1 + 1) begin	
											winner[h1] = 0;
										end
									end
								end
							end
						end
					end
				end
				
				if(leftCount == 4) begin
					game_over = 1;
					for (l = 0; l < 42 ; l = l + 5) begin
						if (l >= leftInit && l <= (position + 15)) begin
							if (l>=0&&l<=41) begin
								if (blockState[l]==1 && blockColor[l]==player && checkCount<4) begin
									winner[l] = 1;
									checkCount = checkCount + 1;
								end
								if (blockState[l]==0 || blockColor[l]!=player) begin
									if (l < position) begin
										checkCount = 0;
										for(l1=0 ; l1 < 42 ; l1 = l1 + 1) begin	
											winner[l1] =0;
										end
									end
								end
							end
						end
					end
				end
				
				if(rightCount == 4) begin
					game_over = 1;
					for(r = 0; r < 42; r = r + 7) begin
						if(r >= rightInit && r <= (position+21)) begin
							if(r>=0&&r<=41) begin
								if(blockState[r]==1 && blockColor[r]==player && checkCount<4) begin
									winner[r] = 1;
									checkCount = checkCount + 1;
								end
								if(blockState[r]==0 || blockColor[r]!=player) begin
									if(r < position) begin
										checkCount = 0;
										for(r1=0 ; r1<42 ; r1=r1+1) begin	
											winner[r1] =0;
										end
									end
								end
							end
						end
					end 
				end
			end
		end
	end
end


// Display pixels
integer pixelCol;
integer pixelRow;
integer centerX;
integer centerY;

reg colorCheck;
reg valueCheck;
always @(posedge clk) begin

   pixelCol = (PixelX - 155) / 70;
   pixelRow = (6-(((PixelY - 90) / 70)+1));   
   
	if (PixelX < 155 || PixelX > 645 || PixelY < 90 || PixelY >= 510) begin
        // Show current player color on border
        if (player == 0) begin
            // Black border
            R = 3'b000;
            G = 3'b000;
            B = 2'b00;
            end
        else begin
            // Red border
            R = 3'b111;
            G = 3'b000;
            B = 2'b00;
            end
        end
    else if (blockState[pixelCol*6+pixelRow] == 1 &&
        ((PixelX - (190+pixelCol*70))*(PixelX - (190+pixelCol*70)) +
        (PixelY - (475-pixelRow*70))*(PixelY - (475-pixelRow*70))) <350) begin
        if (blockColor[(pixelCol*6)+pixelRow] == 0) begin
            R = 3'b000;
            G = 3'b000;
            B = 2'b00;
        end
        else if(blockColor[(pixelCol*6) + pixelRow] == 1) begin
            R = 3'b111;
            G = 3'b000;
            B = 2'b00;
        end
		  if(game_over && winner[(pixelCol*6) + pixelRow]) begin
				R = 3'b000;
            G = 3'b111;
            B = 2'b00;
        end
	 end
    else if (pixelCol % 2 == pixelRow % 2) begin
        R = 3'b111;
        G = 3'b111;
        B = 2'b00;
        if (pixelCol+1 == currColumn) begin
            R = 3'b111;
            G = 3'b111;
            B = 2'b11;
            end
        end
    else begin
        R = 3'b000;
        G = 3'b101;
        B = 2'b11;
        if (pixelCol+1 == currColumn) begin
            R = 3'b011;
            G = 3'b011;
            B = 2'b01;
        end
	 end
end
endmodule
