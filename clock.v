`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 13:34:15
// Design Name: 
// Module Name: PPR_swtich
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


module Clock(
input reset,
input clk,
input[23:0] Rate,
output CLK_PWM
    );
    
 wire[23:0] Rate_y;
 assign  Rate_y = Rate;

 reg[23:0] count; 
    reg CLK;
always@(posedge clk or posedge reset) begin                                                                                                                                                                                                                                                                                                                         
        if(reset) begin           // reset count and clk to 0;
        count <= 0;
         CLK <= 1'b0;
        end
        else if(count == Rate_y) begin
                count <= 0;
                CLK<=  ~ CLK;
                end
                else begin
                  count <= count + 1;  //counter count< blue=1388 yellow=1249 green=1332 red=1388
                  CLK <=   CLK;
            end
            end
            
    assign CLK_PWM = CLK;
    
endmodule