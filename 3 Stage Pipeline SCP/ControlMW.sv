module ControlMW(input logic reset, clk, reg_wr, wr_en, rd_en,stall,input logic [1:0] wb_sel,
                        output logic reg_wrMW, wr_enMW, rd_enMW,output logic [1:0] wb_selMW);
	
	always_ff @(posedge clk) begin
		if(reset) begin 
		    reg_wrMW  = 0;
			wr_enMW   = 0;
			rd_enMW   = 0;
			wb_selMW  = 0; end
	    else if(!stall) begin
			reg_wrMW  = reg_wr;
			wr_enMW   = wr_en;
			rd_enMW   = rd_en;
			wb_selMW  = wb_sel;
		end 
	end
endmodule						
