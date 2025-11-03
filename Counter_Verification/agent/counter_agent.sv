class agent extends uvm_agent;
        `uvm_component_utils(agent)

        driver          drvh;
        monitor         monh;
        sequencer       seqrh;
        agent_config    agt_cfg;

function new(string name = "agent", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
                `uvm_fatal(get_type_name(),"Getting failed in agent")
        monh = monitor:: type_id :: create("monh", this);
        if(agt_cfg.is_active == UVM_ACTIVE)
                begin
                drvh = driver :: type_id :: create("drvh",this);
                seqrh = sequencer :: type_id :: create("seqrh",this);
                end
endfunction

function void connect_phase(uvm_phase phase);
        if(agt_cfg.is_active == UVM_ACTIVE)
                begin
                        drvh.seq_item_port.connect(seqrh.seq_item_export);
                end
endfunction
  
endclass

