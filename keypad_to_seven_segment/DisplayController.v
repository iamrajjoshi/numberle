`timescale 1ns / 1ps

module DisplayController(
	btnR,
	btnL,
    DispVal,
    clock,
    anode,
    hex_out,
	led
    );

	input btnR;
	input btnL;
    input [3:0] DispVal;
    input clock;
    
    output [3:0] anode;
    output [3:0] hex_out;
    output [15:0] led;

	
	reg [3:0] anode = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
	
    reg [19:0] counter = 0;

    reg [15:0] number = 16'hFFFF;
    
   	integer digit = 0;
	

	always @(posedge btnR) begin
	   digit <= digit + 1;
	end
	
	always @(posedge clock) begin
           counter <= counter + 1;
    end

	always @(*) begin 
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
                    if (number[3:0] != 4'hF) begin
                        anode = 4'b0111; 
                        hex_out = number[3:0]; // the first digit of the 16-bit number
                    end
                    else
                        anode = 4'b1111;
                    end
                2'b01: begin
                    if (number[7:4] != 4'hF) begin
                        anode = 4'b1011; 
                        hex_out = number[7:4]; // the second digit of the 16-bit number
                    end
                    else
                        anode = 4'b1111;
                    end
                2'b10: begin
                    if (number[11:8] != 4'hF) begin
                        anode = 4'b1101; 
                        hex_out = number[11:8]; // the third digit of the 16-bit number
                    end
                    else
                        anode = 4'b1111;
                    end
                2'b11: begin
                    if (number[15:12] != 4'hF) begin
                        anode = 4'b1110; 
                        hex_out = number[15:12]; // the fourth digit of the 16-bit number
                    end
                    else
                        anode = 4'b1111;
                    end
            endcase
        end
      end

endmodule
