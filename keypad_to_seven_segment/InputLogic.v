`timescale 1ns / 1ps

module InputLogic(
	btnR,
	btnL,
    DispVal,
    clock,
	led,
    number,
    digit,
    try
);

// wires and registers
input btnR;
input btnL;
input [3:0] DispVal;
input clock;
input try;
output number;
output digit;

integer digit = 0;

reg [15:0] number = 16'hFFFF;
reg [19:0] counter = 0;


always @(posedge btnR) begin
	   digit <= digit + 1;
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

endmodule