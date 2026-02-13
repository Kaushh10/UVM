`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_scoreboard extends uvm_test;
`uvm_component_utils(alu_scoreboard)

seq_item trans[$];

uvm_analysis_imp #(seq_item,alu_scoreboard) scb_port;

function new(string name = "alu_scoreboard",uvm_component parent = null);
super.new(name,parent);
endfunction : new


function void build_phase(uvm_phase phase);

`uvm_info("SCB","Scoreboard Build Phase",UVM_MEDIUM)
scb_port = new("scb_port",this);

endfunction : build_phase

function void connect_phase(uvm_phase phase);

`uvm_info("SCB","Scoreboard Connect Phase",UVM_MEDIUM)

endfunction : connect_phase


function void write(seq_item item);
trans.push_back(item);
endfunction : write


task run_phase(uvm_phase phase);

super.run_phase(phase);
`uvm_info("SCB", "Scoreboard Run phase", UVM_MEDIUM)

forever begin

seq_item curr_item;
wait(trans.size()!=0);
curr_item = trans.pop_front();
compare(curr_item);

end

endtask : run_phase 

task compare(seq_item curr_trans);
logic [7:0] expected;
    logic [7:0] actual;
    
    case(curr_trans.opcode)
      0: begin //A + B
        expected = curr_trans.a + curr_trans.b;
      end
      1: begin //A - B
        expected = curr_trans.a - curr_trans.b;
      end
      2: begin //A * B
        expected = curr_trans.a * curr_trans.b;
      end
      3: begin //A / B
        expected = curr_trans.a / curr_trans.b;
      end
    endcase
    
    actual = curr_trans.result;
    
    if(actual != expected) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual, expected))
    end
    else begin
      // Note: Can display the input and op_code as well if you want to see what's happening
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual, expected), UVM_LOW)
    end
    
  endtask: compare

endclass : alu_scoreboard
