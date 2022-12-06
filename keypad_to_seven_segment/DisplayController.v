`timescale 1ns / 1ps

module DisplayController(
    btnR,
	btnU,
	btnL,
	btnD,
	DispVal,
    clock,
    anode,
    hex_out,
    dp,
	led,
	final_guess
    );

    input btnR;
	input btnU;
	input btnL;
	input btnD;
    input clock;
    input[15:0] final_guess;
    
    output [3:0] DispVal;
    output dp;
    output [3:0] anode;
    output [3:0] hex_out;
    output [15:0] led;
    
	reg [3:0] anode = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
	reg dp = 1'b1;
    reg [19:0] counter = 0;
    
    reg [3:0] message = 4'h1;
    reg [3:0] game_message = 4'h1;
    reg [15:0] number = 16'hFFFF;
    reg [15:0] guess = 16'hEEEE; 
    
    integer digit = 0;
    integer prev_try = 0;
    integer try = 0;    	
	
	reg reset;
    reg guess_flag = 1'b0;
    parameter c_NUM_BITS = 16;

	always @(posedge btnU) begin
	       try <= try + 1;
	end
	
	
	always @(posedge btnD) begin
	       guess = 16'h7642;
           if (guess[3:0] > 4'h9) guess[3] = 1'b0;
           if (guess[7:4] > 4'h9) guess[7] = 1'b0;
           if (guess[11:8] > 4'h9) guess[11] = 1'b0;
           if (guess[15:12] > 4'h9) guess[15] = 1'b0; 
	end
	
	always @(posedge clock) begin
           counter <= counter + 1;
    end

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

    always @(*) begin
	    if (counter % 1000000 == 0 && try % 2 == 0) begin
	        case (DispVal)
					4'h0 : begin
                          if (digit == 0) number[3:0] = 4'h0;
                          else if (digit == 1) number[7:4] = 4'h0;
                          else if (digit == 2) number[11:8] = 4'h0;
                          else if (digit == 3) number[15:12] = 4'h0;
					end 
					4'h1 : begin
                          if (digit == 0) number[3:0] = 4'h1;
                          else if (digit == 1) number[7:4] = 4'h1;
                          else if (digit == 2) number[11:8] = 4'h1;
                          else if (digit == 3) number[15:12] = 4'h1;    
					end
	   				4'h2 : begin
                          if (digit == 0) number[3:0] = 4'h2;
                          else if (digit == 1) number[7:4] = 4'h2;
                          else if (digit == 2) number[11:8] = 4'h2;
                          else if (digit == 3) number[15:12] = 4'h2;   
					end
					4'h3 : begin
                          if (digit == 0) number[3:0] = 4'h3;
                          else if (digit == 1) number[7:4] = 4'h3;
                          else if (digit == 2) number[11:8] = 4'h3;
                          else if (digit == 3) number[15:12] = 4'h3;
					end
					4'h4 : begin
                          if (digit == 0) number[3:0] = 4'h4;
                          else if (digit == 1) number[7:4] = 4'h4;
                          else if (digit == 2) number[11:8] = 4'h4;
                          else if (digit == 3) number[15:12] = 4'h4;
					end
					4'h5 : begin
                          if (digit == 0) number[3:0] = 4'h5;
                          else if (digit == 1) number[7:4] = 4'h5;
                          else if (digit == 2) number[11:8] = 4'h5;
                          else if (digit == 3) number[15:12] = 4'h5;
					end 
					4'h6 : begin
                          if (digit == 0) number[3:0] = 4'h6;
                          else if (digit == 1) number[7:4] = 4'h6;
                          else if (digit == 2) number[11:8] = 4'h6;
                          else if (digit == 3) number[15:12] = 4'h6;
					end 
					4'h7 : begin
                          if (digit == 0) number[3:0] = 4'h7;
                          else if (digit == 1) number[7:4] = 4'h7;
                          else if (digit == 2) number[11:8] = 4'h7;
                          else if (digit == 3) number[15:12] = 4'h7;
					end
					4'h8 : begin 
                          if (digit == 0) number[3:0] = 4'h8;
                          else if (digit == 1) number[7:4] = 4'h8;
                          else if (digit == 2) number[11:8] = 4'h8;
                          else if (digit == 3) number[15:12] = 4'h8;
					end
					4'h9 : begin  
                          if (digit == 0) number[3:0] = 4'h9;
                          else if (digit == 1) number[7:4] = 4'h9;
                          else if (digit == 2) number[11:8] = 4'h9;
                          else if (digit == 3) number[15:12] = 4'h9;
					end
					4'hF : begin  
                          if (digit == 0) number[3:0] = 4'hF;
                          else if (digit == 1) number[7:4] = 4'hF;
                          else if (digit == 2) number[11:8] = 4'hF;
                          else if (digit == 3) number[15:12] = 4'hF;
					end				
			endcase
		end
    end
    
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
                    anode = 4'b1011;
                    if(try % 2 == 0) begin  
                        if(digit == 1) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[7:4]; // the first digit of the 16-bit number
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
                    anode = 4'b1101;
                    if(try % 2 == 0) begin                     
                        if(digit == 2) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[11:8]; // the first digit of the 16-bit number
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
                    anode = 4'b1110;
                    if(try % 2 == 0) begin                        
                        if(digit == 3) dp = 1'b0;
                        else dp = 1'b1;
                        hex_out = number[15:12]; // the first digit of the 16-bit number
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
      
 //Game logic
       
 
      always @(*) begin
        if(try % 2 == 1) begin
            led = 16'h0000;
            if (number[3:0] < guess[3:0]) led[15] = 1;  
            else if (number[3:0] == guess[3:0]) led[14] = 1;
            else if (number[3:0] > guess[3:0]) led[13] = 1;  
            else begin
                led[15] = 0;
                led[14] = 0;
                led[13] = 0;
            end
            
            if (number[7:4] < guess[7:4]) led[12] = 1;  
            else if (number[7:4] == guess[7:4]) led[11] = 1;
            else if (number[7:4] > guess[7:4]) led[10] = 1;  
            else begin
                led[12] = 0;
                led[11] = 0;
                led[10] = 0;
            end
            
            if (number[11:8] < guess[11:8]) led[9] = 1;  
            else if (number[11:8] == guess[11:8]) led[8] = 1;
            else if (number[11:8] > guess[11:8]) led[7] = 1;  
            else begin
                led[9] = 0;
                led[8] = 0;
                led[7] = 0;
            end
            
            if (number[15:12] < guess[15:12]) led[6] = 1;  
            else if (number[15:12] == guess[15:12]) led[5] = 1;
            else if (number[15:12] > guess[15:12]) led[4] = 1;  
            else begin
                led[6] = 0;
                led[5] = 0;
                led[4] = 0;
            end
     
            if (number == guess) begin
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