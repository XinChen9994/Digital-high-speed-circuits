`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/27 13:45:42
// Design Name: 
// Module Name: encoder
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


module encoder(
input reset,
input CLK,
input A,
input B,
input[9:0] PPR,
output signed [9:0] P
    );
    
    wire [10:0] PPR_1;// THE PPR+1
    wire [10:0] Max;
    wire [10:0] Min;
 
 // reg index;
  reg signed [9:0] current_P = 0;
  reg signed [9:0] next_P;
  reg [4:0] current_state;
  reg [4:0] next_state;
  wire signed [10:0] lim1;
  wire signed [10:0] lim2;
  reg neg;
  reg pos;
  
   
   parameter wait_state = 4'h0;
   parameter inc_1= 4'h1;
   parameter inc_2 = 4'h2;
   parameter inc_3 = 4'h3;
   parameter dec_1 = 4'h4;
   parameter dec_2 = 4'h5;
   parameter dec_3 = 4'h6;
   parameter error = 4'h7;
   
    assign PPR_1 = PPR + 1;//  THE PPR+1 
    assign Max = (PPR_1/2)-1; 
    assign Min = ((-PPR_1)/2); 
    assign lim1 = PPR_1/2; 
    assign lim2 = ((-PPR_1)/2)-1; 
    
   // SET the index of encoder
   
//  always@(posedge CLK or posedge index or posedge reset) begin 

  always@(posedge CLK or posedge reset) begin 
        if (reset)
            begin
            //current_P <= 0;
            current_state <= wait_state; 
            end
     /*   else if (index) 
            begin
         //   current_P <= 0;
            current_state <= next_state;
            end 
            */
        else   
            begin 
        //    current_P <= next_P;
            current_state <= next_state;
            end
    end      
    
      
  always@(*) begin   
    next_state = current_state; 
    next_P = current_P;  
   // pos = 0;
  //  neg = 0;
  

 
  if (current_P == lim1) begin
  current_P = Min;
  end

  else if (current_P == lim2) begin
  current_P = Max;
  end
  
  else begin
  
   case(current_state)

     wait_state: 
                begin
                
                     pos = 0;
                     neg = 0; 
                    if (A==0 && B==0)
                        begin
                            next_state = wait_state;
                        end
                    else if (A==1 && B==0)
                            begin
                                next_state = inc_1;
                            end        
                     else if (A==0 && B==1)
                             begin
                                 next_state = dec_1;
                             end              
                     else
                        next_state =  error;                          
                end
          
 
     inc_1: 
                           begin
                               if (A==0 && B==0)
                                   begin
                                       next_state = wait_state;
                                   end
                               else if (A==1 && B==0)
                                       begin
                                           next_state = inc_1;
                                       end        
                                else if (A==1 && B==1)
                                        begin
                                            next_state = inc_2;
                                        end              
                                else
                                   next_state =  error;                          
                           end
                           
     inc_2: 
                               begin
                                  if (A==1 && B==0)
                                         begin
                                             next_state = inc_1;
                                          end
                                  else if (A==1 && B==1)
                                          begin
                                               next_state = inc_2;
                                           end        
                                  else if (A==0 && B==1)
                                           begin
                                               next_state = inc_3;
                                            end              
                                  else
                                     next_state =  error;                          
                                end                           
                              
      inc_3: 
                 begin
                            if (A== 1 && B==1)
                                 begin
                                       next_state = inc_2;
                                  end
                            else if (A==0 && B==1)
                                     begin
                                       next_state = inc_3;
                                     end        
                            else if (A==0 && B==0)
                                      begin
                                       next_state = wait_state;
                                       current_P = current_P+1;
                                     pos = 1;
                                      end              
                              else
                                        next_state =  error;                          
                        end                           
                                    
       dec_1: 
                                   begin
                                              if (A==0 && B==0)
                                                   begin
                                                         next_state = wait_state;
                                                    end
                                              else if (A==0 && B==1)
                                                       begin
                                                         next_state = dec_1;
                                                       end        
                                              else if (A==1 && B==1)
                                                        begin
                                                         next_state = dec_2;
                                                       
                                                        end              
                                                else
                                                          next_state =  error;                          
                                          end                                                  
                                    
      dec_2: 
                                                     begin
                                                                if (A==1 && B==1)
                                                                     begin
                                                                           next_state = dec_2;
                                                                      end
                                                                else if (A==0 && B==1)
                                                                         begin
                                                                           next_state = dec_1;
                                                                         end        
                                                                else if (A==1 && B==0)
                                                                          begin
                                                                           next_state = dec_3;
                                                                   
                                                                          end              
                                                                  else
                                                                            next_state =  error;                          
                                                            end               
                                                            
      dec_3: 
                                                                       begin
                                                                                  if (A==1 && B==1)
                                                                                       begin
                                                                                             next_state = dec_2;
                                                                                        end
                                                                                  else if (A==1 && B==0)
                                                                                           begin
                                                                                             next_state = dec_3;
                                                                                           end        
                                                                                  else if (A==0 && B==0)
                                                                                            begin
                                                                                             next_state = wait_state;
                                                                                             current_P = current_P - 1;
                                                                                       //    neg = 1;
                                                                                            end              
                                                                                    else
                                                                                              next_state =  error;                          
                                                                              end      
                                                                              
                                                                              
            error: 
              begin
              next_state =  wait_state;  
              
              end                                                                  
                                                                              
   endcase                                                                                                         
      
      end                                                                                
  
  end      
 /* 
  always @ (*) begin
    if (reset)
        begin
        current_P <= 0;
        end 
   
    else if (current_P == lim1) begin
    current_P <= Min;
    end

    else if (current_P == lim2) begin
    current_P <= Max;
    end
    else if (pos == 1) begin
    current_P <= current_P+1;
  
    end
    else if (neg == 1 )begin
    current_P <= current_P-1;

    end
    else begin
    current_P <= current_P;
    end
    
    
 
  end          
  */
  
  assign P = current_P;

endmodule

