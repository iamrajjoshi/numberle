`timescale 1ns / 1ps

module Numberle(
    clk,
	btnR,
	btnU,
	btnD,
    JA,
    an,
    seg,
    dp,
	led
    );
	 
	input btnR; // Right button
	input btnU; // Up button
	input btnD; // Down button

	output dp; // Decimal point on seven segment display
	input clk; // 100Mhz onboard clock
	inout [7:0] JA; // Port JA on Nexys3, JA[3:0] is Columns, JA[10:7] is rows
	output [3:0] an; // Anodes on seven segment display (enable)
	output [6:0] seg; // Cathodes on seven segment display
	output [15:0] led; // LEDs on Nexys3
	
	wire [3:0] an;
	wire [6:0] seg;
	wire [15:0] led;

	wire [3:0] hex_val;
	wire [3:0] keyboard_input;
	wire [15:0] random_number;

    wire debounced_btnR;
    wire debounced_btnU;
    wire debounced_btnL;
    wire debounced_btnD;
	
	// Get the input from the keyboard
	Keyboard_Input ki(
			.clock(clk),
			.Row(JA[7:4]),
			.Col(JA[3:0]),
			.out(keyboard_input),
	);

	// Debounce the buttons
    Debouncer R(
        .clock(clk),
        .in(btnR),
        .out(debounced_btnR)
    );
    
    Debouncer U(
        .clock(clk),
        .in(btnU),
        .out(debounced_btnU)
    );
    
    Debouncer D(
        .clock(clk),
        .in(btnD),
        .out(debounced_btnD)
    );
	
	// Generate a random number to guess
	RNG rng (
		.clock(clk),
        .random_number(random_number)
     );

	// Game logic and seven segment display logic
	Game game(
			.btnR(debounced_btnR),
			.btnU(debounced_btnU),
			.btnL(debounced_btnL),
			.btnD(debounced_btnD),
			.DispVal(keyboard_input),
			.clock(clk),
			.seven_segment_enable(an),
			.hex_out(hex_val),
			.dp(dp),
			.led(led),
			.random_number(random_number)
	);
	
	// Convert hex value to seven segment display
	Hex_To_LED h2l(
	       .hex(hex_val),
	       .seg(seg)
	);
	
endmodule
