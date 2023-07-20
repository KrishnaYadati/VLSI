`timescale 1ns / 1ps
module andmux(I0,I1,sel,y); 
input I0,I1,sel; output y;
assign y=sel?I1:I0;
endmodule
