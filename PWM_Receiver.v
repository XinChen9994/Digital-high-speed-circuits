`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/31 22:57:42
// Design Name: 
// Module Name: PWM_Receiver
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


module PWM_Receiver(
input reset,
input clk,
input pwm,
output[9:0] Position

    );
    reg [9:0] Current_counter;
    reg [9:0] Next_counter;
    reg [9:0] counter;
      reg [9:0] Current_P;
      reg [9:0] Next_P;
       reg [9:0] P;
    reg[1:0] Current_state;
    reg[1:0]  Next_state;
      parameter Wait_read = 2'b0;
      parameter Read = 2'b1;
      reg Set_p;
      reg[10:0] zero_dec;
      
always@(posedge clk ) begin     
             if(pwm == 1) begin
                     zero_dec <= 0; 
             end                                                                                                                                                                                                                                                                                                                  
             else if(zero_dec == 1024) begin
                      zero_dec <= 0; 
                      if(counter == 0)begin 
                      P <= 0;
                      end
                      end
                      else begin
                       zero_dec <= zero_dec + 1; 
                  end
                  end
      
        
     always@(posedge clk or posedge reset)begin
        if(reset) begin
           counter<= 10'd0;
            Current_P <= 10'd0;
            Current_state <= Wait_read;
            zero_dec <= 0; 
          end
        else begin
         //   counter<= Next_counter;
            Current_P <= Next_P;
               Current_state <= Next_state;  
        end
        end
        always@ (posedge clk) begin
         
         case(Current_state)
            Wait_read: begin
                counter = 0; 
                if(pwm == 1) begin
                Next_state = Read;
                counter = 1; 
                end
                else
                Next_state = Wait_read;
            end
             
            Read: begin
                 if(pwm == 0) begin            
                 Next_state = Wait_read;
           //      Set_p = 1;
                 P = counter+1;
                 
              end
                else if (counter == 1022) begin
                Next_state = Wait_read;
                 P = counter+1;
                end
              
                 else begin
                 Next_state = Read;
                 counter = counter+1;
              end
           end      
             
        endcase
        
     end   
        
        
        
        
  //  assign Position = Set_p ? Position : P;
    
     assign Position =  P;
endmodule
