interface seq_if(input bit clk);
  logic rst;
  logic ip;
  logic op;

  // clocking drv_cb @(posedge clk);
  //   output ip, rst;
  // endclocking

  // clocking mon_cb @(posedge clk);
  //   input ip, op, rst;
  // endclocking

  clocking cb @(posedge clk);
    default input #1ns output #1ns;
    input op;
    output ip;
  endclocking

  // 1. Define the Property Logic ONLY
  // This property checks: If 'op' is high, then in the next cycle it must be low.
  property z_one_cycle;
    @(posedge clk) op |-> ##1 !op;
  endproperty

  // 2. Assert the Property with Action Blocks
  // The code inside 'begin...end' runs on PASS.
  // The code after 'else' runs on FAIL.
  // assert property (z_one_cycle)
  //   begin
  //     // PASS Action Block
  //     `uvm_info("INF", "Property asserted successfully: op dropped after 1 cycle", UVM_LOW)
  //   end
  // else
  //   begin
  //     // FAIL Action Block
  //     `uvm_error("SEQ_IF", "The z_one_cycle failed assertion: op remained high for more than one cycle")
  //   end
 
endinterface
