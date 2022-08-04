`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/26 07:45:26
// Design Name: 
// Module Name: E_tb
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


module E_tb(

    );
    
       reg reset;
       reg CLK;
       reg A;
       reg B;
       reg C;
       reg D;
       reg[2:0] R;
       reg[3:0] PR;
       wire PWM_CD;
       wire PWM_AB;
       
       E_TOP utt(.reset(reset),
       .clk(CLK),
       .PR(PR),
       .R(R),
       .A(A),
       .B(B),
       .C(C),
       .D(D),
       
       .PWM_AB(PWM_AB),
       .PWM_CD(PWM_CD));

           
           
        
        
        
        initial begin
    //    PR = 4'b1001; //PPR=600
         PR = 4'b1111; //PPR=1024
        R=3'b000; // PMW rate  = 1ms
        reset = 1;#125 
        reset = 0;#125;
        reset = 0;#125;
        end
        
       initial begin
       CLK=0;
       forever #125 CLK=~CLK;
       end
    
    
    

    // increaing test for encoder
             initial begin
    A=0;
    #2500
    forever #2500 A=~A;
    end

    initial begin
    B=0;
    #3750
    forever #2500 B=~B;
    end  
    
    
             initial begin
       D=0;
       #2500
       forever #2500 D=~D;
       end
       
       initial begin
       C=0;
       #3750
       forever #2500 C=~C;
       end  
     
        

  
          
  
    
    
    
    
    
    
endmodule
