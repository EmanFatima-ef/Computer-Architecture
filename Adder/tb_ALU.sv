module tb_ALU;

logic[31:0] A,B,Out;
logic [1:0] C1;

	ALU dut(.a(A),.b(B),.c(C1),.out(Out));
	initial begin 
	A = 32'd5;
	B = 32'd6;
	C1 = 2'b00;
	#10
	C1 = 2'b01;
	#10
	C1 = 2'b10;
	#10
	C1 = 2'b11;
	#10
	A = 32'd8;
	B = 32'd0;
	C1 = 2'b00;
	#10
	C1 = 2'b01;
	#10
	C1 = 2'b10;
	#10
	C1 = 2'b11;
	#10
	A = 32'd10;
	B = 32'd5;
	C1 = 2'b00;
	#10
	C1 = 2'b01;
	#10
	C1 = 2'b10;
	#10
	C1 = 2'b11;
	#10
	$stop;
end
endmodule



