`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 13:29:41
// Design Name: 
// Module Name: sr_tb
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


module so_tb(

    );
    
    
    reg clk;
    reg reset;
    reg [9:0] Position;
    wire SCL;
    wire SDA;
    
    serial_output utt(
     .clk(clk),
    .reset(reset),
   .Position(Position),
    .SCL(SCL),
    .SDA(SDA)
        );
        
               initial begin
               reset = 1;#250 
               reset = 0;#250;
               

               end
               
              initial begin
              clk=0;
              forever #125 clk=~clk;
              end   
              
              initial begin
             
              Position = 1023;
              #4000
              Position = 681; // 2'b1010101001
              end
    endmodule