`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 09:34:38
// Design Name: 
// Module Name: serial_output
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


module serial_output(
input clk,
input reset,
input [9:0] Position,
output SCL,
output SDA
    );
    
    wire [9:0] P;
    reg read_enable; // read the new position after the modele sended old position
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg SCL_R;
    reg SDA_A;
    reg Go;
    reg[9:0] counter;
    reg [6:0] SD_counter;
    
    assign P = read_enable ? Position : P;

  
    always@(posedge clk) begin
    if (counter < 100) begin
    counter <= counter + 1;
    Go <= 1;
    end
    else begin
    counter <= 0;
    Go <= 0;
    end
    end
    
    
  /*  
    always@(posedge clk ) begin
     if (cou)
    end
   */ 
    
    
    always@(posedge clk or posedge reset) begin
        
        if (reset)
            SD_counter <= 0;
        else begin
           if (!Go)
              SD_counter <= 0;
           else if (SD_counter < 14)
              SD_counter <= SD_counter +1;
              
        
        end    
    end
    
 
    
    
    always@ (posedge clk or posedge reset) begin
       // always@ (negedge clk or posedge reset) begin
     if (reset)
       begin
          SCL_R <= 1;
          SDA_A <= 1;
          read_enable <=1;
       end
     else begin
      case(SD_counter)
       6'd0: begin  //idel
           read_enable <= 0;
            SCL_R <= 0;
            SDA_A <= 0;
       end
       //data
       6'd1: SDA_A <= P[0];  
       6'd2: SDA_A <= P[1];  
       6'd3: SDA_A <= P[2];  
       6'd4: SDA_A <= P[3];
       6'd5: SDA_A<= P[4];
       6'd6: SDA_A <= P[5];
       6'd7: SDA_A <= P[6];
       6'd8: SDA_A <= P[7];
       6'd9: SDA_A <= P[8];
       6'd10: SDA_A <= P[9];
       6'd11: SDA_A <= 1'bz;//ACK
       //stop
       6'd12 : begin
           SCL_R <= 1;
           SDA_A <= 0;
       end
       
       6'd13: begin 
       SDA_A <= 1;
       read_enable <=1;
       end
       endcase
    end
   end
   
    assign SDA = SDA_A;
    assign SCL = ((SD_counter>=1)&&(SD_counter<=13)) ? clk:SCL_R;
   
   
   
   
   
   /* 
    localparam [2:0] IDLE = 3'd0;
//    localparam [2:0] Start = 3'd1;
    localparam [2:0] start_bit= 3'd1;   
    localparam [2:0] data_bit = 3'd3; 
    localparam [2:0] stop_bit = 3'd4;
    
    
    always@(posedge clk) begin
        if(reset) begin
            current_state <= 3'b000;
        end 
        else begin
            current_state <= next_state;
        end
    end
   
   always@* begin
   
   case(current_state)
    IDLE:begin
        SCL = 1;
        SDA = 1; 
     end
     
     start_bit:begin
        SCL = 1;
        SDA = 0;
        next_state = data_bit;
     end
     
     data_bit:begin
     
     end   
      
     stop_bit:begin
     
     end    
   endcase
   end  
   
   
   */
endmodule
