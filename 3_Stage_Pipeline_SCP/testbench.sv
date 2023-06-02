module tb_R;
    logic clk,reset;	
	datapath dut(.clk(clk), .reset(reset));
	
	initial begin
	clk = 0;
	forever begin
		#5 clk = ~clk;
	end
 end
	
    initial begin
	reset = 1;
	#10
	reset = 0;	
	#400
	$stop;
end
endmodule
