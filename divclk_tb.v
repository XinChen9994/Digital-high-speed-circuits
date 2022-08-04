`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/25 04:03:28
// Design Name: 
// Module Name: divclk_tb
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


module divclk_tb(

    );
    
    
    reg reset;
    reg clk;
    reg[7:0] Rate;
    wire CLK_PWM;
    
     Clock utt(.reset(reset),
     .clk(clk),.Rate(Rate),.CLK_PWM(CLK_PWM));
    
      initial begin

       Rate = 10;
       reset = 1;#5
       reset = 0;#5;
       reset = 0;#5;
       end
       
      initial begin
      clk=0;
      forever #5 clk=~clk;
      end
   
    
endmodule
