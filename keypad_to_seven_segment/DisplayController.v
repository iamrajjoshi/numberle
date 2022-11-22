`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 2011
// Engineer: Michelle Yu  
//				 Josh Sackos
// Create Date:    07/23/2012 
//
// Module Name:    DisplayController
// Project Name:   PmodKYPD_Demo
// Target Devices: Nexys3
// Tool versions:  Xilinx ISE 14.1 
// Description: This file defines a DisplayController that controls the seven segment display that works with 
// 				 the output of the Decoder.
//
// Revision History: 
// 						Revision 0.01 - File Created (Michelle Yu)
//							Revision 0.02 - Converted from VHDL to Verilog (Josh Sackos)
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// ==============================================================================================
// 												Define Module
// ==============================================================================================
module DisplayController(
	btnR,
	btnL,
        DispVal,
        clock,
        anode,
        hex_out,
	led
    );

// ==============================================================================================
// 											Port Declarations
// ==============================================================================================
	input btnR;
	input btnL;
	output [15:0] led;
    	input [3:0] DispVal;			// Output from the Decoder
    	input clock;                      // clock
    	output [3:0] anode;				// Controls the display digits
    	output [3:0] hex_out;			// Controls which digit to display

// ==============================================================================================
// 							  		Parameters, Regsiters, and Wires
// ==============================================================================================
	
	// Output wires and registers
	reg [3:0] anode = 4'b1111;
	reg [3:0] hex_out;
	reg [15:0] led = 16'h0000;
	reg [19:0] counter = 0;
    	wire [1:0] LED_activating_counter;
    	reg [15:0] number = 4'h0000;
    	wire [1:0] index = 3'b00;
    
   	integer i = 0;
    	reg [3:0] prev = 4'hA;

	reg flag = 1'b1;
	

// ==============================================================================================
// 												Implementation
// ==============================================================================================
	
	// only display the rightmost digit
//	assign anode = 4'b0111;
	
	//------------------------------
	//		   Segment Decoder
	// Determines cathode pattern
	//   to display digit on SSD
	//------------------------------
	
//	always @(posedge btnL) begin
//	   i <= i - 4;
//	end
	
	always @(posedge btnR) begin
	   i <= i + 4;
	end
	
	always @(posedge clock) begin
//        if(reset==1)
//            displayed_number <= 0;
           counter <= counter + 1;
    end
	assign LED_activating_counter = counter[19:18];

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
                          else if(i == 12) number[15:12] = 4'h3;  // 3  
					end
					4'h4 : begin
                          if(i == 0) number[3:0] = 4'h4;
                          else if(i == 4) number[7:4] = 4'h4;
                          else if(i == 8) number[11:8] = 4'h4;
                          else if(i == 12) number[15:12] = 4'h4;  // 4					  
					end
					4'h5 : begin
                          if(i == 0) number[3:0] = 4'h5;
                          else if(i == 4) number[7:4] = 4'h5;
                          else if(i == 8) number[11:8] = 4'h5;
                          else if(i == 12) number[15:12] = 4'h5;  // 5				   
					end 
					4'h6 : begin
                          if(i == 0) number[3:0] = 4'h6;
                          else if(i == 4) number[7:4] = 4'h6;
                          else if(i == 8) number[11:8] = 4'h6;
                          else if(i == 12) number[15:12] = 4'h6;  // 6				  
					end 
					4'h7 : begin
                          if(i == 0) number[3:0] = 4'h7;
                          else if(i == 4) number[7:4] = 4'h7;
                          else if(i == 8) number[11:8] = 4'h7;
                          else if(i == 12) number[15:12] = 4'h7;  // 7				   
					end
					4'h8 : begin 
                          if(i == 0) number[3:0] = 4'h8;
                          else if(i == 4) number[7:4] = 4'h8;
                          else if(i == 8) number[11:8] = 4'h8;
                          else if(i == 12) number[15:12] = 4'h8;  // 8			   
					end
					4'h9 : begin  
                          if(i == 0) number[3:0] = 4'h9;
                          else if(i == 4) number[7:4] = 4'h9;
                          else if(i == 8) number[11:8] = 4'h9;
                          else if(i == 12) number[15:12] = 4'h9; // 9
					end				
			endcase
		end
			
	end
	
	always @(*)
    begin
    if (counter % 100001 == 0) begin
        case(LED_activating_counter)
        2'b00: begin
            anode = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            hex_out = number[3:0];
            // the first digit of the 16-bit number
              end
        2'b01: begin
            anode = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            hex_out = number[7:4];
            // the second digit of the 16-bit number
              end
        2'b10: begin
            anode = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            hex_out = number[11:8];
            // the third digit of the 16-bit number
                end
        2'b11: begin
            anode = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            hex_out = number[15:12];
            // the fourth digit of the 16-bit number    
               end
        endcase
        end
    end

endmodule
