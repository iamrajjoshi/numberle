// Generates a 16-bit random number using a Linear Feedback Shift Register (LFSR).

`timescale 1ns / 1ps

module RNG (
   input clock, // Clock
   output [15:0] random_number // Random Number
   );
 
  reg [16:1] r_LFSR = 16'h9999; // LFSR Register
  reg r_XNOR; // XNOR of Feedback Polynomials
 
  always @(posedge clock) begin
           r_LFSR <= {r_LFSR[15:1], r_XNOR}; // Generate Next LFSR Value
  end
 
  // Create Feedback Polynomials.  Based on Application Note:
  // http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
  always @(*) begin
          r_XNOR = r_LFSR[16] ^~ r_LFSR[15] ^~ r_LFSR[13] ^~ r_LFSR[4];
  end
 
  assign random_number = r_LFSR[16:1];
 
endmodule
