module register(input clk, reset, write_en,
    input logic [4:0] raddr1,raddr2,waddr, input logic [31:0] wdata,
	output logic [31:0] rdata1, rdata2);

// register file instantation
logic [31:0] register_file[32];
	
// control signals for validity 
assign addr1_valid = |raddr1;
assign addr2_valid = |raddr2;
assign wr_valid = |raddr2 & write_en;
	
//asynchronous read operation
assign rdata1 = (addr1_valid)
              ? register_file[raddr1]
			  : '0;
assign rdata2 = (addr2_valid)
              ? register_file[raddr2]
			  : '0;			  

//write operation
always_ff @( posedge clk) 
	begin
      if (reset) 
		begin
		//	register_file <= '{default : '0}; 
		end
      else if (wr_valid) 
		begin
			register_file[waddr] <= wdata; 
			$writememh("register_file.txt",register_file);
		end
	end
	
initial 
		begin
			$readmemh("register_file.txt",register_file); 
		end

endmodule 