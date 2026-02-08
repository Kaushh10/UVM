import uvm_pkg::*;

class seq_test extends uvm_test;
`uvm_component_utils(seq_test)

  function new(string name = "Seq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  seq_env e0;
  bit [5:0] seekwens = 6'b110101;
  pkt_seq seqq;
  virtual seq_if vif;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      e0 = seq_env::type_id::create("e0",this);

        if (!uvm_config_db#(virtual seq_if)::get(this,"","seq_vif",vif))
      `uvm_fatal("TEST", "Did not get virtual interface")

    uvm_config_db#(virtual seq_if)::set(this, "e0.a0.*", "seq_vif",vif);

    //write the queue of sequence(here: seekwens) you want to detect and place into config db
    uvm_config_db#(bit[5:0])::set(this,"*","exp_seq", seekwens);

    //create sequence from sequence.sv
    seqq = pkt_seq::type_id::create("seq");

    //seqq.randomize();
  endfunction

virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    apply_reset();

    if (!seqq.randomize()) begin
      `uvm_error("RAND", "Sequence randomization failed")
    end

    seqq.start(e0.a0.s0);

    #200;
    phase.drop_objection(this);
  endtask

  virtual task apply_reset();
    vif.rst <= 0;
    vif.ip <= 0;
    repeat(5) @ (posedge vif.clk);
    vif.rst <= 1;
    repeat(10) @ (posedge vif.clk);
  endtask
endclass

class test_110101 extends seq_test;
  `uvm_component_utils(test_110101)

  function new(string name="test_110101", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    seekwens = 6'b110101;
    super.build_phase(phase);
   //seqq.randomize() with { pkt_seq inside {[300:500]}; };
  endfunction

  virtual task run_phase(uvm_phase phase);
    //perform specific randomization for this test
    //assuming 'num' is the variable inside pkt_seq
    if (!seqq.randomize() /*with { pkt_seq inside {[300:500]}; }*/) begin
       `uvm_error("RAND", "test_110101 randomization failed")
    end
   
    //call super.run_phase to execute the reset and start the sequence
    super.run_phase(phase);
  endtask
endclass
