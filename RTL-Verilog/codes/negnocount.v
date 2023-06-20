This Module counts no.of negative nums in the input
//////////////////////////////////////////////////////////////////////////////////


module modu(clk,ready,in_data,stop,send_data,out_data);
parameter N=8; parameter K=16;
input clk,ready;input signed [N-1:0] in_data;reg [N-1:0] J;
output reg stop;output reg send_data;output[N-1:0] out_data;
integer i;reg[N-1:0] temp = 0;reg stop;

always@(posedge clk)
begin
 
  if(ready) //if ready=1 then send data otherwise don't send.
    send_data<=1;
  else 
    stop<=1;
    end
    
  always @(posedge clk) // at positive edge clock
  begin
  J<=in_data; //data is stored in J
  if(J[N-1]) // if MSB of data is 1
  temp<=temp+1; //increment temp
  end
  
assign out_data=temp;   //outputs temp to out_data

endmodule
