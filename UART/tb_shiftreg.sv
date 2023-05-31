module tb_shiftreg;

logic[7:0] data_i;
logic clk_i, load_byte_i, shift_i, reset_i,serial_out_o;

	shiftreg dut(clk_i, load_byte_i, shift_i, reset_i, data_i, serial_out_o);
	
	initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end

    initial begin
                reset_i = 0;
		load_byte_i=1; shift_i=0; data_i=8'b11100111; 
                @(posedge clk_i);
                load_byte_i=0; shift_i=1;  
                @(posedge clk_i);
                load_byte_i=0; shift_i=1; 
	        repeat(12)@(posedge clk_i);
                reset_i = 1;
		$stop;
    end

endmodule