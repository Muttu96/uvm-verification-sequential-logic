module counter(clk,rstn,load,up_down,data_in,data_out);
        input clk,rstn,load,up_down;
        input [3:0]data_in;
        output reg [3:0]data_out;

always@(posedge clk)
begin
        if(rstn == 1'b0)
                data_out <= 4'dx;

        else if(load == 1'b1 && data_in < 4'd12)
                data_out <= data_in;
        else
        begin
                if(up_down == 1'b1)
                begin
                        if(data_out == 4'd11)
                                data_out <= 4'd0;
                        else
                                data_out <= data_out + 1;
                end
                else
                begin
                        if(data_out == 4'd0)
                                data_out <= 4'd11;
                        else
                                data_out <= data_out - 1;
                end
        end
        $display("Time=%0t | rstn=%b | load=%b | up_down=%b | data_in=%0d | data_out=%0d",
           $time, rstn,  load, up_down, data_in, data_out);

end


endmodule

