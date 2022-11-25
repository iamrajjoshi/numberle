`timescale 1ns / 1ps

module PmodKYPD(
    clk,
	btnR,
	btnU,
	btnL,
    JA,
    an,
    seg,
    dp,
	led
    );
	 
	input btnR;
	input btnU;
	input btnL;
	output dp;
	input clk;					// 100Mhz onboard clock
	inout [7:0] JA;			    // Port JA on Nexys3, JA[3:0] is Columns, JA[10:7] is rows
	output [3:0] an;			// Anodes on seven segment display
	output [6:0] seg;			// Cathodes on seven segment display
	output [15:0] led;
	
	wire [3:0] an;
	wire [6:0] seg;
	wire [3:0] hex_val;
	wire [3:0] Decode;
	wire [15:0] led;

    wire debounced_btnR;
    wire debounced_btnU;
    wire debounced_btnL;

	integer digit = 0;

	Decoder decoder(
		.clk(clk),
		.Row(JA[7:4]),
		.Col(JA[3:0]),
		.DecodeOut(Decode),
		.btnR(debounced_btnR)
	);

    Debouncing debouncerR(
        .clk(clk),
        .pb_1(btnR),
        .pb_out(debounced_btnR)
    );
    
    Debouncing debouncerL(
        .clk(clk),
        .pb_1(btnL),
        .pb_out(debounced_btnL)
    );
    
    Debouncing debouncerU(
        .clk(clk),
        .pb_1(btnU),
        .pb_out(debounced_btnU)
    );

	DisplayController dc(
		.btnU(debounced_btnU),
		.clock(clk),
		.anode(an),
		.hex_out(hex_val),
		.dp(dp),
		.led(led)
	);
	
	HexToLED h2l(
	       .hex(hex_val),
	       .seg(seg)
	);
	       

endmodule
