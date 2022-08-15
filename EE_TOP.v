

module EE_TOP(
input reset,
input [3:0]PR,
input[2:0] R,
input A,
input B,
//input C,
//input D,
input PWM_Input,

output PWM_AB,
output Drive,
output     Load,
output     Drive_Led,
output     Load_Led
    );

//reg CLK;
wire [23:0] Rate;
wire [9:0] PPR;
wire signed [9:0] P_AB;  // Original Position of encoder.
wire signed [9:0] P_CD;
wire [9:0] Position_AB;   // Converted Position for PWM.
wire [9:0] Position_CD;
wire [9:0] Position_Pen;

wire [1:0] State;

wire clk;
wire B_Db;
wire A_Db;
 
  OSCH #(
    .NOM_FREQ("10.23")
  ) internal_oscillator_inst (
    .STDBY(1'b0), 
    .OSC(clk)
  );     
   

/*
// Internal Oscillator
// defparam OSCH_inst.NOM_FREQ = "2.08";// This is the default frequency
 defparam OSCH_inst.NOM_FREQ = "10.23";
OSCH OSCH_inst( .STDBY(1'b0), // 0=Enabled, 1=Disabled
// also Disabled with Bandgap=OFF
 .OSC(clk),
 .SEDSTDBY()); // this signal is not required if not
// using SED
*/


debounce dba(
	.clk(clk),
    .Signal_in(A),
    .Signal_out(A_Db)

    );


debounce dbb(
	.clk(clk),
    .Signal_in(B),
    .Signal_out(B_Db)

    );



    encoder ecd(.reset(reset),
     .clk(clk),.A(A_Db),.B(B_Db),.PPR(PPR),.P(P_AB));
     

     
     Clock cok(.reset(reset),
      .clk(clk),.Rate(Rate),.CLK_PWM(CLK_PWM));
     
     Converters cvt(.PPR(PPR),
     .P(P_AB),.Position(Position_AB));

    
     PWM_Generator pga(
     .reset(reset),
     .CLK(CLK_PWM),

     .Position(Position_AB),
     .pwm(PWM_AB)
         );
   
         State_read str(
         .reset(reset),
         .clk(CLK_PWM),
         .pwm(PWM_Input),
         .State(State)
         
             );      
         
        PWM_Receiver prv(
         .reset(reset),
         .clk(CLK_PWM),
          .pwm(PWM_AB),
          .Position( Position_Pen)
         
             );  
            
         
    Pendulum pdm(
               .clk(CLK_PWM),
               .reset(reset),
              .Position( Position_Pen),
			// .Position( Position_AB),
               .State(State),
               .Drive(Drive),
               .Load(Load),
               .Drive_Led(Drive_Led),
               .Load_Led(Load_Led)
               
                 );     
         
         
         
/*
     PWM_Generator pgc(
     .reset(reset),
     .CLK(CLK_PWM),
  //  .CLK(clk),
   //  .PPR(PPR),
     .Position(Position_CD),
   //  .f(rate),
     .pwm(PWM_CD)
         );    
    
    */

    
   Rate_switch rsh(.reset(reset),
        .clk(clk),.R(R),.Rate_1(Rate));
          
 // PPR switch model from 64 to 1024
   PPR_switch psh(.reset(reset),
         .clk(clk),
         .PR(PR),
      .PPR_1(PPR)
    );
 
      
      
 
      
    
endmodule
