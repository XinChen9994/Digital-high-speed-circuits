`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/04 12:36:30
// Design Name: 
// Module Name: encoder_tb
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


module encoder_tb(

    );
    
    reg reset;
    reg CLK;
    reg A;
    reg B;
    reg[9:0] PPR;
    wire [9:0] P;
       wire [9:0] Position;
    
    encoder utt(.reset(reset),
     .CLK(CLK),.A(A),.B(B),.PPR(PPR),.P(P));
     
       
        Converters uyy(.PPR(PPR),.P(P),.Position(Position));
        
        PWM_Generator pga(
        .reset(reset),
        .CLK(CLK),
      //  .PPR(PPR),
        .Position(Position),
    //    .f(rate),
        .pwm(PWM_AB)
            );    
     
     
     
     initial begin
     PPR = 599;
     reset = 1;#5
     reset = 0;#5;
     reset = 0;#5;
     end
     
    initial begin
    CLK=0;
    forever #5 CLK=~CLK;
    end
 
 
 
    /*
 // increaing test for encoder
    initial begin
    A=0;
    #50
    forever #50 A=~A;
    end
    
    initial begin
    B=0;
    #75
    forever #50 B=~B;
    end
     
    */ 

     // decreaing test for encoder
        initial begin
        B=0;
        #50
        forever #50 B=~B;
        end
        
        initial begin
        A=0;
        #75
        forever #50 A=~A;
        end
       
  
     
endmodule
