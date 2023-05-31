module ALU(input logic [31:0]operand_1,operand_2, 
 input logic [3:0] operator,
 output logic [31:0] result);

 always_comb 
 begin
 
 case(operator)

 4'b0000: result = operand_1 + operand_2;
 4'b0001: result = operand_1 - operand_2;
 4'b0010: result = operand_1 << operand_2[4:0];
 4'b0011: result = $signed (operand_1) < $signed(operand_2) ? 1:0;
 4'b0100: result = operand_1 < operand_2 ? 1:0;
 4'b0101: result = operand_1 ^ operand_2;
 4'b0110: result = operand_1 >> operand_2[4:0];
 4'b0111: result = operand_1 >>> operand_2[4:0];
 4'b1000: result = operand_1 | operand_2;
 4'b1001: result = operand_1 & operand_2;
 4'b1010: result = operand_2;
 
 endcase
 end
endmodule