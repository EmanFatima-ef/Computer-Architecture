module mux(input logic start_o, shift_reg,
				output logic Tx);
				
			always_comb begin 
      
				if (start_o) begin 
					Tx = shift_reg;
				end else begin 
					Tx = 1'b1;
				end 
			end 
endmodule 
	