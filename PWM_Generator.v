


module PWM_Generator(
input reset,
input CLK,
//input PPR,
input [9:0] Position,
//input [9:0] f,
output reg pwm
    );
    
  reg [10:0] counter;
  reg [9:0] P;
  
    
    
 always@(posedge CLK or posedge reset)    
    if(reset) begin
        counter<= 10'd0;
        P <= 10'd0;
      end
    else if(counter < P) // if the counter less than postion, the pwm is high
        begin
        counter <= counter + 10'd1;
        pwm <= 1;
        end
    else if(counter < 10'd1023) //10 bit, 
        begin
        counter <= counter + 10'd1;
        pwm <= 2'b0;
        end
    else   // reset the count
        begin
        counter <= 10'd0;
        P <= Position;
        end
    
    
    
endmodule
