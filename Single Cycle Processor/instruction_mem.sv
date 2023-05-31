module instruction_mem(input logic [31:0] address, 
		output logic [31:0] inst_machine_code);
		
	logic [31:0] inst_memory [256]; 

initial 
	begin
		$readmemh("imem.txt", inst_memory);
	end
	assign inst_machine_code = {inst_memory[address[31:2]]};

endmodule