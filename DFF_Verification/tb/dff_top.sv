module dff_top;

        import uvm_pkg::*;
        import dff_pkg::*;

        `include "uvm_macros.svh"

        bit clk;
        always #5 clk = ~clk;

        dff_if INF(clk);

        dff DUV(.clk(clk), .rst(INF.rst), .d(INF.d), .q(INF.q));

        initial
                begin
                        `ifdef VCS
                        $fsdbDumpvars(0,dff_top);
                        `endif

                        uvm_config_db#(virtual dff_if)::set(null,"*","INF",INF);
                        run_test();
        end
endmodule

