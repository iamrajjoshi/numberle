`timescale 1ns / 1ps
module LFSR (
   input i_Clk,
   input [15:0] i_Seed_Data,
   output [15:0] o_LFSR_Data
   );
 
  reg [16:1] r_LFSR = 16'h9999;
  reg              r_XNOR;
 
 
  // Purpose: Load up LFSR with Seed if Data Valid (DV) pulse is detected.
  // Othewise just run LFSR when enabled.
  always @(posedge i_Clk) begin
           r_LFSR <= {r_LFSR[15:1], r_XNOR};
  end
 
  // Create Feedback Polynomials.  Based on Application Note:
  // http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
  always @(*) begin
          r_XNOR = r_LFSR[16] ^~ r_LFSR[15] ^~ r_LFSR[13] ^~ r_LFSR[4];
    end // always @ (*)
 
 
  assign o_LFSR_Data = r_LFSR[16:1];
 
endmodule // LFSR