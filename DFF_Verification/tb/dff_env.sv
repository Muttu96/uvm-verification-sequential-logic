class dff_env extends uvm_env;
        `uvm_component_utils(dff_env)

        dff_agent agth;
        dff_scoreboard  sbh;

function new(string name = "dff_env", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agth = dff_agent :: type_id :: create("agth", this);
        sbh = dff_scoreboard :: type_id :: create("sbh",this);
endfunction

function void connect_phase (uvm_phase phase);
        agth.monh.ap.connect(sbh.ai);
endfunction

endclass

