module PC(
input logic [31:0] pc_in,
input  logic br_taken, clk, reset,
output logic [31:0] pc_out
);
always @(posedge clk ) begin
if(reset)
pc_out <= 0;
else
pc_out <= br_taken ? pc_in : pc_out + 4;
end
endmodule
