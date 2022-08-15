

module encoder(
input reset,
input clk,
input A,
input B,
input[9:0] PPR,
output signed [9:0] P
    );
    
    wire [10:0] PPR_1;// THE PPR+1
    wire signed [10:0] Max;
    wire signed [10:0] Min;
 
  
  
  reg signed [9:0] current_P;
  reg signed [9:0] next_P;
  reg [4:0] current_state;
  reg [4:0] next_state;
  wire signed  [10:0] lim1;
  wire signed [10:0] lim2;
 // reg pos;
  //reg neg;
  
   
   parameter Error= 4'h0;
   parameter S1= 4'h1;  // AB 00
   parameter S2= 4'h2;  //AB  10
   parameter S3 = 4'h3; // AB 11
   parameter S4 = 4'h4; // AB 01

   
   
    assign PPR_1 = PPR + 1;//  THE PPR+1 
    assign Max = (PPR_1/2)-1; 
    assign Min = ((-PPR_1)/2); 
  //  assign lim1 = PPR_1/2; 
   // assign lim2 = ((-PPR_1)/2)-1; 
    
   // SET the index of encoder
   
//  always@(posedge CLK or posedge index or posedge reset) begin 

  always@(posedge clk or posedge reset) begin 
        if (reset)
            begin
            current_P <= 0;
            current_state <= Error; 
            end
        else begin
			   if( next_state == S1  && current_state == S4 )	
					begin 
					//	if(current_P < lim1 ) 
					  if(current_P < Max ) 
							begin 
							  current_P <= current_P + 1'b1;
							  
							end
						else 
							begin
							  current_P <= Min;
							end	
								
				    end
				else if (next_state == S4  && current_state == S1 )
					begin
					//	 if(current_P > lim2 ) 
					     if(current_P > Min ) 
							 begin 
							  current_P <= current_P - 1'b1;
						//	  neg_test <= 1;
						     end
						else 
							 begin
							   current_P <= Max;
					//		   neg_test <= 0;
						     end	
					end	
					
				else 
					begin
				       current_P <= current_P;
				
				   end
					 
					 
              current_state <= next_state;
       
          end
	
end	
   
      
  always@(current_state or A or B) begin   

   case(current_state)

     Error: 
                begin
				//   pos = 0;
			//	   neg = 0;

                     if (A==1 && B==0)
                            begin
                                next_state = S2 ;
							
                            end        
                     else if (A==0 && B==1)
                             begin
                                 next_state = S4 ;
                             end
                  else  if (A==0 && B==0)
                        begin
                            next_state = S1 ;
                        end	
                  else  if (A==1 && B==1)
                        begin
                            next_state = S3;
                        end		
						
                     else
                        next_state =  Error;                          
                end
          
		  
		
     S1: 
                           begin
							   
                               if (A==0 && B==0)
                                   begin
                                       next_state = S1;
                                   end
                               else if (A==1 && B==0)
                                       begin
                                           next_state = S2;
									//	   pos = 0;
										   
                                       end        
                                else if (A==0 && B==1)
                                        begin
                                            next_state = S4;
										//	next_P = next_P - 1'b1;
									//		neg = 1;
                                        end              
                                else
                                   next_state =  Error;                          
                           end
                           
     S2: 
                               begin
                                  if (A==1 && B==0)
                                         begin
                                             next_state = S2;
                                          end
                                  else if (A==1 && B==1)
                                          begin
                                               next_state = S3;
                                           end        
                                  else if (A==0 && B==0)
                                           begin
                                               next_state = S1;
                                            end              
                                  else
                                     next_state =  Error;                          
                                end                           
                              
      S3: 
                 begin
                            if (A== 1 && B==1)
                                 begin
                                       next_state = S3;
                                  end
                            else if (A==0 && B==1)
                                     begin
                                       next_state = S4;
                                     end        
                            else if (A==1 && B==0)
                                      begin
                                       next_state = S2;
                                       
                                    
                                      end              
                              else
                                        next_state =  Error;                          
                        end              
		

                                    
       S4: 
                                   begin   
									  
                                              if (A==0 && B==0)
                                                   begin
                                                         next_state = S1;
														 //next_P = next_P + 1'b1;
													//	 pos = 1;
														 
                                                    end
                                              else if (A==0 && B==1)
                                                       begin
                                                         next_state = S4;
                                                       end        
                                              else if (A==1 && B==1)
                                                        begin
                                                         next_state = S3;
                                                        //   neg = 0;
                                                        end              
                                                else
                                                          next_state =  Error;                          
                                          end                                                  
                                    
              
                                                                              
   endcase                                                                                                         
      
                                                                                     
  
  end      
 /*
  always @ (posedge  pos or posedge neg or posedge reset ) begin
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
	
	
    else if (neg)
	  begin
    current_P <= current_P - 1'b1;
   end
 
	else if (pos)
		begin
		current_P <= current_P+1;
		end

	else   
            begin 
          current_P <= current_P;

            end	
		
		
 end


	


   */ 

 
        
 
  
    assign P = current_P;
 //    assign State_test = current_state;
//	assign Next_state_test = next_state;
//	assign Next_p = next_P;
	
	endmodule