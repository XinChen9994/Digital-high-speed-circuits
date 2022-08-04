`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/24 21:35:40
// Design Name: 
// Module Name: Con_tb
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


module Con_tb(

    );
     
       reg CLK;

       reg[9:0] PPR;
       reg [9:0] P;
       wire [9:0] Position;
       
        Converters utt(.PPR(PPR),.P(P),.Position(Position));
        
        
           initial begin
           PPR = 599;
           P = 400;
           #500;
           PPR = 599;
           P = 401;
           #500;
           PPR = 599;
           P = 402;
           #500;
           PPR = 599;
           P = 100;
           #500;
           PPR = 1023;
           P = 100;
           #500;
           end
               initial begin
           CLK=0;
           forever #5 CLK=~CLK;
           end
        
    
    
    
    
endmodule
