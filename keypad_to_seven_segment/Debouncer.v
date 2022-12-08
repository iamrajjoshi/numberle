// Debounce push button input

`timescale 1ns / 1ps

module Debouncer(
    input clock, // Clock
    input in, // Push button input    
    output out // Debounced push button output
    );
    
    wire slow_clock_en;
    wire Q1,Q2,Q2_bar,Q0;
    
    clock_enable u1(clock,slow_clock_en);
    
    my_dff_en d0(clock,slow_clock_en,in,Q0);
    my_dff_en d1(clock,slow_clock_en,Q0,Q1);
    my_dff_en d2(clock,slow_clock_en,Q1,Q2);
    
    assign Q2_bar = ~Q2;
    assign out = Q1 & Q2_bar;    
endmodule
    
// Slow clock enable for debouncing button 
module clock_enable(input clock_100M,output slow_clock_en);
    reg [26:0]counter=0;
    always @(posedge clock_100M)
    begin
        counter <= (counter>=249999)?0:counter+1;
    end
    assign slow_clock_en = (counter == 249999)?1'b1:1'b0;
endmodule

// D-flip-flop with clock enable signal for debouncing module 
module my_dff_en(input DFF_CLOCK, clock_enable,D, output reg Q=0);
    always @ (posedge DFF_CLOCK) begin
    if(clock_enable==1) 
            Q <= D;
    end
endmodule 
