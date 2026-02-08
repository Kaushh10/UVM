class seq_agent extends uvm_agent;
`uvm_component_utils(seq_agent)

  function new(string name = "Sequence agent", uvm_component parent= null);
    super.new(name,parent);
  endfunction

  driver d0;
  seq_monitor sqm0;
  uvm_sequencer #(seq_packet) s0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(seq_packet)::type_id::create("s0", this);
    d0 = driver::type_id::create("d0", this);
    sqm0 = seq_monitor::type_id::create("sqm0", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction

endclass
