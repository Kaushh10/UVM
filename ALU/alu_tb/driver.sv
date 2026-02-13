`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_driver extends uvm_driver #(seq_item);
      `uvm_component_utils(alu_driver)
      
      seq_item item;
      virtual alu_if vif;
      
      function new(string name = "alu_driver", uvm_component parent = null);
            super.new(name,parent);
      endfunction : new
      
      function void build_phase(uvm_phase phase);
      
            super.build_phase(phase);
            `uvm_info("DRV", "Driver : BUILD PHASE", UVM_MEDIUM)
            
            if(!uvm_config_db#(virtual alu_if) :: get(this,"*","vif",vif))
                    `uvm_error("DRV","FAILED TO GET INTERFACE FROM CONFIG_DB")
          
      endfunction : build_phase
      
      function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("DRV", "Driver : CONNECT PHASE", UVM_MEDIUM)     
      endfunction : connect_phase
      
      task run_phase(uvm_phase phase);
            super.run_phase(phase);
            `uvm_info("DRV", "Driver : RUN PHASE", UVM_MEDIUM)            
            forever begin
                item = seq_item :: type_id :: create("item");
                seq_item_port.get_next_item(item);
                drive(item);
                seq_item_port.item_done();
            end    
      endtask : run_phase
      
      task drive(seq_item item);
      
            @(posedge vif.clock)
            vif.reset <= item.reset;
            vif.a <= item.a;
            vif.b <= item.b;
            vif.opcode <= item.opcode;
      
      endtask : drive

endclass : alu_driver
