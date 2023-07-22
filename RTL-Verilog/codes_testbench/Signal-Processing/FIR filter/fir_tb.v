`timescale 1ns / 1ps
module firtb;
parameter N=49,K=2048; //constants declaration
parameter W_in=16;
parameter W_in_F =14;
parameter W_out =W_in + 16+N;
parameter W_out_F=W_in_F;
parameter W_coef=16;
parameter xL=2048;


reg clk;
wire signed [15:0] out_data;

reg resetn_,resetn_fir;
wire m_tvalid;
wire signed [15:0] m_tdata;

fir #(
  .N(N),.W_in(W_in),.W_in_F(14),.W_out(W_out),.W_coef(W_coef)) fir_dut 
(.clk(clk),.resetn(resetn_fir),.t_data_in(m_tdata),.t_valid_in(m_tvalid),.t_ready(tready),.out_data(out_data),
  .out_valid(out_valid)  );

datasrc #(.xL(xL)) src_dut(.clk(clk),.resetn(resetn_),.tready(tready),.tvalid(m_tvalid),.tdata(m_tdata));
//clock generation
always #3 clk=~clk;

integer fp_write_out;
initial  
begin
  clk=0;
  resetn_fir=0;
  fp_write_out = $fopen("/home/krishna/vivado/fir/output_rtl_vsim.csv","w");      
  #2 resetn_=0;
  #10 resetn_fir=1;
  #5 resetn_=1;
  #10000 $fclose(fp_write_out);
end
always @(posedge clk ) begin
  if (out_valid)
   $fwrite(fp_write_out,"%b\n",out_data);
end


endmodule
