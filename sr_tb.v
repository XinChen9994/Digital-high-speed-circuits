`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/27 13:29:41
// Design Name: 
// Module Name: sr_tb
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


module sr_tb(

    );
    
    reg reset;
    reg clk;
    reg SCL;
    reg SDA;
    reg SDA_Enable;
    wire[3:0] PR;
    wire[2:0] Rate;
    wire SDA_In;
    
   
    
    
    serial_receiver  srr(
    .reset(reset),
    .clk(clk),
    .SCL(SCL),
    .SDA(SDA_In),
    .SDA_Enable(SDA_Enable),
    .PR(PR),
    .Rate(Rate)
    
        );
        
        assign SDA_In = SDA_Enable ? 1'bz : SDA;
       initial begin
              reset = 1;#125 
              reset = 0;#125;
              reset = 0;#125;
              end
              
             initial begin
             clk=1;
             forever #125 clk=~clk;
             end   
             
             initial begin
             SDA_Enable = 0;
            
             SDA = 1;
            // #562//
            #500
             SDA = 0;
            #375
      //   #125
         
             SDA =1; //BITS 0-6;
             #1750 //250*6
             SDA = 0;  //BIT 7
             #250
             SDA_Enable = 1;
             SDA = SDA_In; // ACK OR NACK
             #250
             SDA_Enable = 0; // STOP
             SDA = 1;
             
             #5125 // 2nd test 01010101  rate010 ppr 1010
                SDA = 0;
                #125
               // #375
                SDA =0; //BIT 0
                #250 //
                SDA = 1;  //BIT 1
                #250
                SDA =0; //BIT 2
                #250 //
                SDA = 1;  //BIT 3
                #250
                SDA =0; //BIT 4
                #250 //
                SDA = 1;  //BIT 5
                #250
                SDA =0; //BIT 6
                #250 //
                SDA = 1;  //BIT 7
                #250
                SDA_Enable = 1;
                SDA = SDA_In; // ACK OR NACK
                #250
                SDA_Enable = 0; // STOP
                SDA = 1;             
             
            end 
             
            initial begin
             SCL = 1;
             #625  
             SCL = 0;
             #375
            // #125
             SCL = 1;
             #125      //0
             SCL = 0;
             #125             
             SCL = 1;
             #125       //1     
             SCL = 0;
             #125
             SCL = 1;
             #125        //2                
             SCL = 0;
             #125
             SCL = 1;
             #125        //3    
             SCL = 0;
             #125
             SCL = 1;
             #125        //4    
             SCL = 0;
             #125
             SCL = 1;
             #125        //5     
             SCL = 0;
             #125
             SCL = 1;
             #125        //6   
             SCL = 0;
             #125
             SCL = 1;
             #125        //7
             
             SCL = 0;
             #125
             SCL = 1;
             #125        //ACK
             SCL = 0;
             #125
             SCL = 1;
                 //STOP   
                 
                 
                #5125 
                 SCL = 0;
                 #125
              //   #375
                 SCL = 1;
                 #125      //0
                 SCL = 0;
                 #125             
                 SCL = 1;
                 #125       //1     
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //2                
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //3    
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //4    
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //5     
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //6   
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //7
                 
                 SCL = 0;
                 #125
                 SCL = 1;
                 #125        //ACK
                 SCL = 0;
                 #125
                 SCL = 1;
                     //STOP      
          end


                                                                                     
   /*     
             initial begin
             SDA_Enable = 0;
             SCL = 1;
             SDA = 1;
             #500
             SDA = 0;
             #125
             
             SCL = 0; // MSB 1
           //  #50 //
          //  #250  //
             #125
             SDA = 1;
             SCL = 1;
             #125
             
             SCL = 0; //  2
             SDA = 1;
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  3
             SDA = 1;
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  4
             SDA = 1;
             #125
             SCL = 1;
             #125
             
             
             SCL = 0; //  5
             SDA = 1;
             #125
             SCL = 1;
             #125
       
             SCL = 0; //  6
             SDA = 1;
             #125
             SCL = 1;
             #125      
       
       
             SCL = 0; //  7
             SDA = 1;
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  8
             SDA = 0;
             #125
             SCL = 1;
             SDA = 0;
             #125
            // SDA = SDA_In;//
            
            
             
       //     SDA_Enable = 1;
             SCL = 0; //  ACK
       //      SDA = SDA_In;
             #125
               SDA = SDA_In;//
               SDA_Enable = 1;
             SCL = 1;
             #125
             
             SDA_Enable = 0;
       //      SDA = 1'bz;//
             SCL = 1; //STOP
             #125
            SDA = 1;
             
             
              #5000 // PPR and Rate 2
             SDA = 0; // 
             #125
             
             SCL = 0; // MSB 1           
             #125
             SDA = 1;//
             SCL = 1;
             #125
             
             SCL = 0; //  2
             SDA = 1;//
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  3
             SDA = 0;//
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  4
             SDA = 1;//
             #125
             SCL = 1;
             #125
             
             
             SCL = 0; //  5
             SDA = 1;//
             #125
             SCL = 1;
             #125
       
             SCL = 0; //  6
             SDA = 0;//
             #125
             SCL = 1;
             #125      
       
       
             SCL = 0; //  7
             SDA = 0;//
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  8
             SDA = 1;//
             #125
             SCL = 1;
             #125
             
             SCL = 0; //  ACK
             SDA = 1;//
             #125
             SCL = 1;
             #125
             
             SCL = 1; //STOP
             #125
             SDA = 1;
       
       
       
       
          #5000 // PPR and Rate 3
                       SDA = 0;
                       #125
                       
                       SCL = 0; // MSB 1
                       SDA = 1;
                       #125
                       SCL = 1;
                       #125
                       
                       SCL = 0; //  2
                       SDA = 0;
                       #125
                       SCL = 1;
                       #125
                       
                       SCL = 0; //  3
                       SDA = 1;
                       #125
                       SCL = 1;
                       #125
                       
                       SCL = 0; //  4
                       SDA = 0;
                       #125
                       SCL = 1;
                       #125
                       
                       
                       SCL = 0; //  5
                       SDA = 1;
                       #125
                       SCL = 1;
                       #125
                 
                       SCL = 0; //  6
                       SDA = 0;
                       #125
                       SCL = 1;
                       #125      
                 
                 
                       SCL = 0; //  7
                       SDA = 1;
                       #125
                       SCL = 1;
                       #125
                       
                       SCL = 0; //  8
                       SDA = 0;
                       #125
                       SCL = 1;
                       #125
                       
                                    SCL = 0; //  ACK
                       SDA = 1;//
                       #125
                       SCL = 1;
                       #125
                       
                       SCL = 1; //STOP
                       #125
                       SDA = 1;
             end   
        
        */
    
endmodule
