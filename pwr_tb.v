`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/01 00:47:20
// Design Name: 
// Module Name: pwr_tb
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


module pwr_tb(

    );
    reg reset;
    reg clk;
  //  reg pwm;
    wire[9:0] Position;
    wire PWM_CD;
//    reg reset;
   // reg PPR;
    reg[9:0] Position_CD;
 //   reg rate;
  //  reg CLK_PWM;
    
 
       
        
        initial begin
//    PR = 4'b1001; //PPR=600
  //   PR = 4'b1111; //PPR=1024
  //  R=3'b000; // PMW rate  = 1ms
    reset = 1;#125 
    reset = 0;#125;
    reset = 0;#125;
    end
    
   initial begin
   clk=0;
   forever #125 clk=~clk;
   end
        
        
        
           
        // increaing test for encoder
           initial begin
           #500
            Position_CD = 1;
             #250000
           Position_CD = 1022;
                   #500000
           Position_CD = 400;
                     #500000
           Position_CD = 100;
                     #500000
           Position_CD = 100;
                     #500000
           Position_CD = 1;
                     #500000
           Position_CD = 1022;
                       #500000
           Position_CD = 2;
                       #500000
           Position_CD = 3;
                       #500000
           Position_CD = 0;
                       #500000
           Position_CD = 1000;
                        #500000  
           Position_CD = 1023;                               
                        #500000 
            Position_CD = 1021; 
           end
           
    
    
    
    
    
    
    
    PWM_Generator pgc(
    .reset(reset),
    .CLK(clk),
 //   .PPR(PPR),
    .Position(Position_CD),
 //   .f(rate),
    .pwm(PWM_CD)
        ); 
    
    PWM_Receiver  pmr(
    .reset(reset),
    .clk(clk),
    .pwm(PWM_CD),
    .Position(Position)
    
        );
endmodule
