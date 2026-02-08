class pkt_seq extends uvm_sequence;

`uvm_object_utils(pkt_seq)

    function new(string name="Packet sequence");
        super.new(name);
    endfunction

    rand int pkt_num;   //total no of packets to be sent

    constraint c1  {pkt_num inside {[10:50]};}

    virtual task body();
        for(int i=0; i<pkt_num; i=i+1)
            begin
                seq_packet  m_seq_packet = seq_packet::type_id::create("m_seq_packet");

                // if(!m_seq_packet.randomize()) `uvm_error("SEQ", "Rand failed") // Randomize FIRST

                if (!m_seq_packet.randomize()) begin
                    `uvm_error("SEQ", "RANDOMIZATION FAILED! Check constraints.")
                    end
                else
                 begin
                    `uvm_info("SEQ", ("Randomized value given"), UVM_HIGH)
                end

           start_item(m_seq_packet);

           // if (!m_seq_packet.randomize())
                //     begin
                //         `uvm_error("SEQ", "Randomization failed")
                //     end

                `uvm_info("SEQ", $sformatf("Generate new packet: %s", m_seq_packet.convert2str()), UVM_HIGH)

             finish_item(m_seq_packet);
            end
            `uvm_info("SEQ", $sformatf("Generation of %0d packets done", pkt_num), UVM_LOW)
    endtask
endclass
