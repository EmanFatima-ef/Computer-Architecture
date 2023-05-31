module regfile(input logic clk, reset, stall, input logic [31:0] reg_in,
output logic [31:0] reg_out);
always_ff @(posedge clk) begin
if (reset) begin
reg_out <= 0;
end
else if (stall) begin
reg_out <= reg_out;
end
else if (!stall) begin
reg_out <= reg_in;
end
end
endmodule