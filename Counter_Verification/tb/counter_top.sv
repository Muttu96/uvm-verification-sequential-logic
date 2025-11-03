module top;

        import uvm_pkg::*;
        import counter_pkg::*;

        `include "uvm_macros.svh"

        bit clk;
        always #5 clk=~clk;

        counter_if INF(clk);

        counter DUV(.clk(clk), .rstn(INF.rstn), .load(INF.load), .up_down(INF.up_down), .data_in(INF.data_in), .data_out(INF.data_out));

        initial
                begin
                        `ifdef VCS
                        $fsdbDumpvars(0,top);
                        `endif
                        uvm_config_db#(virtual counter_if)::set(null,"*","counter_if",INF);
                        run_test();
                end
endmodule

