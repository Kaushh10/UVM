`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_agent extends uvm_agent;
      `uvm_component_utils(alu_agent)
      
      alu_driver drv;
      alu_monitor mon;
      alu_sequencer seqr;
      
      
      function new (string name  = "alu_agent", uvm_component parent = null);
            super.new(name,parent);
      endfunction : new
      
      
      function void build_phase(uvm_phase phase);
            `uvm_info("AGENT", "Agent : BUILD PHASE", UVM_MEDIUM)     
                  drv = alu_driver::type_id::create("drv",this);
                  mon = alu_monitor::type_id::create("mon",this);
                  seqr = alu_sequencer::type_id::create("seqr",this);
            
      endfunction 
      
      
      function void connect_phase(uvm_phase phase);
            `uvm_info("AGENT", "Agent : CONNECT PHASE", UVM_MEDIUM)
            drv.seq_item_port.connect(seqr.seq_item_export);
      endfunction 
      
      task run_phase(uvm_phase phase);
            `uvm_info("AGENT", "Agent : RUN PHASE", UVM_MEDIUM)
            super.run_phase(phase);
      endtask 

endclass : alu_agent

