`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_env extends uvm_env;
`uvm_component_utils(alu_env)

alu_agent agnt;
alu_scoreboard scb;

function new (string name = "alu_env",uvm_component parent = null);
super.new(name,parent);
endfunction : new


function void build_phase(uvm_phase phase);
`uvm_info("ENV", "Environment : BUILD PHASE", UVM_MEDIUM)
agnt = alu_agent::type_id::create("agnt",this);
scb = alu_scoreboard::type_id::create("scb",this);

endfunction : build_phase


function void connect_phase(uvm_phase phase);
`uvm_info("ENV", "Environment : CONNECT PHASE", UVM_MEDIUM)

agnt.mon.mon_port.connect(scb.scb_port);

endfunction : connect_phase

task run_phase(uvm_phase phase);
`uvm_info("ENV", "Environment : RUN PHASE", UVM_MEDIUM)
super.run_phase(phase);
endtask : run_phase

endclass : alu_env
