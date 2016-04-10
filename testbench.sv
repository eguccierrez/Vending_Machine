module Testbench;
  
  reg serialIn;
  
  reg clk, reset;
  //reg apple, banana, carrot, date, error; 
  //reg [7:0] credit;
  
  reg buy;
  reg [1:0] product = 'b00;
  
  reg [6:0] digit1, digit0;
  
  VendingMachine VendingMachine1(clk, reset, serialIn, buy, product, digit1, digit0);
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      clk=1;
      reset=1;
      buy=0;
      serialIn = 0;
      #10 serialIn = 0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 product = 'b00;

      #10 buy = 1;
      #10 buy = 0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 product = 'b00;

      #10 buy = 1;
      #10 buy = 0;      
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 product = 'b00;

      #10 buy = 1;
      #10 buy = 0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 product = 'b01;

      #10 buy = 1;
      #10 buy = 0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;

      #10 product = 'b10;

      #10 buy = 1;
      #10 buy = 0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 product = 'b11;
      
      #10 buy = 1;
      #10 buy = 0;
       
      #10 reset = 0;
      #10 reset = 1;
      
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=1;
      #10 serialIn=0;
      
      #10 product = 'b00;
      
      #10 buy = 1;
      #10 buy = 0;
     
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      #10 serialIn=1;
      
      #10 reset = 0;
      #10 reset = 1;      
      
      #10 product = 'b11;
      
      #10 buy = 1;
      #10 buy = 0;
      #10 serialIn=0;
      #10 serialIn=1;
      #10 serialIn=0;
      $finish;
    end
  always #5 clk <= ~clk;
  
endmodule
