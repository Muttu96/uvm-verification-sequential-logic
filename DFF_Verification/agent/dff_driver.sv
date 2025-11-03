class dff_driver extends uvm_driver#(dff_trans);
        `uvm_component_utils(dff_driver)

        virtual dff_if.DRV_MP vif;
        agent_config    agt_cfg;

function new(string name = "dff_driver", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
                `uvm_fatal(get_type_name(),"Getting failed in driver")
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology;
endfunction

function void connect_phase(uvm_phase phase);
        vif = agt_cfg.vif;
endfunction

task run_phase(uvm_phase phase);

        forever
                begin
                        seq_item_port.get_next_item(req);
                        send_to_dut(req);
                        seq_item_port.item_done();
                end
endtask
task send_to_dut(dff_trans req);

        `uvm_info("dff_driver",$sformatf("printing from driver%s",req.sprint()),UVM_LOW)
        @(vif.drv_cb)
        vif.drv_cb.rst <= req.rst;

        @(vif.drv_cb);

        @(vif.drv_cb);
        vif.drv_cb.d <= req.d;
endtask

endclass
