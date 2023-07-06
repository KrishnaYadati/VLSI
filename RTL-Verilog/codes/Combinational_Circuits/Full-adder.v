`timescale 1ns / 1ps
module HA(a,b,c,Sum,Carry);
input a,b,c; output Sum,Carry;
assign Sum=a^b^c;
assign Carry=(a&b)|(b&c)|(c&a);
endmodule
