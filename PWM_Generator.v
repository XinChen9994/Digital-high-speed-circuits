`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 11:06:12
// Design Name: 
// Module Name: PWM_Generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PWM_Generator(
input reset,
input CLK,
//input PPR,
input [9:0] Position,
//input [9:0] f,
output reg pwm
    );
    
  reg [9:0] counter;
  reg [9:0] P;
  
    
    
 always@(posedge CLK or posedge reset)    
    if(reset) begin
        counter<= 10'd0;
        P <= 10'd0;
      end
    else if(counter < P) // if the counter less than postion, the pwm is high
        begin
        counter <= counter + 1;
        pwm <= 1;
        end
    else if(counter < 1023) //10 bit, 
        begin
        counter <= counter + 1;
        pwm <= 0;
        end
    else   // reset the count
        begin
        counter <= 0;
        P <= Position;
        end
    
    
    
endmodule
