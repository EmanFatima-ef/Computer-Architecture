module tb_UART;

logic[7:0] data_i;
logic byte_ready_i, t_byte_i, Tx, clk, reset_i ;

	UART dut(byte_ready_i, t_byte_i, clk, reset_i, data_i, Tx);
	
	initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
                reset_i   = 1;
		#50
                reset_i   = 0;
		byte_ready_i = 0;
		t_byte_i = 0 ;
		data_i = 8'b0000101;
                #50
                byte_ready_i = 1; t_byte_i = 0 ;
                #50
                t_byte_i = 1 ; byte_ready_i = 0;
                #50
                t_byte_i = 1 ; byte_ready_i = 0;
                #50
                reset_i   = 1;
		        #50
				//Next Input
                reset_i   = 0; byte_ready_i = 0; t_byte_i = 0 ; data_i = 8'b0000011;
                #50
                byte_ready_i = 1; t_byte_i = 0 ;
                #50
                t_byte_i = 1 ; byte_ready_i = 0;
                #50
                t_byte_i = 1 ; byte_ready_i = 0;
		$stop;
    end
endmodule