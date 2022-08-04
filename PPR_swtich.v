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


module PPR_switch(
input reset,
input clk,
input[3:0] PR,
output [9:0] PPR_1
    );
    
 reg [9:0] PPR;
 
    
    always@(*)begin
        case(PR)
        4'b0000: PPR =10'd63;
        4'b0001: PPR =10'd99;
        4'b0010: PPR =10'd127;
        4'b0011: PPR =10'd199;
        4'b0100: PPR =10'd255;
        4'b0101: PPR =10'd299;
        4'b0110: PPR =10'd359;
        4'b0111: PPR =10'd399;
        4'b1000: PPR =10'd499;
        4'b1001: PPR =10'd599;
        4'b1010: PPR =10'd699;
        4'b1011: PPR =10'd719;
        4'b1100: PPR =10'd799;
        4'b1101: PPR =10'd899;
        4'b1110: PPR =10'd999;
        4'b1111: PPR =10'd1023; 
        default: PPR =10'd600;
        endcase
    
    end
  assign PPR_1 = PPR;  
    
endmodule
