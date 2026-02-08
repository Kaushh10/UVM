`timescale 1ns/1ps
//`include "packet.sv"
// import uvm_pkg::*;

class driver extends uvm_driver #(seq_packet);
`uvm_component_utils (driver)

uvm_seq_item_pull_port #(seq_packet) seq_packet_port;

    virtual seq_if vif;

    function new(string name = "driver",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if (!uvm_config_db#(virtual seq_if)::get(this, "", "seq_vif", vif))
      `uvm_fatal("DRIVER", "Could not get vif")
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever
        begin
            seq_packet m_seq_packet;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"),UVM_HIGH)
            seq_item_port.get_next_item(m_seq_packet);
            //drive_item(m_seq_packet);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_packet(seq_packet m_seq_packet);
    @(vif.cb);
        vif.cb.ip <= m_seq_packet.ip;
    endtask

endclass: driver
