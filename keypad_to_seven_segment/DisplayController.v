`timescale 1ns / 1ps

module DisplayController(
	btnU,
    clock,
    anode,
    hex_out,
    dp,
	led
    );

	input btnU;
    input clock;
    
    output dp;
    output [3:0] anode;
    output [3:0] hex_out;
    output [15:0] led;

	reg [3:0] anode = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
	reg dp = 1'b1;
    reg [19:0] counter = 0;
    reg dp = 1'b1;
    reg [15:0] number = 16'hFFFF;
    reg [3:0] message = 4'h1;

    reg [15:0] guess = 16'h1234; 

    integer try = 0;    	
	
	always @(posedge btnU) begin
	       try <= try + 1;
	end
	
	always @(posedge clock) begin
           counter <= counter + 1;
    end

	InputLogic il(
		.btnR(debounced_btnR),
		.btnL(debounced_btnL),
		.DispVal(Decode),
		.clock(clk),
		.led(led),
        .number(number),
        .digit(digit),
        .try(try)
	);

	GameLogic gl(
		.clock(clk),
        .number(number),
        .try(try),
        .guess(guess),
        .message(message),
        .digit(digit),
        .led(led)
	);


	always @(*) begin
        if (counter % 100001 == 0) begin
            case(counter[19:18])
                2'b00: begin
                    anode = 4'b0111;
                    if(try % 2 == 0) begin 
                        if(digit == 0) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[3:0]; // the first digit of the 16-bit number
                    end
                    else begin 
                         dp = 1'b1;
                         hex_out = 4'hA;   
                    end
                  end
                2'b01: begin
                    anode = 4'b1011;
                    if(try % 2 == 0) begin  
                        if(digit == 1) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[7:4]; // the first digit of the 16-bit number
                    end
                    else begin 
                             dp = 1'b1;
                             hex_out = 4'hB;
                    end
                   end
                2'b10: begin
                    anode = 4'b1101;
                    if(try % 2 == 0) begin                     
                        if(digit == 2) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[11:8]; // the first digit of the 16-bit number
                        end
                        else begin 
                             dp = 1'b1;
                             hex_out = 4'hC;
                        end
                    end
                2'b11: begin
                    anode = 4'b1110;
                    if(try % 2 == 0) begin                        
                        if(digit == 3) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[15:12]; // the first digit of the 16-bit number
                        end
                        else begin
                            dp = 1'b1; 
                            hex_out = message;
                        end
                    end
            endcase
        end
      end

endmodule
