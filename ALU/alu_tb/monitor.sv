`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_monitor extends uvm_monitor;
      `uvm_component_utils(alu_monitor)
      
      seq_item item;
      virtual alu_if vif;
      
      uvm_analysis_port #(seq_item) mon_port;
      
      function new(string name = "alu_monitor", uvm_component parent = null);
            super.new(name,parent);
      endfunction : new
      
      function void build_phase(uvm_phase phase);      
            super.build_phase(phase);
            `uvm_info("MON", "MONITOR : BUILD PHASE", UVM_MEDIUM)
            
        if(!uvm_config_db#(virtual alu_if) :: get(this,"*","vif",vif))
            `uvm_error("MON","FAILED TO GET INTERFACE FROM CONFIG_DB")

            mon_port = new("mon_port", this);      
      endfunction : build_phase
      
      function void connect_phase(uvm_phase phase);  
      super.connect_phase(phase);
      `uvm_info("MON", "MONITOR : CONNECT PHASE", UVM_MEDIUM)      
      endfunction : connect_phase
           
      task run_phase(uvm_phase phase);
            super.run_phase(phase);
            `uvm_info("MON", "MONITOR : RUN PHASE", UVM_MEDIUM)
            
            forever
                begin
                      item = seq_item::type_id::create("item");
                      wait(!vif.reset);
                      sample(item);
                      mon_port.write(item);
                end   
      endtask : run_phase
      
      task sample(seq_item item);
            @(posedge vif.clock)
                  item.a = vif.a;
                  item.b = vif.b;
                  item.opcode = vif.opcode;
            @(posedge vif.clock)
                  item.result = vif.result;
                  item.carry_out = vif.carry_out;
      endtask : sample
  
endclass : alu_monitor
