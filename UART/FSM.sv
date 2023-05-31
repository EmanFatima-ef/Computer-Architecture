module FSM(input logic clk, reset, byte_ready_i, t_byte_i, counter_of_i, counter_baud_of_i,
                  output logic clear_baud_o, clear_o, load_xmt_dreg_o, load_xmt_shftreg_o, start_o, shift_o);
	
	
	
  	
	localparam  S0 = 2'b00;
	localparam  S1 = 2'b01;
	localparam  S2 = 2'b10;
	logic[1:0] ns,cs;
	
	always_ff @(posedge clk) begin 
	if (reset) begin
		cs <= S0;
		end else begin 
			cs <= ns;
			end
	end

	always_comb begin 
	case (cs) 
	S0: begin 
		if (!byte_ready_i) begin 
		ns = S0;
		end else begin 
		ns = S1;
		end 
	end 
	S1: begin 
	if (!t_byte_i) begin 
		ns = S1;
	end else begin 
		ns = S2;
		end 
	end 
	S2: begin 
	if ({counter_of_i, counter_baud_of_i} == 2'b11)
	     ns = S0;
	else ns = S2;
	end 
	endcase
end 

	// CS logic 
	always_comb begin 
	case (cs)
	S0: begin 
	if(!byte_ready_i) begin 
			clear_baud_o = 1;
			clear_o = 1;
			load_xmt_dreg_o = 1;
	end else begin 
			clear_baud_o = 1;
			clear_o = 1;
			load_xmt_dreg_o = 0;
		end 
	end 
	
	S1: begin 
		if (!t_byte_i) begin 
			clear_baud_o = 1;
			clear_o = 1;
			load_xmt_shftreg_o = 1;
	end else begin 
			clear_baud_o = 1;
			clear_o = 1;
			load_xmt_shftreg_o = 0;
		end 
	end
	
	S2: begin 
		if ({!counter_of_i,!counter_baud_of_i} & {counter_of_i,!counter_baud_of_i} == 2'b11 ) begin 
			start_o = 1;
		end else begin 
			shift_o = 1;
			start_o = 1;
		end
			
	end 
endcase 
end 

endmodule 

