`timescale 1ns / 1ps

module DisplayController(
	btnR,
	btnU,
	btnL,
    DispVal,
    clock,
    anode,
    hex_out,
    dp,
	led
    );

	input btnR;
	input btnU;
	input btnL;
    input [3:0] DispVal;
    input clock;
    
    output [3:0] anode;
    output [3:0] hex_out;
    output [15:0] led;
    output dp;

	
	reg [3:0] anode = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
//	reg dp = 1'b1;
    reg [19:0] counter = 0;
    reg dp = 1'b1;
    reg [15:0] number = 16'hFFFF;
    reg [3:0] message = 4'h1;
    
   	integer digitr = 0;
   	integer digitl = 0;
   	integer prev_digitr = 0;
   	integer prev_digitl = 0;
   	integer digit = 0;
    
    integer try = 0;    	

	always @(posedge btnR) begin
	   digit <= digit + 1;
	end
	
	always @(posedge btnU) begin
//	   if(number[3:0] != 4'hF && number[7:4] != 4'hF && number[11:8] != 4'hF && number[15:12] != 4'hF) 
	       try <= try + 1;
	end
//	always @(posedge btnL) begin
//	   digitl <= digitl + 1;
//	end
	
	always @(posedge clock) begin
           counter <= counter + 1;
    end

	always @(*) begin
//	   if(digitl != prev_digitl && digitr != prev_digitr) begin
//	      prev_digitl = digitl;
//	      prev_digitr = digitr;
//	   end 
//	   else if(digitl != prev_digitl || digitr != prev_digitr) begin
//	       if(digitl != prev_digitl) digit = digit - 1;
//	       else if(digitr != prev_digitr) digit = digit + 1;
//	       prev_digitl = digitl;
//	       prev_digitr = digitr;
//	   end
       if (number[3:0] == 4'h1) led[15] = 1;
	   if (counter % 1000000 == 0) begin
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
                    else begin 
                         dp = 1'b1;
                         if(try == 3) message = 4'h2;
                         if(try == 5) message = 4'h3;
                         if(try == 7) message = 4'h4;
//                         number = 16'hFFFF;
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
                             if(try == 3) message = 4'h2;
                             if(try == 5) message = 4'h3;
                             if(try == 7) message = 4'h4;
//                             number = 16'hFFFF;
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
                             if(try == 3) message = 4'h2;
                             if(try == 5) message = 4'h3;
                             if(try == 7) message = 4'h4;
//                             number = 16'hFFFF;
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
                            if(try == 3) message = 4'h2;
                            if(try == 5) message = 4'h3;
                            if(try == 7) message = 4'h4;
//                            number = 16'hFFFF;
                            hex_out = message;
                        end
                    end
            endcase
        end
      end

endmodule
