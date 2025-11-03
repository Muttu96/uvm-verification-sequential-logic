interface counter_if(input bit clk);
        logic rstn,load,up_down;
        logic [3:0] data_in, data_out;

        clocking drv_cb@(posedge clk);
                output rstn,load,up_down, data_in;
        endclocking

        modport DRV_MP(clocking drv_cb);

        clocking mon_cb@(posedge clk);
                input rstn,load,up_down, data_in, data_out;
        endclocking

        modport MON_MP(clocking mon_cb);

endinterface
