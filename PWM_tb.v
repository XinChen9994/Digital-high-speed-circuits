`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/26 10:48:10
// Design Name: 
// Module Name: PWM_tb
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


module PWM_tb(
);
wire PWM_CD;
reg reset;
reg PPR;
reg[9:0] Position_CD;
reg rate;
reg CLK_PWM;

PWM_Generator pgc(
.reset(reset),
.CLK(CLK_PWM),
.PPR(PPR),
.Position(Position_CD),
.f(rate),
.pwm(PWM_CD)
    );  
   
    
     initial begin
        PPR = 599;
        reset = 1;#5
        reset = 0;#5;
        reset = 0;#5;
        end
        
       initial begin
       CLK_PWM=0;
       forever #488 CLK_PWM=~CLK_PWM;
       end
    
    
    
       
    // increaing test for encoder
       initial begin
       #500
        Position_CD = 1;
         #1024000
       Position_CD = 1022;
              #1024000
       Position_CD = 400;
                #1024000
       Position_CD = 100;
                #1024000
       Position_CD = 100;
       end
       

endmodule
