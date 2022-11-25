module HexToLED(
    input      [3:0] hex, // hex input
    output reg [6:0] seg  // segments
);


  always @ (*)
  begin
    case (hex)
      // segment order: GFEDCBA (active low)
      4'h0 : seg = 7'b1000000;
      4'h1 : seg = 7'b1111001;
      4'h2 : seg = 7'b0100100;
      4'h3 : seg = 7'b0110000;
      4'h4 : seg = 7'b0011001;
      4'h5 : seg = 7'b0010010;
      4'h6 : seg = 7'b0000010;
      4'h7 : seg = 7'b1111000;
      4'h8 : seg = 7'b0000000;
      4'h9 : seg = 7'b0010000;
      4'hA : seg = 7'b0000111; // t
      4'hB : seg = 7'b0101111; // r 
      4'hC : seg = 7'b0010001; // y
      4'hD : seg = 7'b0100001;
      4'hE : seg = 7'b0000110;
      4'hF : seg = 7'b1111111;
      default : seg = 7'b1111111;
    endcase
  end


endmodule
