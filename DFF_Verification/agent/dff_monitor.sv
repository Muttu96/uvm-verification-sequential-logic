class dff_monitor extends uvm_monitor;
        `uvm_component_utils(dff_monitor)
        virtual dff_if.MON_MP   vif;
        agent_config    agt_cfg;
         dff_trans       dff_xtn;

        uvm_analysis_port#(dff_trans)ap;

function new(string name = "dff_monitor", uvm_component parent = null);
        super.new(name,parent);
        ap = new("ap",this);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
                `uvm_fatal(get_type_name(), "Getting failed in monitor")
        dff_xtn = dff_trans :: type_id :: create("dff_xtn");
endfunction

function void connect_phase(uvm_phase phase);
        vif = agt_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
        repeat(2)
        @(vif.mon_cb);
        forever
                begin
                        collect_data();
                        ap.write(dff_xtn);
                end
endtask

task collect_data();

        @(vif.mon_cb);
        dff_xtn.rst = vif.mon_cb.rst;

        @(vif.mon_cb);
        dff_xtn.d = vif.mon_cb.d;

        @(vif.mon_cb);

        dff_xtn.q = vif.mon_cb.q;

        `uvm_info("dff_monitor",$sformatf("printing from monitor%s",dff_xtn.sprint()),UVM_LOW)

endtask

endclass

