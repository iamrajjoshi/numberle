// Game logic and seven segment display logic

`timescale 1ns / 1ps

module Game(
    clock, // Clock
    btnR, // Right button (debounced)
	btnU, // Up button (debounced)
	btnD, // Down button (debounced)
	keyboard_input, // Input from the keyboard    
    seven_segment_enable, // Enable for each of the seven segments
    hex_out, // Output to the seven segments
    dp, // Decimal point for the seven segments
	led, // Output to the LEDs
	random_number // Random user_guess from the random user_guess generator
    );

    input btnR;
	input btnU;
	input btnD;
    input clock;
    input[15:0] random_number;
    
    output [3:0] keyboard_input;
    output dp;
    output [3:0] seven_segment_enable;
    output [3:0] hex_out;
    output [15:0] led;
    
	reg [3:0] seven_segment_enable = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
	reg dp = 1'b1;
    
    reg [19:0] counter = 0; // Counter for the clock
    reg [3:0] message = 4'h1; // Message to display on the seven segment display
    reg [15:0] user_guess = 16'hFFFF; // User's target_number
    reg [15:0] target_number = 16'hEEEE; 
    
    integer digit = 0; // Which digit of the target_number is being guessed
    integer prev_try = 0; // Previous try
    integer try = 0; // Number of tries
	
    // When the right button is pressed, the user_guess is checked and we increment the try counter
	always @(posedge btnU) begin
	       try <= try + 1;
	end
	
	// When the down button is pressed, the target_number is reset to a random numberk, which we mod 10 to make sure it is less than 10
	always @(posedge btnD) begin
	       target_number = random_number;
           if (target_number[3:0] > 4'h9) target_number[3] = 1'b0;
           if (target_number[7:4] > 4'h9) target_number[7] = 1'b0;
           if (target_number[11:8] > 4'h9) target_number[11] = 1'b0;
           if (target_number[15:12] > 4'h9) target_number[15] = 1'b0; 
	end
	
	// Counter for the clock
    always @(posedge clock) begin
           counter <= counter + 1;
    end

    // Allow user to enter next digit in their guess, wrap around to first digit if they enter 4 digits or if they just finished a try
	always @(posedge btnR) begin
	       digit <= digit + 1;
	       if(prev_try != try && try % 2 == 0) begin
	           digit <= 0;
	           prev_try <= try;
	       end
           else if(digit == 4) begin
               digit <= 0;
           end 
    end


    // Save each digit of the user's guess to the user_guess register
    always @(*) begin
	    if (counter % 1000000 == 0 && try % 2 == 0) begin
	        case (keyboard_input)
					4'h0 : begin
                          if (digit == 0) user_guess[3:0] = 4'h0;
                          else if (digit == 1) user_guess[7:4] = 4'h0;
                          else if (digit == 2) user_guess[11:8] = 4'h0;
                          else if (digit == 3) user_guess[15:12] = 4'h0;
					end 
					4'h1 : begin
                          if (digit == 0) user_guess[3:0] = 4'h1;
                          else if (digit == 1) user_guess[7:4] = 4'h1;
                          else if (digit == 2) user_guess[11:8] = 4'h1;
                          else if (digit == 3) user_guess[15:12] = 4'h1;    
					end
	   				4'h2 : begin
                          if (digit == 0) user_guess[3:0] = 4'h2;
                          else if (digit == 1) user_guess[7:4] = 4'h2;
                          else if (digit == 2) user_guess[11:8] = 4'h2;
                          else if (digit == 3) user_guess[15:12] = 4'h2;   
					end
					4'h3 : begin
                          if (digit == 0) user_guess[3:0] = 4'h3;
                          else if (digit == 1) user_guess[7:4] = 4'h3;
                          else if (digit == 2) user_guess[11:8] = 4'h3;
                          else if (digit == 3) user_guess[15:12] = 4'h3;
					end
					4'h4 : begin
                          if (digit == 0) user_guess[3:0] = 4'h4;
                          else if (digit == 1) user_guess[7:4] = 4'h4;
                          else if (digit == 2) user_guess[11:8] = 4'h4;
                          else if (digit == 3) user_guess[15:12] = 4'h4;
					end
					4'h5 : begin
                          if (digit == 0) user_guess[3:0] = 4'h5;
                          else if (digit == 1) user_guess[7:4] = 4'h5;
                          else if (digit == 2) user_guess[11:8] = 4'h5;
                          else if (digit == 3) user_guess[15:12] = 4'h5;
					end 
					4'h6 : begin
                          if (digit == 0) user_guess[3:0] = 4'h6;
                          else if (digit == 1) user_guess[7:4] = 4'h6;
                          else if (digit == 2) user_guess[11:8] = 4'h6;
                          else if (digit == 3) user_guess[15:12] = 4'h6;
					end 
					4'h7 : begin
                          if (digit == 0) user_guess[3:0] = 4'h7;
                          else if (digit == 1) user_guess[7:4] = 4'h7;
                          else if (digit == 2) user_guess[11:8] = 4'h7;
                          else if (digit == 3) user_guess[15:12] = 4'h7;
					end
					4'h8 : begin 
                          if (digit == 0) user_guess[3:0] = 4'h8;
                          else if (digit == 1) user_guess[7:4] = 4'h8;
                          else if (digit == 2) user_guess[11:8] = 4'h8;
                          else if (digit == 3) user_guess[15:12] = 4'h8;
					end
					4'h9 : begin  
                          if (digit == 0) user_guess[3:0] = 4'h9;
                          else if (digit == 1) user_guess[7:4] = 4'h9;
                          else if (digit == 2) user_guess[11:8] = 4'h9;
                          else if (digit == 3) user_guess[15:12] = 4'h9;
					end
					4'hF : begin  
                          if (digit == 0) user_guess[3:0] = 4'hF;
                          else if (digit == 1) user_guess[7:4] = 4'hF;
                          else if (digit == 2) user_guess[11:8] = 4'hF;
                          else if (digit == 3) user_guess[15:12] = 4'hF;
					end				
			endcase
		end
    end
    
    // 7-segment display driver
    // If the user just guessed a number, display the number of tries
    // If user lost, display "LOSE"
	always @(*) begin
        if (counter % 100001 == 0) begin
            case(counter[19:18])
                2'b00: begin
                    seven_segment_enable = 4'b0111;
                    if(try % 2 == 0) begin 
                        if(digit == 0) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = user_guess[3:0];
                    end
                    else if (message == 4'hF) begin
                        dp = 1'b1;
                        hex_out = 4'hD;
                    end
                    else begin 
                         dp = 1'b1;
                         hex_out = 4'hA;   
                    end
                  end
                2'b01: begin
                    seven_segment_enable = 4'b1011;
                    if(try % 2 == 0) begin  
                        if(digit == 1) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = user_guess[7:4];
                    end
                    else if (message == 4'hF) begin
                        dp = 1'b1;
                        hex_out = 4'h0;
                    end
                    else begin 
                             dp = 1'b1;
                             hex_out = 4'hB;
                    end
                   end
                2'b10: begin
                    seven_segment_enable = 4'b1101;
                    if(try % 2 == 0) begin                     
                        if(digit == 2) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = user_guess[11:8];
                        end
                        else if (message == 4'hF) begin
                            dp = 1'b1;
                            hex_out = 4'h5;
                        end
                        else begin 
                             dp = 1'b1;
                             hex_out = 4'hC;
                        end
                    end
                2'b11: begin
                    seven_segment_enable = 4'b1110;
                    if(try % 2 == 0) begin                        
                        if(digit == 3) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = user_guess[15:12];
                        end
                        else if (message == 4'hF) begin
                            dp = 1'b1;
                            hex_out = 4'hE;
                        end
                        else begin
                            dp = 1'b1; 
                            hex_out = message;
                        end
                    end
            endcase
        end
    end
      
 
    // Game logic
    always @(*) begin
        if(try % 2 == 1) begin
            led = 16'h0000;
            if (user_guess[3:0] < target_number[3:0]) led[15] = 1;  
            else if (user_guess[3:0] == target_number[3:0]) led[14] = 1;
            else if (user_guess[3:0] > target_number[3:0]) led[13] = 1;  
            else begin
                led[15] = 0;
                led[14] = 0;
                led[13] = 0;
            end
            
            if (user_guess[7:4] < target_number[7:4]) led[12] = 1;  
            else if (user_guess[7:4] == target_number[7:4]) led[11] = 1;
            else if (user_guess[7:4] > target_number[7:4]) led[10] = 1;  
            else begin
                led[12] = 0;
                led[11] = 0;
                led[10] = 0;
            end
            
            if (user_guess[11:8] < target_number[11:8]) led[9] = 1;  
            else if (user_guess[11:8] == target_number[11:8]) led[8] = 1;
            else if (user_guess[11:8] > target_number[11:8]) led[7] = 1;  
            else begin
                led[9] = 0;
                led[8] = 0;
                led[7] = 0;
            end
            
            if (user_guess[15:12] < target_number[15:12]) led[6] = 1;  
            else if (user_guess[15:12] == target_number[15:12]) led[5] = 1;
            else if (user_guess[15:12] > target_number[15:12]) led[4] = 1;  
            else begin
                led[6] = 0;
                led[5] = 0;
                led[4] = 0;
            end
        
            if (user_guess == target_number) begin
                led = 16'hFFFF;
            end
            if(try == 1) message = 4'h1;
            else if(try == 3) message = 4'h2;
            else if(try == 5) message = 4'h3;
            else if(try == 7) message = 4'h4;
            else if(try == 9) message = 4'h5;
            else if(try == 11) message = 4'h6;
            else if(try == 13) message = 4'h7;
            else message = 4'hF;
        end
    end

endmodule
