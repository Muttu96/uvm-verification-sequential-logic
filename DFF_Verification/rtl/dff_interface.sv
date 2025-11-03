interface dff_if(input bit clk);
        logic rst;
        logic d;
        logic q;

        clocking drv_cb@(posedge clk);
                output rst;
                output d;
        endclocking

        modport DRV_MP(clocking drv_cb);

        clocking mon_cb@(posedge clk);
                input rst;
                input d;
                input q;
        endclocking

        modport MON_MP(clocking mon_cb);
endinterface

