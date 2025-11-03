class scoreboard extends uvm_scoreboard;
        `uvm_component_utils(scoreboard)
        uvm_analysis_imp#(counter_xtn, scoreboard)ai;
        counter_xtn xtn;
        bit [3:0] exp_data_out = 4'b0;

covergroup counter_cg;

        LOAD : coverpoint xtn.load
                        { bins load0 = {0};
                          bins load1 = {1};}

        UP_DOWN : coverpoint xtn.up_down
                        { bins up_down0 = {0};
                          bins up_down1 = {1};}

        DATA_IN : coverpoint xtn.data_in
                        { bins data_in0 = {[0:15]};}

        DATA_OUT: coverpoint xtn.data_out
                        { bins data_out0 = {[0:15]};}

endgroup



function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
        ai = new("ai",this);
        counter_cg = new();
endfunction

function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        xtn = counter_xtn :: type_id :: create("xtn");
endfunction
function void write(counter_xtn xtn);
    this.xtn = xtn;
        if(xtn.rstn == 1)
                begin
                        if(xtn.load == 1)
                                exp_data_out = xtn.data_in;
                        else
                                begin
                                        if(xtn.up_down == 1)
                                                exp_data_out++;
                                        else
                                                exp_data_out--;
                                end
                end
        else
                exp_data_out = 4'bx;


        if(xtn.data_out !== exp_data_out)
                begin
                        `uvm_error("SCOREBOARD", "mismatch in the values of q")
                end
        else
                begin
                        `uvm_info("SCOREBOARD","comparision successfull", UVM_LOW)
                end
`uvm_info("SCOREBOARD", $sformatf(
    "Sampling coverage: rstn=%0b load=%0b up_down=%0b data_in=%0d data_out=%0d",
    xtn.rstn, xtn.load, xtn.up_down, xtn.data_in, xtn.data_out), UVM_LOW)

        counter_cg.sample();

endfunction


endclass

