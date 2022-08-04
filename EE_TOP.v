`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/26 20:26:39
// Design Name: 
// Module Name: EE_TOP
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


module EE_TOP(
input reset,
input clk,
input [3:0]PR,
input[2:0] R,
input A,
input B,
//input C,
//input D,
input PWM_Input,

output PWM_AB,
output Drive,
output     Load,
output     Drive_Led,
output     Load_Led
    );

reg CLK;
wire [23:0] Rate;
wire [9:0] PPR;
wire signed [9:0] P_AB;  // Original Position of encoder.
wire signed [9:0] P_CD;
wire [9:0] Position_AB;   // Converted Position for PWM.
wire [9:0] Position_CD;
wire [9:0] Position_Pen;

wire [1:0] State;
//assign PPR = 600;
//assign Rate = 4000;

//assign P_AB = 256;
//assign P_CD =-256;

//encoder 1 get the postion P_AB.
    encoder ecd(.reset(reset),
     .CLK(clk),.A(A),.B(B),.PPR(PPR),.P(P_AB));
     
     //encoder 2 get the postion P_CD.
 //    encoder ece(.reset(reset),
 //    .CLK(clk),.A(C),.B(D),.PPR(PPR),.P(P_CD));
     
     Clock cok(.reset(reset),
      .clk(clk),.Rate(Rate),.CLK_PWM(CLK_PWM));
     
     Converters cvt(.PPR(PPR),
     .P(P_AB),.Position(Position_AB));
     
  //   Converters cvy(.PPR(PPR),
//     .P(P_CD),.Position(Position_CD));
    
     PWM_Generator pga(
     .reset(reset),
     .CLK(CLK_PWM),
 //  .CLK(clk),
   //  .PPR(PPR),
     .Position(Position_AB),
 //    .f(rate),
     .pwm(PWM_AB)
         );
   
         State_read str(
         .reset(reset),
         .clk(CLK_PWM),
         .pwm(PWM_Input),
         .State(State)
         
             );      
         
        PWM_Receiver prv(
         .reset(reset),
         .clk(CLK_PWM),
          .pwm(PWM_AB),
          .Position( Position_Pen)
         
             );  
             
         
    Pendulum pdm(
               .clk(CLK_PWM),
               .reset(reset),
               .Position( Position_Pen),
               .State(State),
               .Drive(Drive),
               .Load(Load),
               .Drive_Led(Drive_Led),
               .Load_Led(Load_Led)
               
                 );     
         
         
         
/*
     PWM_Generator pgc(
     .reset(reset),
     .CLK(CLK_PWM),
  //  .CLK(clk),
   //  .PPR(PPR),
     .Position(Position_CD),
   //  .f(rate),
     .pwm(PWM_CD)
         );    
    
    */

    
   Rate_switch rsh(.reset(reset),
        .clk(clk),.R(R),.Rate_1(Rate));
          
 // PPR switch model from 64 to 1024
   PPR_switch psh(.reset(reset),
         .clk(clk),
         .PR(PR),
      .PPR_1(PPR)
    );
 
      
      
      
      
      
    
endmodule
