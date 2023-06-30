`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2023 10:53:01 AM
// Design Name: 
// Module Name: ortb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ortb; 
reg a,b; wire y; //declare inputs as regs,outputs as wires
andgate OR(.a(a),.b(b),.y(y)); // connect inputs and outputs to corresponding testbench i/o s
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
