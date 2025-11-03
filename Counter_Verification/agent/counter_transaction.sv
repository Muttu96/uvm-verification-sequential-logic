class counter_xtn extends uvm_sequence_item;
        `uvm_object_utils(counter_xtn)

                 logic rstn;
                 logic load;
        rand  logic up_down;
        rand  logic[3:0] data_in;
             logic[3:0] data_out;

//      constraint vld_rstn{ rstn inside {1,0};} //dist{ 1:=9, 0:=1};}
//      constraint vld_load{ load inside {1,0};} //dist{1:=1, 0:=1 };}
        constraint vld_ud  { up_down inside {1,0};} //dist{1:=1, 0:=1};}
        constraint vld_data_in{ data_in inside {[0:11]};}

        function new(string name = "counter_xtn");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);
                printer.print_field("rstn",this.rstn,1,UVM_BIN);
                printer.print_field("load",this.load,1,UVM_BIN);
                printer.print_field("up_down",this.up_down,1,UVM_BIN);
                printer.print_field("data_in",this.data_in,4,UVM_DEC);
                printer.print_field("data_out",this.data_out,4,UVM_DEC);
        endfunction
endclass
