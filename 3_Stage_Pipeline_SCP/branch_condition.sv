module branch_condition(input logic [2:0] br_type,
input logic [31:0] A, B,
output logic br_taken
);
always_comb begin
br_taken = 0;
case(br_type)
//BEQ
3'b000: if (A == B)
br_taken = 1;
//BNE
3'b001: if (A != B)
br_taken = 1;
//BLT
3'b010: if ($signed(A) < $signed(B))
br_taken = 1;
//BGT
3'b100: if ($signed(A) > $signed(B))
br_taken = 1;
//BLTU
3'b011: if (A < B)
br_taken = 1;
//BGEU
3'b101: if (A >= B)
br_taken = 1;
//J type
3'b110 :
br_taken = 1;  
endcase
end
endmodule
