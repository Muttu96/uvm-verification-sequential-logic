class dff_test extends uvm_test;
        `uvm_component_utils(dff_test)

        agent_config    agt_cfg;
        dff_env         envh;
        dff_sequence    seqh;

function new(string name= "dff_test", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt_cfg = agent_config :: type_id :: create("agt_cfg");
        if(!uvm_config_db#(virtual dff_if)::get(this,"","INF",agt_cfg.vif))
                `uvm_fatal(get_type_name(),"Getting failed in test")
        agt_cfg.is_active = UVM_ACTIVE;
        uvm_config_db#(agent_config)::set(this,"envh.agth*","agent_config",agt_cfg);
        envh = dff_env :: type_id :: create("envh", this);

        seqh = dff_sequence :: type_id :: create("seqh");

endfunction

task run_phase(uvm_phase phase);
        phase.raise_objection(this);
                seqh.start(envh.agth.seqrh);
                #40;
        phase.drop_objection(this);
endtask

endclass
