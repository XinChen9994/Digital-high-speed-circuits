`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 04:39:16
// Design Name: 
// Module Name: serial_receiver
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


module serial_receiver(
input reset,
input clk,
input SCL,
inout SDA,
input SDA_Enable,
output[3:0] PR,
output[2:0] Rate

    );
    reg [7:0] current_data;
    reg [7:0] next_data;
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg [3:0] current_BitCounter;
    reg [3:0] next_BitCounter;
    reg current_ByteReceived;
    reg next_ByteReceived; 
    reg [15:0] current__TimeoutCounter; 
    reg [15:0] next_TimeoutCounter;
    reg SDA_Out;

/*
reg SLCDly;
always@(posedge clk)
SLCDly <= SCL;
     */
    localparam [2:0] IDLE = 3'd0;
//    localparam [2:0] Start = 3'd1;
    localparam [2:0] Bit_read = 3'd1;   
    localparam [2:0] Ack = 3'd3; 
    localparam [2:0] stop = 3'd4;
    
 //  always@( negedge clk or posedge reset) begin
      always@( posedge clk or posedge reset) begin
    if(reset) begin
    current_state <= 3'b000;
    current_BitCounter <= 0;
    current_ByteReceived <= 1'b0;
  //  current_TimeoutCounter <= 0;
    current_data <= 7'd0;
    end 
    else begin
    current_state <= next_state;
    current_BitCounter <= next_BitCounter;
    current_ByteReceived <= next_ByteReceived;
 //   current_TimeoutCounter <= next_TimeoutCounter;
    current_data <= next_data;
    end
    end
    
    always@*begin
  //  always@(current_BitCounter or current_state or current_data) begin
     next_state =  current_state;
    next_BitCounter = current_BitCounter;
    next_ByteReceived =  1'b0;
  //  next_TimeoutCounter = current_TimeoutCounter;
    next_data = current_data;
    
    case( current_state)
    
    IDLE:begin
        if( ~SDA)begin
        next_state = Bit_read;
    end
    next_BitCounter = 0;
    end
    
    Bit_read:begin
   // if(current_TimeoutCounter == 100000)
 //        next_state = IDLE;
    // else 
     if (current_BitCounter == 8 )
      begin
        next_state = Ack;
      //  next_data[7] = SDA;
     //   next_data[6:0] = current_data [7:1];
        next_BitCounter = 0;
        SDA_Out = 1;
      end
       else if ( SCL )
       begin
         next_data[6:0] = current_data [7:1];
         next_data[7] = SDA;
         next_BitCounter =  current_BitCounter + 1;
     //    next_TimeoutCounter = 0;
       end
      end
       
       Ack: begin
        //   if(SCL && ~SDA)
           next_state = stop;
           next_ByteReceived = 1;
          SDA_Out = 1;
           end
           
       stop : begin
              if(SCL && SDA)
              SDA_Out = 0;
                  next_state = IDLE;
                 
                  end
        
         
       endcase
       end

    assign PR  = current_ByteReceived ? current_data[3:0] : PR;
    assign Rate = current_ByteReceived ?current_data[6:4] : Rate;
    assign SDA = SDA_Enable ? SDA_Out:1'bz;
    
    
    
endmodule
