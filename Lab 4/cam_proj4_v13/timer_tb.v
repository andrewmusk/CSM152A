`timescale 1ns / 1ps

module stopwatch_tb;
	 reg clk1;
	 reg clk50;
	 reg clk300;
	 reg [7:0] sw;	
	 reg select;
    reg [10:0] PixelX;
    reg [10:0] PixelY;
    reg vidon;
	 reg btnR;

	 wire Hsync;
    wire Vsync;
    wire  [2:0] vgaRed;
    wire  [2:0] vgaGreen;
    wire  [2:0] vgaBlue;
	 wire  [7:0] seg;
	 wire  [3:0] an;
	
wire clock;

wire [2:0] R;
wire [2:0] G;
wire [1:0] B;
connect4 _connect4(
    .clk(clk50),
    .PixelX(PixelX),
    .PixelY(PixelY),
	 .columns(sw),
    .select(select),
	 ._1Hz_clk(clk1),
	 ._300clk(clk300),
	 .reset(btnR),
	 .seven_segment(seg),
	 .anode_count(an),
    .R(R),
    .G(G),
    .B(B)
    );
    

vga _vga(
    .clk(clk50),
    .clr(clr),
    .hsync(Hs),
    .vsync(Vs),
    .PixelX(PixelX),
    .PixelY(PixelY),
    .vidon(vidon)
    );
	 
/*
	initial begin
		// Initialize Inputs
		clk1 = 0;
		clk50 = 0;
		clk300=0;
        PixelY = 490;
        PixelX = 180;
		sw = 8'b00000000;
		select = 0;
		#10
		
		sw =  8'b00000010;
		#5
		select = 1;
		#5
		select = 0; 
		#5
		
		sw =  8'b00000010;
		#5
		select = 1;
		#5
		select = 0; 
		#5
		
		sw =  8'b00000001;
		#5
		select = 1;
		#5
		select = 0; 
		#5
		
		sw =  8'b00000001;
		#5
		select = 1;
		#5
		select = 0; 
		$finish;

	end
*/
	always begin
		#10 clk300 = ~clk300;
	end
	
	always begin
		#1 clk50 = ~clk50;
	end
	
	always begin
		#100 clk1 = ~clk1;
	end
	
  /*
	initial begin
    clk1 = 0;
    clk50 = 0;
    clk300=0;
    PixelY = 490;
    PixelX = 180;
    sw = 8'b00000000;
    select = 0;
    #10

    sw = 8'b00000001;
    #5

    //1
    select = 1;
    #5
    select = 0;
    #5

    //2
    select = 1;
    #5
    select = 0;
    #5

    //3
    select = 1;
    #5
    select = 0;
    #5

    //4
    select = 1;
    #5
    select = 0;
	end
*/
/*
// reset test
initial begin
    clk1 = 0;
    clk50 = 0;
    clk300=0;
    PixelY = 490;
    PixelX = 180;
    sw = 8'b00000000;
    select = 0;
    #10

    sw = 8'b00000001;
    #5

    //1
    select = 1;
    #5
    select = 0;
    #5

    //2
    select = 1;
    #5
    select = 0;
    #5
	 
	 sw = 8'b00000010;
	 #5
	 
	 select = 1;
	 #5
	 select = 0;
	 #5

	 btnR = 1;
	 #20
	 btnR = 0;
	end
*/
/*
   // horizontal win check
  initial begin
    clk1 = 0;
    clk50 = 0;
    clk300=0;
    PixelY = 490;
    PixelX = 180;
    sw = 8'b00000000;
    select = 0;
    #10

    //1
    sw = 8'b01000000;
    #5
    select = 1;
    #5
    select = 0;
    #5

    //2
    sw = 8'b00100000;
    #5
    select = 1;
    #5
    select = 0;
    #5

    //3
    sw = 8'b00010000;
    #5
    select = 1;
    #5
    select = 0;
    #5

    //4
    sw = 8'b00001000;
    #5
    select = 1;
    #5
    select = 0;
  end
   */

   // Diagonal win check
  initial begin
    clk1 = 0;
    clk50 = 0;
    clk300=0;
    PixelY = 490;
    PixelX = 180;
    sw = 8'b00000000;
    select = 0;
    #7

    //2
    sw = 8'b00000010;
    #3
    select = 1;
    #3
    select = 0;
    #1
	 select = 1;
    #3
    select = 0;
    #1

    //3
    sw = 8'b00000100;
    #3
    select = 1;
    #3
    select = 0;
    #1
	 select = 1;
    #3
    select = 0;
    #1
	 select = 1;
    #1
    select = 0;
    #3

    //4
    sw = 8'b00001000;
    #1
    select = 1;
    #3
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 
	 //5
    sw = 8'b00010000;
    #1
    select = 1;
    #3
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 #1
    select = 1;
    #1
    select = 0;
	 #10
    select = 1;
    #5
    select = 0;
	 
	 sw = 8'b0000001;
    #3
    select = 1;	 
	 
  end   
endmodule