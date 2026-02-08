`timescale 1ns / 1ps    //timescale declaration
//module declaration
module Seqdetector_110101(
input ip, rst, clk, //inputs are ip, clk, rst
output op); //output is op

localparam[2:0]    //define cases as local parameters
reset = 3'b000,
got1 =  3'b001,
got11 = 3'b010,
got110 = 3'b011,
got1101 = 3'b100,
got11010 = 3'b101,
got110101 = 3'b110;
reg [2:0]current;   //defining current case

always @(posedge clk)
begin
if(rst)   //if rst==1
current <= reset;   //current state is reset
else
case(current)
reset : current <= (ip==1'b1) ? got1 : reset;
got1 : current <= (ip==1'b1) ? got11 : reset;
got11 : current <= (ip==1'b0) ? got110 : got1;
got110 : current <= (ip==1'b1) ? got1101 : reset;
got1101 : current <= (ip==1'b0) ? got11010 : got11;
got11010 : current <= (ip==1'b1) ? got110101 : reset;
got110101 : current <= (ip==1'b1) ? got11 : got110;
default : current <= reset;   //default case is reset which gives output as zero
endcase
end
assign op = (current == got110101) ? 1'b1 : 1'b0;  // op==1 if sequence 110101 is detected, else op==0

endmodule
