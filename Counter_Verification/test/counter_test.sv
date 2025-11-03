class test extends uvm_test;
        `uvm_component_utils(test)

        agent_config    agt_cfg;
        env             envh;

        my_sequence     my_seqh;

function new(string name= "test", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt_cfg = agent_config :: type_id :: create(" agt_cfg", this);
        agt_cfg.is_active = UVM_ACTIVE;
        if(!uvm_config_db#(virtual counter_if)::get(this,"","counter_if",agt_cfg.vif))
                `uvm_fatal(get_type_name(),"Getting failed")
        uvm_config_db#(agent_config)::set(this,"envh.agth*","agent_config",agt_cfg);

        envh = env :: type_id :: create("envh", this);

        my_seqh = my_sequence :: type_id :: create("my_seqh");

endfunction

task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        my_seqh.start(envh.agth.seqrh);
        #100;
        phase.drop_objection(this);
endtask

endclass

