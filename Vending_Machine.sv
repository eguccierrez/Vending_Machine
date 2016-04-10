module VendingMachine(clk, reset, serialIn, buy, product, digit1, digit0);
  
  input serialIn;
  
  input clk, reset;
  reg apple, banana, carrot, date, error; 
  reg [7:0] credit;
  
  input buy;
  input [1:0] product;
  
  output reg [6:0] digit1, digit0;
  
  coinSensor coinSensor1(clk, reset, serialIn, penny, nickel, dime, quarter);
  
  Piggybank piggyBank1(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
  
  purchaseMngr purchaseMngr1(clk, buy, product, credit, apple, banana, carrot, date, error);
  
  sevenSegDispMngr sevenSegDispMngr1(clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);

endmodule

module coinSensor(clk, reset, serialIn, penny, nickel, dime, quarter);
  input clk, reset, serialIn;
  output reg penny, nickel, dime, quarter;
  
  reg sI_reg, reset_reg;
  
  initial penny = 0;	//Initialized the value of all coins to zero
  initial nickel = 0;
  initial dime = 0; 
  initial quarter = 0;
  
  reg [4:0] tmp;				//tmp is a five bit value
  initial tmp='b11111;			//tmp is initialized to the binary value 11111
 
  always @(posedge clk) begin	//at the positive edge the inputs are read
    sI_reg = serialIn;
    reset_reg = reset;
  end
  
  always @(negedge clk) begin   //clock is active low which causes a change in the outputs
    if(!reset_reg) begin        //if reset is active then reset the value of all coins to 0 and reset the tmp value back to 11111
      penny=0; 
      nickel=0; 
      dime=0; 
      quarter=0;
      tmp='b11111;
    end

    else begin					//else tmp gets the value of the input and makes it part of its binary and one of the coins is set to 1 if the binary value of tmp is either 0100, 00010, 01110 or 010101
      tmp = {sI_reg, tmp[4:1]}; 
      penny = (tmp[4:1]=='b0100);
      nickel = (tmp[4:0]=='b00010);
      dime = (tmp[4:0]=='b01110);
      quarter = (tmp[4:0]=='b01010);
      
      if(penny || nickel || dime || quarter) begin
        tmp = 'b11111;
      end
    
    end
    
  end  
  
endmodule

module Piggybank(clk,rst,penny,nickel,dime,quarter,apple,banana,carrot,date, credit);
  input clk,rst,penny,nickel,dime,quarter,apple,banana,carrot,date;
  output reg [7:0] credit;
  initial credit = 0;
  reg penny_reg,nickel_reg,dime_reg,quarter_reg,apple_reg,banana_reg,carrot_reg,date_reg,rst_reg;
  reg overflow = 0;
  
  always@(posedge clk)begin
    penny_reg=penny;
    nickel_reg=nickel;
    dime_reg=dime;
    quarter_reg=quarter;
    apple_reg=apple;
    banana_reg=banana;
    carrot_reg=carrot;
    date_reg=date;
    rst_reg=rst;
  end
  
  always@(negedge clk)begin
    if(~rst_reg)begin
      credit= 0;
    end
  end
  
  always @(negedge clk)begin
    if(penny_reg)begin
      {overflow,credit}= credit + 1;
    end
    else if(nickel_reg)begin
      {overflow,credit} = credit + 5;
    end
    else if(dime_reg)begin
      {overflow,credit} = credit + 10;
    end
    else if(quarter_reg)begin
      {overflow,credit} = credit + 25;
    end
    if(overflow==1)begin
      credit<=255;
      overflow<=0;
    end
  end
  
  always@(negedge clk)begin
    if(apple_reg)begin
      if(credit>=75)begin
        {overflow,credit}= credit - 75;
      end
    end
    else if(banana_reg)begin
      if(credit>=20)begin
        {overflow,credit} = credit - 20;
      end
    end
    else if(carrot_reg)begin
      if(credit>=30)begin
        {overflow,credit} = credit - 30;
      end
    end
    else if(date_reg)begin
      if(credit>=40)begin
        {overflow,credit} = credit - 40;
      end
    end
  end
  
endmodule


module purchaseMngr(clk,buy,product,credit,apple,banana,carrot,date,error);
  input clk,buy;
  input [1:0] product;
  input [7:0] credit;
  output reg apple, banana, carrot, date, error;
  reg buy_reg;
  reg [1:0] product_reg;
  reg [7:0] credit_reg;
  initial apple=0;
  initial banana=0;
  initial carrot=0;
  initial date=0;
  initial error=0;
  
  always@(posedge clk)begin
    buy_reg=buy;
    product_reg=product;
    credit_reg=credit;
  end
  
  always@(negedge clk)begin
    
    apple=0;
    banana=0;
    carrot=0;
    date=0;
    error=0; 
    
    if(buy_reg)begin
      if(product_reg==2'b00&&credit>=75)begin
        apple=1;
      end
      if(product_reg==2'b01&&credit>=20)begin
        banana=1;
      end
      if(product_reg==2'b10&&credit>=30)begin
        carrot=1;
      end
      if(product_reg==2'b11&&credit>=40)begin
        date=1;
      end
      if(product_reg==2'b00&&credit<75)begin
        error=1;
      end
      if(product_reg==2'b01&&credit<20)begin
        error=1;
      end
      if(product_reg==2'b10&&credit<30)begin
        error=1;
      end
      if(product_reg==2'b11&&credit<40)begin
        error=1;
      end
    end
  end
endmodule
    
    
module bcdto7(all_out,d_in);
  input [3:0] d_in;
  output reg [6:0] all_out;
  
  
  parameter STATE0= 7'b1000000;
  parameter	STATE1= 7'b1111001;
  parameter	STATE2= 7'b0100100;
  parameter	STATE3= 7'b0110000;
  parameter	STATE4= 7'b0011001;
  parameter	STATE5= 7'b0010010;
  parameter	STATE6= 7'b0000010;
  parameter	STATE7= 7'b1111000;
  parameter	STATE8= 7'b0000000;
  parameter	STATE9= 7'b0010000;
  parameter	STATEA= 7'b0001000;
  parameter	STATEB= 7'b0000011;
  parameter	STATEC= 7'b1000110;
  parameter	STATED= 7'b0100001;
  parameter	STATEE= 7'b0000110;
  parameter	STATEF= 7'b0001110;
  
  always @(d_in) begin
    if(d_in== 4'b0000)
      all_out=STATE0;
    else if(d_in== 4'b0001)
      all_out=STATE1;
    else if(d_in== 4'b0010)
      all_out=STATE2;
    else if(d_in== 4'b0011)
      all_out=STATE3;
    else if(d_in== 4'b0100)
      all_out=STATE4;
    else if(d_in== 4'b0101)
      all_out=STATE5;
    else if(d_in== 4'b0110)
      all_out=STATE6;
    else if(d_in== 4'b0111)
      all_out=STATE7;
    else if(d_in== 4'b1000)
      all_out=STATE8;
    else if(d_in== 4'b1001)
      all_out=STATE9;
    else if(d_in== 4'b1010)
      all_out=STATEA;
    else if(d_in== 4'b1011)
      all_out=STATEB;
    else if(d_in== 4'b1100)
      all_out=STATEC;
    else if(d_in== 4'b1101)
      all_out=STATED;
    else if(d_in== 4'b1110)
      all_out=STATEE;
    else if(d_in== 4'b1111)
      all_out=STATEF;
    else 
      all_out=STATE0;
  end
endmodule 

// Code your design here
module sevenSegDispMngr(clk,rst,apple,banana,carrot,date,error,credit,digit0,digit1);
  input clk,rst,apple,banana,carrot,date,error;
  input [7:0] credit;
  output [6:0] digit0;
  output [6:0] digit1;
  reg [7:0] credit_reg;
  reg [3:0] inp_bcd0;
  reg [3:0] inp_bcd1;
  reg apple_reg,banana_reg,carrot_reg,date_reg,error_reg,rst_reg;
  

  always@(posedge clk)begin
    inp_bcd0 = credit [3:0];
    inp_bcd1 = credit [7:4];
  	credit_reg=credit;
  	apple_reg=apple;
  	banana_reg=banana;
  	carrot_reg=carrot;
  	date_reg=date;
  	error_reg=error;
    rst_reg=rst;
  end
  
  always@(negedge clk)begin
    if(~rst_reg)begin
      inp_bcd0= credit_reg [3:0];
      inp_bcd1= credit_reg [7:4];
    end
      
    if((apple_reg||banana_reg||carrot_reg||date_reg||error_reg))begin
      if(apple_reg&&rst_reg)begin
        repeat(6)begin
          @(posedge clk);
          inp_bcd0=4'b1010;
          inp_bcd1=4'b1010;
        end
      end
      else if(banana_reg&&rst_reg)begin
        repeat(6)begin
          @(posedge clk);
          inp_bcd0=4'b1011;
          inp_bcd1=4'b1011;
        end
      end
      else if(carrot_reg&&rst_reg)begin
        repeat(6)begin
          @(posedge clk);
          inp_bcd0=4'b1100;
          inp_bcd1=4'b1100;
        end
      end
      else if(date_reg&&rst_reg)begin
        repeat(6)begin
          @(posedge clk);
          inp_bcd0=4'b1101;
          inp_bcd1=4'b1101;
        end
      end
      else if(error_reg&&rst_reg)begin
        repeat(6)begin
          @(posedge clk);
          inp_bcd0=4'b1110;
          inp_bcd1=4'b1110;
        end
      end
    end
    else if(~apple_reg&&~banana_reg&&~carrot_reg&&~date_reg&&~error_reg)begin
      inp_bcd0= credit_reg [3:0];
      inp_bcd1= credit_reg [7:4];
    end
  end
  
  bcdto7 BCD0(digit0,inp_bcd0);
  bcdto7 BCD1(digit1,inp_bcd1);
  
endmodule 
