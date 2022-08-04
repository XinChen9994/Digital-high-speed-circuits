`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/03 05:11:09
// Design Name: 
// Module Name: Pendulum_tb
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


module Pendulum_tb(

    );
    reg reset;
    reg clk;
    reg [3:0]PR;
    reg [2:0] R;
    reg A;
    reg B;
    //input C,
    //input D,
    reg PWM_Input;
    
    wire PWM_AB;
    wire Drive;
    wire Load;
    wire Drive_Led;
    wire Load_Led;
    
    
    
     EE_TOP  utt(
     .reset(reset),
    .clk(clk),
    .PR(PR),
    .R(R),
    .A(A),
    .B(B),
    //input C,
    //input D,
    .PWM_Input(PWM_Input),
    
    .PWM_AB(PWM_AB),
    .Drive(Drive),
    .Load(Load),
    .Drive_Led(Drive_Led),
    .Load_Led(Load_Led)
        );
    
    
        initial begin
        //    PR = 4'b1001; //PPR=600
             PR = 4'b1111; //PPR=1024
            R=3'b000; // PMW rate  = 1ms
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
        A=0;
        B=0;
        #250000
        A=1;
        #125000
        B=1;
        repeat (200) begin
                
                 #125000 A=~A;
                 #125000 B=~B;     
             end  
               
         #250000
            B=~B; 
          #125000   
            A=~A; 
        repeat (400) begin
           #125000 B=~B;       
           #125000 A=~A;
              
            end  
          
           #250000 
            A=~A; 
             #125000 
            B=~B; 
            
           repeat (400) begin
           
               #125000 A=~A;
              #125000 B=~B;  
                  
            end     
                     #250000
               B=~B; 
             #125000   
               A=~A; 
           repeat (400) begin
              #125000 B=~B;       
              #125000 A=~A;
                 
               end  
             
              #250000 
               A=~A; 
                #125000 
               B=~B; 
               
              repeat (400) begin
              
                  #125000 A=~A;
                 #125000 B=~B;  
                     
               end   
               
                        #250000
                  B=~B; 
                #125000   
                  A=~A; 
              repeat (400) begin
                 #125000 B=~B;       
                 #125000 A=~A;
                    
                  end  
                
                 #250000 
                  A=~A; 
                   #125000 
                  B=~B; 
                  
                 repeat (400) begin
                 
                     #125000 A=~A;
                    #125000 B=~B;  
                        
                  end   
                  
                           #250000
                     B=~B; 
                   #125000   
                     A=~A; 
                 repeat (400) begin
                    #125000 B=~B;       
                    #125000 A=~A;
                       
                     end  
                   
                    #250000 
                     A=~A; 
                      #125000 
                     B=~B; 
                     
                    repeat (400) begin
                    
                        #125000 A=~A;
                       #125000 B=~B;  
                           
                     end   
            
            
            
             
        end
    /*
        initial begin
        B=0;
        #3750
        forever #2500 B=~B;
        end  
        
*/
             initial begin
             PWM_Input = 1;
             #250000000
             PWM_Input = 0;
             end
    
    
    
    
endmodule
