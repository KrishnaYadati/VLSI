'timescale 1ns / 1ps

module ormux; 
reg I0,I1; wire y; //declare inputs as regs,outputs as wires
andgate OR(.I0(I0),.I1(I1),.y(y)); // connect inputs and outputs to corresponding testbench i/o s
initial
begin
$monitor ($time,"I0=%b,I1=%b,y=%b",I0,I1,y);
#3 I0=1;sel=0;
#3 I1=1;sel=1;
#5 $finish;
end
endmodule
