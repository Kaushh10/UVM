`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

//base sequence
class alu_base_seq extends uvm_sequence;
  `uvm_object_utils(alu_base_seq)

      seq_item item;
      
      function new (string name = "alu_base_seq");
            super.new(name);
            `uvm_info("BASE_SEQ", "Inside alu_base_seq constructor",UVM_HIGH)
      endfunction : new 
      
      task body();
            `uvm_info("BASE_SEQ", "Inside alu_base_seq BODY",UVM_HIGH)
            
            item = seq_item::type_id::create("item");
            start_item(item);
            item.randomize();
            finish_item(item);
      endtask : body

endclass : alu_base_seq


//reset sequence for the alu
class alu_reset_seq extends alu_base_seq;
      `uvm_object_utils(alu_reset_seq)
      
      seq_item item;
      
      function new (string name = "alu_reset_seq");
            super.new(name);
            `uvm_info("RST_SEQ", "Inside alu_reset_seq constructor",UVM_HIGH)
      endfunction : new 
      
      task body();
            `uvm_info("RST_SEQ", "Inside alu_reset_seq BODY",UVM_HIGH)
            
            item = seq_item::type_id::create("item");
            start_item(item);
            item.randomize() with { reset == 1'b1;};
            finish_item(item);   
      endtask : body

endclass : alu_reset_seq


//transmission sequence for the alu
class alu_trans_seq extends alu_base_seq;
      `uvm_object_utils(alu_trans_seq)
      
      seq_item item;
      
      function new (string name = "alu_trans_seq");
            super.new(name);
            `uvm_info("TRANS_SEQ", "Inside alu_trans_seq constructor",UVM_HIGH)
      endfunction : new 
      
      task body();
            `uvm_info("TRANS_SEQ", "Inside alu_trans_seq BODY",UVM_HIGH)
            
            item = seq_item::type_id::create("item");
            start_item(item);
            item.randomize() with {reset == 1'b0;};
            finish_item(item);  
      endtask : body

endclass : alu_trans_seq
