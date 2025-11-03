class my_sequence extends uvm_sequence#(counter_xtn);
        `uvm_object_utils(my_sequence)

        function new(string name = "my_sequence");
                super.new(name);
        endfunction

        task body();
                repeat(10)
                        begin
                                req = counter_xtn :: type_id :: create("req");
                                start_item(req);
                                assert(req.randomize());
                                finish_item(req);
                        end
        endtask

endclass
