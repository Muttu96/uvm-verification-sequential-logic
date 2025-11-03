class dff_trans extends uvm_sequence_item;
        `uvm_object_utils(dff_trans)

        rand logic d;
        rand logic rst;
             logic q;

        constraint rst_c { rst dist {0:=9, 1:=1}; }
        constraint d_c   { d   inside {0, 1}; }

        function new(string name = "dff_trans");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);

                printer.print_field("d",this.d,1,UVM_BIN);
                printer.print_field("rst",this.rst,1,UVM_BIN);
                printer.print_field("q",this.q,1,UVM_BIN);

        endfunction
endclass
