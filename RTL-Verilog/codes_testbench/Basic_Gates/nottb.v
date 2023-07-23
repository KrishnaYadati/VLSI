`timescale 1ns / 1ps

module nottb; 
reg a; wire y; //declare inputs as regs,outputs as wires
notgate NOT(.a(a),.y(y)); // connect inputs and outputs to corresponding testbench i/o s
initial
begin
$monitor ($time,"a=%b,y=%b",a,y);
#3 a=0;
#3 a=1;
#5 $finish;
end
endmodule
