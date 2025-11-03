class agent_config extends uvm_sequence_item;//#(trans);
        `uvm_object_utils(agent_config)

        virtual counter_if vif;
        uvm_active_passive_enum is_active;

function new(string name = "agent_config");
        super.new(name);
endfunction

endclass
