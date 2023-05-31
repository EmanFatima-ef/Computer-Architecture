module shiftreg(
    input clk_i, load_byte_i, shift_i, reset_i,
	input logic [7:0] data_i,
	output logic serial_out_o
	);
	
	logic [8:0] shift_register;
	
	always_ff@(posedge clk_i) begin
		
		shift_register[0] <=0;
	
	  if (reset_i) begin
	      shift_register <=0; end
	  
	  else if (load_byte_i) begin
	      shift_register[8:1] <= data_i[7:0]; end
	  
	  else if (shift_i) begin
		  
	      shift_register <= {1'b0, shift_register[8:1]}; 
		 end
    serial_out_o <= shift_register[0];
	end
endmodule 