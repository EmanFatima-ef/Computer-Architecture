module Bitcount(
    input clk, clear_o, 
	output logic counter_of_i
	);
	logic i;
	always_comb begin
	  if (clear_o) begin
	      if (i <= 9) begin
	           i = i + 1; end
		  else begin
		  i = 0;
	          counter_of_i = 1; end

		 end
    end
endmodule   