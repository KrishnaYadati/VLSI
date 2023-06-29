Test bench to check prek finder working 
//////////////////////////////////////////////////////////////////////////////////


module peakfindertb;
parameter N=16,K=42; //constants declaration
reg clk,ready; reg signed [N-1:0] in_data; wire send_data,stop; wire [N-1:0] out_data;
integer i,fid;reg signed [N-1:0] x_in[K-1:0];
peakfinder DUT(.clk(clk),.ready(ready),.in_data(in_data),.out_data(out_data),.stop(stop),.send_data(send_data));

//clock generation
initial 
 begin
  clk=0;i=0;
  repeat(100)
  #1 clk=~clk;
 end
 
 initial
  begin
  $readmemb("sinusoid.dat",x_in); //Reads data from a file
  end
  
  always @(posedge clk) //at pos edge clk
  begin
  ready=1; 
  in_data=x_in[i]; //input data to in_data
  i=i+1;
  $display("T=%2d,in_data=%b,out_data=%d",$time,in_data,out_data); //displays output values
  end
 /* 
  initial
  fid=$fopen("/home/krishna/Peakfinder/outdata.csv","w");
  always @(posedge clk)
begin
if(out_data)
$fwrite(fid,"%d \n", $signed(out_data[15:0]));     
end
initial 
begin
#1000
$fclose(fid);
$finish;
end
*/
endmodule
