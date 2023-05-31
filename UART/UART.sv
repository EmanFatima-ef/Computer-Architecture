module UART(input byte_ready_i, t_byte_i, clk, reset_i, 
            input logic [7:0] data_i,
			output Tx);
Baudcount B1(clk, clear_baud_o, counter_baud_of_i);

Bitcount Ba1(clk, clear_o, counter_of_i);

FSM c1(clk, reset_i, byte_ready_i, counter_of_i, counter_baud_of_i, t_byte_i, clear_baud_o, clear_o, load_xmt_dreg_o, load_xmt_shftreg_o, start_o, shift_o);

shiftreg s1(.clk_i(clk), .load_byte_i(load_xmt_dreg_o), .shift_i(load_xmt_shftreg_o), .reset_i(reset_i), .data_i(data_i), .serial_out_o(shift_reg));

mux m1(start_o, shift_reg, Tx);

endmodule