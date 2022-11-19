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
    DispVal,
    clock,
    anode,
    hex_out
    );

// ==============================================================================================
// 											Port Declarations
// ==============================================================================================

    input [3:0] DispVal;			// Output from the Decoder
    input clock;                      // clock
    output [3:0] anode;				// Controls the display digits
    output [3:0] hex_out;			// Controls which digit to display

// ==============================================================================================
// 							  		Parameters, Regsiters, and Wires
// ==============================================================================================
	
	// Output wires and registers
	reg [3:0] anode = 4'b0111;
	reg [3:0] hex_out;
	
	
	reg [19:0] counter = 0;
    wire [1:0] LED_activating_counter;
    reg [15:0] number = 4'h0000;
    wire [1:0] index = 3'b00;
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
	
	always @(posedge clock) begin
//        if(reset==1)
//            displayed_number <= 0;
           counter <= counter + 1;
    end
	assign LED_activating_counter = counter[19:18];
	
	always @(DispVal) begin
	        case (DispVal)
					4'h0 : begin
					   number[3:0] <= 4'h0;  // 0
					end 
					4'h1 : begin
					   number[3:0] <= 4'h1;  // 1				   
					end
	   				4'h2 : begin 
					   number[3:0] <= 4'h2;  // 2
					end
					4'h3 : begin
					   number[3:0] <= 4'h3;  // 3  
					end
					4'h4 : begin
					   number[3:0] <= 4'h4;  // 4					  
					end
					4'h5 : begin
					   number[3:0] <= 4'h5;  // 5				   
					end 
					4'h6 : begin
					   number[3:0] <= 4'h6;  // 6				  
					end 
					4'h7 : begin
					   number[3:0] <= 4'h7;  // 7				   
					end
					4'h8 : begin 
					   number[3:0] <= 4'h8;  // 8			   
					end
					4'h9 : begin  
					   number[3:0] <= 4'h9;  // 9
					end
					4'hA : begin  
					   number[3:0] <= 4'hA; 	// A
					end
					4'hB : begin 
					   number[3:0] <= 4'hB;	// B
					end
					4'hC : begin 					  
					   number[3:0] <= 4'hC;	// C
					end
					4'hD : begin 
					   number[3:0] <= 4'hD;	// D
					end
					4'hE : begin
					   number[3:0] <= 4'hE;	// E
					end
					4'hF : begin
					   number[3:0] <= 4'hF;	// F
					end
					default : 
					   number[3:0] <= 4'h0;
					
			endcase
			
	end
	
//	always @(counter) begin
//        if(counter == 4'h1) begin
//            anode = 4'b0111;
//        end
//        else if(counter == 4'h2) begin
//            anode = 4'b1011;
//        end
//        else if(counter == 4'h3) begin
//            anode = 4'b1101;
//        end
//	end
	
	always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            anode = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            hex_out <= number[3:0];
            // the first digit of the 16-bit number
              end
        2'b01: begin
            anode = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            hex_out <= number[7:4];
            // the second digit of the 16-bit number
              end
        2'b10: begin
            anode = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            hex_out <= number[11:8];
            // the third digit of the 16-bit number
                end
        2'b11: begin
            anode = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            hex_out <= number[15:12];
            // the fourth digit of the 16-bit number    
               end
        endcase
    end

endmodule
