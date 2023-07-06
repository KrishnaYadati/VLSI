`timescale 1ns / 1ps
module HS(a,b,diff,borr);
input a,b; output diff,borr;
assign diff=~(a^b);
assign borr=~a&b;
endmodule
