`timescale 1ns / 1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_sequencer extends uvm_sequencer#(seq_item);
      `uvm_component_utils(alu_sequencer)
      
      function new(string name = "alu_sequencer", uvm_component parent = null);
            super.new(name,parent);
      endfunction : new

  //sequencer build phase
      function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info("SEQR", "Sequencer : BUILD PHASE", UVM_MEDIUM)      
      endfunction : build_phase

  //sequencer connect phase
      function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("SEQR", "Sequencer : CONNECT PHASE", UVM_MEDIUM)
      endfunction : connect_phase

endclass : alu_sequencer
