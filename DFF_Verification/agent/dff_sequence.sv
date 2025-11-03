class dff_sequence extends uvm_sequence#(dff_trans);
        `uvm_object_utils(dff_sequence)

        function new(string name = "dff_sequence");
                super.new(name);
        endfunction

        task body();
        dff_trans dff_xtn;
                repeat(20)
                        begin
                                dff_xtn = dff_trans :: type_id :: create("dff_xtn");
                                start_item(dff_xtn);
                                assert(dff_xtn.randomize());
                                finish_item(dff_xtn);
                        end
        endtask

endclass
