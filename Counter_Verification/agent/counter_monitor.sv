class monitor extends uvm_monitor;
        `uvm_component_utils(monitor)
        virtual counter_if.MON_MP   vif;
        agent_config    agt_cfg;
        counter_xtn     xtn;
        uvm_analysis_port#(counter_xtn)ap;

function new(string name = "monitor", uvm_component parent = null);
        super.new(name,parent);
        ap = new("ap",this);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(agent_config)::get(this,"","agent_config", agt_cfg))
                `uvm_fatal(get_type_name(),"Getting failed in Monitor")
        xtn = counter_xtn :: type_id :: create("xtn");

endfunction

function void connect_phase(uvm_phase phase);
        vif = agt_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
        forever
                begin
                        collect_data();
                        ap.write(xtn);

                end
endtask
task collect_data();

        repeat(2)
        @(vif.mon_cb);
        xtn.rstn  = vif.mon_cb.rstn;

        @(vif.mon_cb)
        xtn.load  = vif.mon_cb.load;

        @(vif.mon_cb)
         xtn.data_in  = vif.mon_cb.data_in;

        repeat(2)
        @(vif.mon_cb);
        xtn.up_down  = vif.mon_cb.up_down;

        @(vif.mon_cb)
        xtn.data_out  = vif.mon_cb.data_out;

        `uvm_info("MONITOR",$sformatf("prinitng from monitor%s",xtn.sprint()),UVM_LOW)
endtask

endclass
                        
