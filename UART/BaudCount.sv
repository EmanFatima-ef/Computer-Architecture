module Baudcount(
    input clk, clear_baud_o,
	output logic counter_baud_of_i
	);
	logic i;
	always_comb begin
	  if (clear_baud_o) begin
	      if (i <=5) begin
	           i = i + 1; end
		  else begin
		  i = 0;
	             counter_baud_of_i = 1; end

		 end
    end
endmodule 