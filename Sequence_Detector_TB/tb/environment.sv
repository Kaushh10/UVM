//sequence environment extends uvm_environment
class seq_env extends uvm_env;
`uvm_component_utils(seq_env)


  function new(string name = "Environment", uvm_component parent= null);
    super.new(name,parent);
  endfunction

  seq_agent a0;
  seq_checker sc0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0 = seq_agent::type_id::create("a0", this);
    sc0 = seq_checker::type_id::create("sb0", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a0.sqm0.mon_ap.connect(sc0.chk_ap);
  endfunction

endclass
