class driver extends uvm_driver#(counter_xtn);
        `uvm_component_utils(driver)

        virtual counter_if.DRV_MP vif;
        agent_config    agt_cfg;

function new(string name = "driver", uvm_component parent = null);
        super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
                `uvm_fatal(get_type_name(),"Getting failed in driver")
endfunction

function void connect_phase(uvm_phase phase);
        vif = agt_cfg.vif;
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology;
endfunction

task run_phase(uvm_phase phase);

         @(vif.drv_cb)
        vif.drv_cb.rstn <= 1'b1;

        @(vif.drv_cb)
        vif.drv_cb.load <= 1'b1;

        forever
                begin
                        seq_item_port.get_next_item(req);
                        send_to_dut(req);
                        seq_item_port.item_done();
                end
endtask

task send_to_dut(counter_xtn req);

 @(vif.drv_cb)
        `uvm_info("DRIVER",$sformatf("printing from driver%s",req.sprint()),UVM_LOW)

//      @(vif.drv_cb)
//      vif.drv_cb.rstn <= 1'b1;

//      @(vif.drv_cb)
//        vif.drv_cb.load <= 1'b1;

//      @(vif.drv_cb)
        vif.drv_cb.data_in <= req.data_in;

        @(vif.drv_cb)
        vif.drv_cb.load <= 1'b0;

        @(vif.drv_cb)
        vif.drv_cb.up_down <= req.up_down;

endtask

endclass
                             
