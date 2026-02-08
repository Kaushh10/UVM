`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_packet.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environemnt.sv"
`include "test.sv"
import uvm_pkg::*;

module top;

  bit clk = 0;
  always #5 clk = ~clk;

  seq_if vif(clk);

  Seqdetector_110101 dut (
    .clk(clk),
    .rst(vif.rst),
    .ip(vif.ip),
    .op(vif.op)
  );

  initial begin
    // vif.rst = 1;
    // vif.rst = 0;

    clk <= 0;
    //uvm_config_db#(virtual seq_if)::set(null, "top", "seq_vif", sif);
    uvm_config_db#(virtual seq_if)::set(uvm_root::get(), "*", "seq_vif", vif);
    run_test("test_110101");
  end

endmodule
