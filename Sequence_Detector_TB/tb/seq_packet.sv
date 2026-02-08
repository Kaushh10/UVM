`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_packet extends uvm_sequence_item;

`uvm_object_utils(seq_packet)

  rand bit ip;
  logic op;

  virtual function string convert2str();
    return $sformatf("in=%0b, out=%0b",ip,op);
  endfunction

  function new(string name="seq_packet");
    super.new(name);
  endfunction

  // constraint c0 { ip dist {0:/20, 1:/80}; }

  constraint c0 { ip dist {0 := 50, 1 := 50}; }

endclass: seq_packet
