module ALU #(parameter N =32)(input logic [N-1:0]a,b, input logic [1:0]c,
					output logic [N-1:0]out);
		logic [N-1:0] add;
		always_comb begin 
		
		if (c[1]==0) begin 
			   if (c[0]) begin 
			 	add = ~b;
				end else begin 
					add = b;
				end
			out = a+add+c[0];
			end 
		case(c)
			2'b10: out = a>>b;
			2'b11: out = a<<b;
			endcase
end
endmodule



