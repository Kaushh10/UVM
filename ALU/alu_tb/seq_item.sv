`timescale 1ns / 1ps

`include "uvm_macros.svh"
import uvm_pkg::*;


class seq_item extends uvm_sequence_item; 
`uvm_object_utils(seq_item) 

rand bit [7:0] a,b; 
rand bit [3:0] opcode; 
rand bit reset;

bit [7:0] result; 
bit carry_out; 

  //create new item
function new(string name = "seq_item");
super.new(name); 
endfunction : new

  //constraints 
constraint op_c {
	opcode inside {[2'b00 : 2'b11]};
	} 

endclass : seq_item
