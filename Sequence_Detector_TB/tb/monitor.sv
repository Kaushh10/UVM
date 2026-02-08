class seq_monitor extends uvm_monitor;
 seq_packet pkt;
  `uvm_component_utils(seq_monitor)

  virtual seq_if vif;
 
  uvm_analysis_port  #(seq_packet) mon_ap;

  covergroup seq_cg;
    coverpoint vif.ip;
    coverpoint vif.op;
  endgroup

  function new(string name = "seq_monitor", uvm_component parent=null);
    super.new(name,parent);
    seq_cg = new(); //create space for new covergroup
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // MUST CREATE THE PORT
    mon_ap = new("mon_ap", this);
   
    if (!uvm_config_db#(virtual seq_if)::get(this, "", "seq_vif", vif))
      `uvm_fatal("MON", "Could not get vif")
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
      @(vif.cb);
        if(vif.rst) begin
                    pkt = seq_packet::type_id::create("packet");
                    pkt.ip = vif.cb.ip;
                    pkt.op = vif.cb.op;
                    mon_ap.write(pkt);

                    // Sample Coverage
                    seq_cg.sample();

                    `uvm_info("MON", $sformatf("Recorded pkt %s",pkt.convert2str()), UVM_HIGH)
                  end      
    end
  endtask
endclass
