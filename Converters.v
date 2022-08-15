


module Converters(input [9:0] PPR,
input signed [9:0] P,
output [9:0] Position

    );
wire  [9:0] PP;
wire [31:0] PPR_C ;   
wire [31:0] PPR_PWM;
wire [31:0] Position_32;

assign PP = P + ((PPR+1)/10'd2);
//assign PPR_C = PPR <<< 10'd22;
assign PPR_PWM =  32'd4290772992/ PPR; // 1023 <<< 22bits  divede the PPR
assign Position_32 = PP * PPR_PWM;  // 
assign Position =  Position_32[31:22]; // get the positopn value of pwm from 32bits position 

    
    
    
endmodule
