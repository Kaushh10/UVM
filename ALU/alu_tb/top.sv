`timescale 1ns / 1ps
import alu_stuff::*;

module tb;

bit clock;

initial
forever #2 clock = ~clock;

alu_if intf(.clock(clock));

alu DUT(.clock(intf.clock),
        .reset(intf.reset),
        .A(intf.a),
        .B(intf.b),
        .ALU_Sel(intf.opcode),
        .ALU_Out(intf.result),
        .CarryOut(carry_out));

initial
uvm_config_db #(virtual alu_if)::set(null,"*","vif",intf);

initial 
run_test("alu_test");
endmodule

interface alu_if (input logic clock);
logic reset;

logic [7:0] a, b;
logic [3:0] opcode;
logic reset;

logic [7:0] result;
logic carry_out;

endinterface : alu_if
