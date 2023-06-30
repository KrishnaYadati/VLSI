`timescale 1ns / 1ps

module xnortb; 
reg a,b; wire y; //declare inputs as regs,outputs as wires
xnorgate XNOR(.a(a),.b(b),.y(y)); // connect inputs and outputs to corresponding testbench i/o s
initial
begin
$monitor ($time,"a=%b,b=%b,y=%b",a,b,y);
#3 a=0;b=0;
#3 b=1;
#3 a=1;b=0;
#3 b=1;
#5 $finish;
end
endmodule
