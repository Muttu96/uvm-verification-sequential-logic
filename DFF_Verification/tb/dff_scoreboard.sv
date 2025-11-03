class dff_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(dff_scoreboard)
        dff_trans dff_xtn;
        uvm_analysis_imp#(dff_trans, dff_scoreboard)ai;

covergroup dff_cg with function sample(bit rst, bit d, bit q);

        RESET : coverpoint rst
                {bins rst0 = {0};
                 bins rst1 = {1};}
        INPUT_D : coverpoint d
                {bins d0 = {0};
                 bins d1 = {1};}
        OUTPUT_Q :coverpoint q
                {bins q0 = {0};
                 bins q1 = {1};}

//       RSTxD : cross RESET, INPUT_D;
  //       RSTxQ : cross RESET, OUTPUT_Q;
  //     DxQ   : cross INPUT_D, OUTPUT_Q;
//       FULL_CROSS : cross RESET, INPUT_D, OUTPUT_Q;

endgroup

//      dff_cg dff_cgh;

function new(string name = "dff_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        ai = new("ai",this);
        dff_cg = new();
endfunction


function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        dff_xtn = dff_trans :: type_id :: create("dff_xtn");
endfunction
function void write(dff_trans dff_xtn);
        bit ex_q;
        if(dff_xtn.rst)
                begin
                        ex_q = 0;
                end
        else
                begin
                        ex_q = dff_xtn.d;
                end

        if(dff_xtn.q !== ex_q)
                begin
                        `uvm_error("DFF_SCOREBOARD", "mismatch in the values of q")
                end
        else
                begin
                        `uvm_info("D FLIP FLOP SCOREBOARD","comparision successfull", UVM_LOW)
                end
        dff_cg.sample(dff_xtn.rst, dff_xtn.d, dff_xtn.q);

endfunction

endclass

