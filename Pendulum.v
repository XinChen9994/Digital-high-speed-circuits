`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/31 22:58:26
// Design Name: 
// Module Name: Pendulum
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


module Pendulum(
  input clk,
  input reset,
  input [9:0] Position,
  input[1:0] State,
  output Drive,
  output Load,
  output Drive_Led,
  output Load_Led
  
    );
    
  //  reg[2:0] Currnet_state;
  //  reg[2:0] Next_state;
    reg Drive_R;
    reg Load_R;
    reg Drive_Led_R;
    reg Load_Led_R;
    
    assign Drive = Drive_R;
    assign Load = Load_R;
    assign Drive_Led = Drive_Led_R;
    assign Load_Led = Load_Led_R;
    
    
    reg signed [10:0] Direction;
    
    
    
  
    reg[9:0] Last_P;
     
  //   assign Direction = P - Last_P;
    
    localparam Braking =2'b00;
    localparam Short =2'b01;
    localparam Open = 2'b10;
    localparam Driving =  2'b11;
    
    always@(posedge clk or posedge reset ) begin
     if(reset) begin
    //  Position <= 0;
      Last_P <= 0;
      end
      else 
       if (Position!=Last_P) begin
      Direction <= Position - Last_P;
      Last_P <= Position;
      end
      
    
    
    
    end
    
    
    
    
    
    
    
    always@* begin
        case(State)
            Braking:begin  //Providing resistance and power
        /*        if( Position <= 412 || Position >= 612 )begin  // Position < -100 OR > +100 open D and L
                    Drive_R = 0;
                    Load_R = 0;
                    Drive_Led_R = 0;
                    Load_Led_R = 0;
                end   
                else if (Position >= 512 && Position <= 512 && Direction[9]) begin   //if the position between 0 to 100 and dP is positive.
                    Drive_R = 1;
                    Load_R = 0;
                    Drive_Led_R = 1;
                    Load_Led_R = 0; 
                end
                 else */ 
               //   if (Position < 512 && Position >= 412 && !Direction[10]) begin   //if the position between -100 to 0 and dP is positive.
                if (Position >= 512 && Position <= 612 && Direction[10]) begin   //if the position between 0 to 100 and dP is positive.
                    Drive_R = 1;
                    Load_R = 0;
                    Drive_Led_R = 1;
                    Load_Led_R = 0; 
                end    
                else begin   
                    Drive_R = 0;
                    Load_R = 0;
                    Drive_Led_R = 0;
                    Load_Led_R = 0;  
                end          
            
             end
            
            Short:begin // Short circuit L=1 D=0
                Drive_R = 0;
                Load_R = 1;
                Drive_Led_R = 0;
                Load_Led_R = 1;
            end   
             
            Open:begin   //Free running
                Drive_R = 0; 
                Load_R = 0;
                Drive_Led_R = 0;
                Load_Led_R = 0;
            end
            
            Driving:begin
               if (Position < 512 && Position >= 412 && Direction[10]) begin   //if the position between -100 to 0 and dP is positive.
           //     if (Position >= 512 && Position <= 612 && !Direction[10]) begin   //if the position between 0 to 100 and dP is positive.
                       Drive_R = 1;
                       Load_R = 0;
                       Drive_Led_R = 1;
                       Load_Led_R = 0; 
                end
                
                else begin   
                     Drive_R = 0;
                     Load_R = 0;
                     Drive_Led_R = 0;
                     Load_Led_R = 0;  
                 end   
                
            end  
            
            endcase
     end          
endmodule
