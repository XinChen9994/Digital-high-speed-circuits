


module Con_tb(

    );
     
       reg CLK;

       reg[9:0] PPR;
       reg signed [9:0] P;
       wire [9:0] Position;
       
        Converters utt(.PPR(PPR),.P(P),.Position(Position));
        
        
           initial begin
           PPR = 599;
           P = 200;
           #500;
           PPR = 599;
           P = 144;
           #500;
           PPR = 599;
           P = -127;
           #500;
           PPR = 599;
           P = 0;
           #500;
           PPR = 599;
           P = -188;
           #500;
		   
		   
		   PPR = 399;
           P = 200;
           #500;
         
           P = 144;
           #500;
         
           P = -127;
           #500;
     
           P = 0;
           #500;
       
           P = -188;
           #500;
           
           end
               initial begin
           CLK=0;
           forever #5 CLK=~CLK;
           end
        
    
    
    
    
endmodule
