module fir(clk,ready,stop,in_data,out_data,send_data);
parameter N=16,K=41;
input ready,clk; input signed [N-1:0] in_data;output stop,send_data; output [31:0] out_data;
integer i=0;reg [N-1:0] R;reg [N-1:0] temp=0;reg signed [N-1:0] buff0,buff1,buff2,buff3,buff4;reg signed [K-1:0] acc0,acc1,acc2,acc3,acc4;
wire signed [7:0] tap0,tap1,tap2,tap3,tap4; 


assign tap0=8'b0;
assign tap1=8'b00000110;
assign tap2=8'b00000110;
assign tap3=8'b00000110;
assign tap4=8'b0;

always @(posedge clk)
begin
R=in_data; 
if(ready == 1)
 begin
   buff0 <= R;
   buff1 <= buff0;        
   buff2 <= buff1;         
   buff3 <= buff2;      
   buff4 <= buff3; 
 end
 else
  begin
   buff0 <= buff0;
   buff1 <= buff1;        
   buff2 <= buff2;         
   buff3 <= buff3;      
   buff4 <= buff4;      
  end
  end  
  always @ (posedge clk)
   begin
   if (ready==1)
    begin
    acc0 <= tap0 * buff0;
    acc1 <= tap1 * buff1;
    acc2 <= tap2 * buff2;
    acc3 <= tap3 * buff3;
    acc4 <= tap4 * buff4;                 
end

 end
assign    out_data= acc0 + acc1 + acc2 + acc3 + acc4;  

endmodule
