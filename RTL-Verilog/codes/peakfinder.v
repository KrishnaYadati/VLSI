
module peakfinder(clk,ready,in_data,stop,send_data,out_data);
parameter N=16, K=42;
input clk,ready;input signed [N-1:0] in_data;reg [N-1:0] J;
output reg stop;output reg send_data;output[N-1:0] out_data;
integer i=0;reg [N-1:0] R;reg [N-1:0] temp=0;reg [N-1:0] num[K-1:0];

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
   J=in_data; //data is stored in J 
   if(J[N-1]==0) // if MSB of data is 0 
      begin
    num[i]=J;
    i=i+1;
    //assign out_data=num[i]; 
    end
    //assign out_data=num[i]; 
   end 
    
 always @(posedge clk)
 begin
  temp=num[0];
   for(i=1;i<K;i=i+1)
     if(num[i]>temp)
    temp=num[i];
    
        end
 
  
      // end

assign out_data=temp;   //outputs temp to out_data

endmodule