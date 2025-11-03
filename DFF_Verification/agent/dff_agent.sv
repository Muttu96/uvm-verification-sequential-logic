class dff_agent extends uvm_agent;
        `uvm_component_utils(dff_agent)

        agent_config    agt_cfg;
        dff_driver      drvh;
        dff_monitor     monh;
        dff_sequencer   seqrh;

function new(string name = "dff_agent", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
                `uvm_fatal(get_full_name(),"Getting failed in agent")
        monh = dff_monitor :: type_id :: create("monh",this);
        if(agt_cfg.is_active == UVM_ACTIVE)
                drvh = dff_driver :: type_id :: create("drvh",this);
                seqrh = dff_sequencer :: type_id :: create("seqrh",this);
endfunction

function void connect_phase(uvm_phase phase);
        if(agt_cfg.is_active == UVM_ACTIVE)
                drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction

endclass
