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
	reg [15:0] led = 16'hffff;
	
    reg [19:0] counter = 0;
    wire [1:0] LED_activating_counter;
    assign LED_activating_counter = counter[19:18];

    reg [15:0] number = 4'h0000;
    
   	integer i = 0;
	

	always @(posedge btnR) begin
	   i <= i + 4;
	end
	
	always @(posedge clock) begin
           counter <= counter + 1;
    end

	always @(*) begin 
	   if (counter % 1000000 == 0) begin
	        case (DispVal)
					4'h0 : begin
                          if(i == 0) number[3:0] = 4'h0;
                          else if(i == 4) number[7:4] = 4'h0;
                          else if(i == 8) number[11:8] = 4'h0;
                          else if(i == 12) number[15:12] = 4'h0;
					end 
					4'h1 : begin
                          if(i == 0) number[3:0] = 4'h1;
                          else if(i == 4) number[7:4] = 4'h1;
                          else if(i == 8) number[11:8] = 4'h1;
                          else if(i == 12) number[15:12] = 4'h1;    
					end
	   				4'h2 : begin
                          if(i == 0) number[3:0] = 4'h2;
                          else if(i == 4) number[7:4] = 4'h2;
                          else if(i == 8) number[11:8] = 4'h2;
                          else if(i == 12) number[15:12] = 4'h2;   
					end
					4'h3 : begin
                          if(i == 0) number[3:0] = 4'h3;
                          else if(i == 4) number[7:4] = 4'h3;
                          else if(i == 8) number[11:8] = 4'h3;
                          else if(i == 12) number[15:12] = 4'h3;
					end
					4'h4 : begin
                          if(i == 0) number[3:0] = 4'h4;
                          else if(i == 4) number[7:4] = 4'h4;
                          else if(i == 8) number[11:8] = 4'h4;
                          else if(i == 12) number[15:12] = 4'h4;
					end
					4'h5 : begin
                          if(i == 0) number[3:0] = 4'h5;
                          else if(i == 4) number[7:4] = 4'h5;
                          else if(i == 8) number[11:8] = 4'h5;
                          else if(i == 12) number[15:12] = 4'h5;
					end 
					4'h6 : begin
                          if(i == 0) number[3:0] = 4'h6;
                          else if(i == 4) number[7:4] = 4'h6;
                          else if(i == 8) number[11:8] = 4'h6;
                          else if(i == 12) number[15:12] = 4'h6;
					end 
					4'h7 : begin
                          if(i == 0) number[3:0] = 4'h7;
                          else if(i == 4) number[7:4] = 4'h7;
                          else if(i == 8) number[11:8] = 4'h7;
                          else if(i == 12) number[15:12] = 4'h7;
					end
					4'h8 : begin 
                          if(i == 0) number[3:0] = 4'h8;
                          else if(i == 4) number[7:4] = 4'h8;
                          else if(i == 8) number[11:8] = 4'h8;
                          else if(i == 12) number[15:12] = 4'h8;
					end
					4'h9 : begin  
                          if(i == 0) number[3:0] = 4'h9;
                          else if(i == 4) number[7:4] = 4'h9;
                          else if(i == 8) number[11:8] = 4'h9;
                          else if(i == 12) number[15:12] = 4'h9;
					end				
			endcase
		end
			
	end
	
	always @(*) begin
        if (counter % 100001 == 0) begin
            case(LED_activating_counter)
                2'b00: begin
                    anode = 4'b1111;
                    if (number[3:0] != 4'hf) begin
                        anode = 4'b0111; 
                        // activate LED1 and Deactivate LED2, LED3, LED4
                        hex_out = number[3:0];
                        // the first digit of the 16-bit number
                    end
                end
                2'b01: begin
                    anode = 4'b1111;
                    if (number[7:4] != 4'hf) begin
                        anode = 4'b1011; 
                        // activate LED2 and Deactivate LED1, LED3, LED4
                        hex_out = number[7:4];
                        // the second digit of the 16-bit number
                    end
                end
                2'b10: begin
                    anode = 4'b1111;
                    if (number[11:8] != 4'hf) begin
                        anode = 4'b1101; 
                        // activate LED3 and Deactivate LED1, LED2, LED4
                        hex_out = number[11:8];
                        // the third digit of the 16-bit number
                    end
                end
                2'b11: begin
                    anode = 4'b1111;
                    if (number[15:12] != 4'hf) begin
                        anode = 4'b1110; 
                        // activate LED4 and Deactivate LED1, LED2, LED3
                        hex_out = number[15:12];
                        // the fourth digit of the 16-bit number
                    end
                end
            endcase
        end
    end

endmodule
