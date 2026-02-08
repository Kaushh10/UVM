class seq_checker extends uvm_component;

 `uvm_component_utils(seq_checker)  //uvm_factory regn

  //seq_packet gen_pkt, mon_pkt;

  // mailbox #(seq_packet) gen2chk;
  // mailbox #(seq_packet) mon2chk;
  // mailbox #(bit) result_mb;

  bit [5:0] exp_seq;  //sequence being detected(110101)
  bit [5:0] act_seq;  //actual sequence being fed into DUT
  bit exp_op;   //expected output from DUT (1: seq detected; 0: seq not detected)

  function new(string name= "Checker/scoreboard", uvm_component parent=null);
    super.new(name,parent);
    //shift = 6'b0;
  endfunction

//creating analysis port
  uvm_analysis_imp #(seq_packet, seq_checker) chk_ap;
  //  uvm_analysis_port #(seq_packet, seq_checker) m_analysis_port;

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    chk_ap = new("chk_ap", this); //instantiate analysis port

    if (!uvm_config_db#(bit[5:0])::get(this, "*", "exp_seq",exp_seq))   //get expected sequnce from uvm_config_db
`uvm_fatal("SCBD","Did not get exp_seq!")                         //else give fatal error that exp_seq is not found and exit the simulation

  endfunction


  function void write (seq_packet inbit);
      act_seq = act_seq << 1 | inbit.ip;    //left shift earlier seq in DUT and ORing the ip bit to it to get the latest sequence

      //display input bit, otuput bit, expected sequence, actual sequnce being created in the DUT
      `uvm_info ("SCBD", $sformatf("Current situation: in=%0b out=%0b ref=0b%0b act=0b%0b",inbit.ip,inbit.op,exp_seq,act_seq), UVM_LOW)

      if (!(exp_seq^act_seq))
        begin
     exp_op = 1;
        end
      else begin
          exp_op = 0;
        end

      if(inbit.op != exp_op)
      begin
        `uvm_error("CHECKER",$sformatf("Error: Seq doesn't match"))
      end
      else
        begin
          `uvm_info("CHECKER",$sformatf("Success: Seq matches"),UVM_HIGH)
        end
  endfunction
endclass
