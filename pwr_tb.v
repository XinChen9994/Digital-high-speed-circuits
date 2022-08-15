

module pwr_tb(

    );
    reg reset;
    wire clk;
  //  reg pwm;
    wire[9:0] Position;
    wire PWM_CD;
//    reg reset;
   // reg PPR;
    reg[9:0] Position_CD;
 //   reg rate;
  wire CLK_PWM;
    wire [23:0] Rate;
	reg [2:0]R;
 
 // Internal Oscillator
// defparam OSCH_inst.NOM_FREQ = "2.08";// This is the default frequency
defparam OSCH_inst.NOM_FREQ = "10.23";
OSCH OSCH_inst( .STDBY(1'b0), // 0=Enabled, 1=Disabled
// also Disabled with Bandgap=OFF
.OSC(clk),
.SEDSTDBY()); // this signal is not required if not
// using SED
        

   Rate_switch rsh(.reset(reset),
        .clk(clk),.R(R),.Rate_1(Rate));
          
 
 
      Clock cok(.reset(reset),
      .clk(clk),.Rate(Rate),.CLK_PWM(CLK_PWM));
 
 
       
        
        initial begin
//    PR = 4'b1001; //PPR=600
  //   PR = 4'b1111; //PPR=1024
  //  R=3'b000; // PMW rate  = 1ms
    reset = 1;#125 
    reset = 0;#125;
    reset = 0;#125;
    end
    

     initial begin
		 R = 3'b000;
		 #2000000
		  R = 3'b001;
		  #4000000
		  R = 111;
		 end
           
        // increaing test for encoder
           initial begin
                #500
                 Position_CD = 1;
                  #500000
                Position_CD = 1022;
                        #500000
                Position_CD = 400;
                          #500000
                Position_CD = 100;
                          #500000
                Position_CD = 100;
                          #500000
                Position_CD = 1;
                          #1000000
                Position_CD = 1022;
                            #500000
                Position_CD = 2;
                            #500000
                Position_CD = 3;
                            #500000
                Position_CD = 0;
                            #500000
                Position_CD = 1000;
                             #500000  
                Position_CD = 1023;                               
                             #500000 
                 Position_CD = 1021; 
                            #500000 
                 Position_CD = 0; 
                            #500000 
                 Position_CD = 1021; 
                end
                
           
    
    
    
    
    
    
    
    PWM_Generator pgc(
    .reset(reset),
    .CLK(CLK_PWM),
 //   .PPR(PPR),
    .Position(Position_CD),
 //   .f(rate),
    .pwm(PWM_CD)
        ); 
    
    PWM_Receiver  pmr(
    .reset(reset),
    .clk(CLK_PWM),
    .pwm(PWM_CD),
    .Position(Position)
    
        );
endmodule
