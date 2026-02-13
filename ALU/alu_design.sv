`timescale 1ns / 1ps

module alu(
  input clock,
  input reset,
  input [7:0] A,B,                  
  input [3:0] ALU_Sel,
  output reg [7:0] ALU_Out, 
  output bit CarryOut 
);

  reg [7:0] ALU_Result;
  wire [8:0] tmp;

  assign tmp = {1'b0,A} + {1'b0,B};

  
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      ALU_Out  <= 8'd0;
      CarryOut <= 1'd0;
    end
    else begin
      ALU_Out <= ALU_Result;
      CarryOut <= tmp[8];
    end
  end


  always @(*) 
    begin
      case(ALU_Sel)
        4'b0000: //addition
          ALU_Result = A + B ; 
        4'b0001: // subtraction
          ALU_Result = A - B ;
        4'b0010: //multiplication
          ALU_Result = A * B;
        4'b0011: //division
          ALU_Result = A/B;
        //purposefully giving error to check if it comes up in the tb
        default: ALU_Result = 8'hAC ; 
      endcase
    end

endmodule
