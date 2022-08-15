

module State_read(
input reset,
input clk,
input pwm,
output[1:0] State

    );
    reg [9:0] Current_counter;
    reg [9:0] Next_counter;
  //  reg [9:0] counter;
      reg [9:0] Current_P;
      reg [9:0] Next_P;
 //      reg [9:0] P;
    reg Current_state;
    reg  Next_state;
    parameter Wait_read = 1'b0;
    parameter Read = 1'b1;
     // reg Set_p;
	reg[10:0] Current_zero_dec;
     reg[10:0] Next_zero_dec;
      
      
      reg [1:0] State_R;
/*      
always@(posedge clk ) begin     
             if(pwm == 1) begin
                     zero_dec <= 0; 
             end                                                                                                                                                                                                                                                                                                                  
             else if(zero_dec == 1024) begin
                      zero_dec <= 0; 
                      if(counter == 0)begin 
        /////////   ///////        //   P <= 0;
                      end
                      end
                      else begin
                       zero_dec <= zero_dec + 1; 
                  end
                  end
     */ 
        
		
     always@(posedge clk or posedge reset)begin
        if(reset) begin
           Current_counter<= 10'd0;
            Current_P <= 10'd0;
            Current_state <= Wait_read;
            Current_zero_dec <= 0; 
          end
        else begin
         //   counter<= Next_counter;
            Current_P <= Next_P;
               Current_state <= Next_state;  
               Current_zero_dec <= Next_zero_dec ;
               Current_counter<= Next_counter; 
        end
        end
		
		
         always@ * begin
           Next_P =  Current_P;
           Next_state =  Current_state;  
           Next_zero_dec =  Current_zero_dec ;
           Next_counter =  Current_counter; 
         case(Current_state)
            Wait_read: begin
                Next_counter = 0; 
                if(pwm == 1) begin
                Next_state = Read;
                Next_counter = 1; 
			    Next_zero_dec = 0;
            end
            else if (Current_zero_dec == 1023) begin
                Next_zero_dec = 0;
                Next_state = Wait_read;
                Next_P = 0;
            end    
      /*      else if (Next_zero_dec == 0) begin
                Next_zero_dec = 1;
                Next_state = Wait_read;
                
            end    */
            else begin
                Next_state = Wait_read;
                Next_zero_dec = Current_zero_dec + 11'd1; 
            end    
        end
             
            Read: begin
                 if(pwm == 0) begin            
                 Next_state = Wait_read;
           //      Set_p = 1;
                 Next_P = Current_counter;
                 
              end
                else if (Current_counter == 1023) begin
                Next_state = Wait_read;
                 Next_P = Current_counter;
                end
              
                 else begin
                 Next_state = Read;
                 Next_counter = Current_counter + 10'd1;
              end
           end      
             
        endcase
        
     end   
        
      always@ * begin     
	// always@(Current_P) begin     // 0-307:state 00Braking
            if(Current_P <= 307 ) begin
                State_R = 2'b00;
            end
            else if(Current_P <= 409 ) begin  // 308-409:state 01 short
                State_R = 2'b01;
            end
            else if(Current_P <= 512 ) begin  // 409-512:state 10 open
               State_R = 2'b10;
            end
            else begin        // 512 - 1023  max drive
                State_R = 2'b11; 
            end
        end
      
      
      assign State  = State_R;  
        
  //  assign Position = Set_p ? Position : P;
    
  
endmodule
