module GameLogic(
    clock,
    number,
    try,
    guess,
    message,
    digit,
	led
);

    input clock;
    input [15:0] number;
    input [15:0] guess;
    input try;
    output digit;
    output [3:0] message;
    output [15:0] led;


    always(*) begin
        if(try % 2 == 1) begin 
            if(number[3:0] == guess[3:0]) led[15] = 1;
            if(number[7:4] == guess[7:4]) led[14] = 1;
            if(number[11:8] == guess[11:8]) led[13] = 1;
            if(number[15:12] == guess[15:12]) led[12] = 1;            

            if(try == 1) message = 4'h1;
            else if(try == 3) message = 4'h2;
            else if(try == 5) message = 4'h3;
            else if(try == 7) message = 4'h4;

            digit = 0;
        end
    end




endmodule