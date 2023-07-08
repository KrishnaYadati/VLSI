This bwlow code is used like a Rectifier
//////////////////////////////////////////////////////////////////////////////////


module rectifier(clk,ready,in_data,stop,send_data,out_data);
parameter N=16;parameter K=42;
input clk,ready;input signed [N-1:0] in_data;reg [N-1:0] J;
output reg stop;output reg send_data;output[N-1:0] out_data;
integer i=0;

always@(posedge clk)
begin
 
  if(ready) //if ready=1 then send data otherwise don't send.
  begin
    send_data<=1;
    stop<=0;
    end
  else 
    stop<=1;
    end
    
  always @(posedge clk) // at positive edge clock
  begin
  J=in_data; //data is stored in J b;
  if(J[N-1]) // if MSB of data is 1 
  begin
  J=~J+1;//2's complement
  i=i+1; 
  end
  else
  J=in_data;
 end

assign out_data=J;   //outputs temp to out_data

endmodule
