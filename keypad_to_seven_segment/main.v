`timescale 1ns / 1ps

module PmodKYPD(
    clk,
	btnR,
	btnL,
    JA,
    an,
    seg,
	led
    );
	 
	input btnR;
	input btnL;
	input clk;					// 100Mhz onboard clock
	inout [7:0] JA;			// Port JA on Nexys3, JA[3:0] is Columns, JA[10:7] is rows
	output [3:0] an;			// Anodes on seven segment display
	output [6:0] seg;			// Cathodes on seven segment display
	output [15:0] led;
	
	wire [3:0] an;
	wire [6:0] seg;
	wire [3:0] hex_val;
	wire [3:0] Decode;
	wire [15:0] led;

    wire debounced_btnR;
    wire debounced_btnL;

	Decoder decoder(
			.clk(clk),
			.Row(JA[7:4]),
			.Col(JA[3:0]),
			.DecodeOut(Decode),
			.btnR(debounced_btnR),
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

	DisplayController dc(
			.btnR(debounced_btnR),
			.btnL(debounced_btnL),
			.DispVal(Decode),
			.clock(clk),
			.anode(an),
			.hex_out(hex_val),
			.led(led)
	);
	
	HexToLED h2l(
	       .hex(hex_val),
	       .seg(seg)
	);
	       

endmodule
