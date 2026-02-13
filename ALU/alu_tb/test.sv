`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;


class alu_test extends uvm_test;
`uvm_component_utils(alu_test)


alu_env env;
alu_reset_seq rst_seq;
alu_trans_seq trans_seq;


function new (string name = "alu_test", uvm_component parent = null);
super.new(name,parent);
endfunction : new

function void build_phase(uvm_phase phase);

super.build_phase(phase);
`uvm_info("TEST", "TEST : BUILD PHASE", UVM_MEDIUM)
env = alu_env::type_id::create("env",this);
endfunction : build_phase

function void connect_phase(uvm_phase phase);

super.connect_phase(phase);
`uvm_info("TEST", "TEST : CONNECT PHASE", UVM_MEDIUM)

endfunction : connect_phase


task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info("TEST", "TEST : RUN PHASE", UVM_MEDIUM)

phase.raise_objection(this);
rst_seq = alu_reset_seq::type_id::create("rst_seq");
rst_seq.start(env.agnt.seqr);
#10;
repeat(100)
begin
trans_seq = alu_trans_seq::type_id::create("trans_seq");
trans_seq.start(env.agnt.seqr);
#10;
end
phase.drop_objection(this);
endtask : run_phase

endclass : alu_test
