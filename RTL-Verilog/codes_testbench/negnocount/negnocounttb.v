Test bench for counting no of negative numbers
//////////////////////////////////////////////////////////////////////////////////


module modutb;
parameter N=8,K=16; //constants declaration
reg clk,ready; reg signed [N-1:0] in_data; wire send_data,stop;reg[N-1:0] temp; wire[N-1:0] out_data;
integer i;reg signed [N-1:0] x_in[8:0];
modu DUT(.clk(clk),.ready(ready),.in_data(in_data),.out_data(out_data),.stop(stop),.send_data(send_data));

//clock generation
initial 
 begin
  clk=0;i=0;
  temp = 0;
  repeat(100)
  #3 clk=~clk;
 end
 
 initial
  begin
  $readmemb("input.dat",x_in); //Reads data from a file
  end
  
  always @(posedge clk) //at pos edge clk
  begin
  in_data=x_in[i]; //input data to in_data
  i=i+1;
  $display("T=%2d,in_data=%b,out_data=%d",$time,in_data,out_data); //displays output values
  end


endmodule
