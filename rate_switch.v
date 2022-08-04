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


module Rate_switch(
input reset,
input clk,
input[2:0] R,
output [23:0] Rate_1
    );
    
 reg [23:0] Rate;
    
    always@(*)begin
        case(R)   // base_clock set to 4Mhz.
        3'b000: Rate = 24'd1;  //rate 1ms  1m/(1/4M£©=4000
        3'b001: Rate = 24'd2;  //rate 2ms  1m/(1/4M£©=8000
        3'b010: Rate = 24'd5;  //rate 5ms   200000
        3'b011: Rate = 24'd10; //rate 10ms  400000
        3'b100: Rate = 24'd20; //rate 20ms  800000
        3'b101: Rate = 24'd50; //rate 50ms  2000000
        3'b110: Rate = 24'd100; //rate 100ms 4000000
        3'b111: Rate = 24'd200; //rate 200ms 8000000
        default: Rate = 24'd1;
        
        endcase
    
    end
   
   assign Rate_1 = Rate; 
    
endmodule