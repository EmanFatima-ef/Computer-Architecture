module data_mem( input logic clk, rd_en, wr_en,
    input logic [2:0] func3,
    input logic [31:0] addr, wdata,
    output logic [31:0] rdata
);
//wdata is from ALU
    logic [31:0] data_memory [256];
	//logic cs,wr,st_ops;
	logic [7:0] rdata_byte;
    logic [15:0] rdata_hword;
	logic [31:0] rdata_word, data_wr, data_rd;
	logic [3:0] mask;

    initial begin
        $readmemh("data_memory.txt", data_memory);
    end
	
	//assign st_ops=|rd_en;
	//assign cs=~(st_ops|(|wr_en));
	//assign wr=~st_ops;
	//assign data_rd =(~cs&~wr)? data_memory[addr_ff]:'0;
	assign data_rd =data_memory[addr];
    always_comb begin
	    if (rd_en) begin
	    rdata_byte='0;
        rdata_hword='0;
        rdata_word='0;
		case(func3)
		    3'b000,//LB
			3'b100:begin//LBU
			case(addr[1:0])
			    2'b00: rdata_byte=data_rd[7:0];
				2'b01: rdata_byte=data_rd[15:8];
				2'b10: rdata_byte=data_rd[23:16];
				2'b11: rdata_byte=data_rd[31:24]; 
			endcase
			end
			3'b001,//LH
			3'b101:begin//LHU
			case(addr[1])
			    1'b0: rdata_hword=data_rd[15:0];
				1'b1: rdata_hword=data_rd[31:16];
			endcase
			end
			3'b010: rdata_word=data_rd;//LW
        endcase
		
		case(func3)
		    3'b000:rdata={{24{rdata_byte[7]}},rdata_byte}; //LB
			3'b100:rdata={24'b0,rdata_byte};//LBU
			3'b001:rdata={{16{rdata_hword[15]}},rdata_hword};//LH
			3'b101:rdata={16'b0,rdata_hword};//LHU
			3'b010:rdata={rdata_word};//LW
		endcase
end
end
        always_comb begin
		if (wr_en)begin
		data_wr='0;
		mask='0;
		case(func3)
		    3'b000:begin//SB
			    case(addr[1:0])
				    2'b00:begin
					    data_wr[7:0]=wdata[7:0];
						mask=4'b0001;
				    end
					2'b01:begin
					    data_wr[15:8]=wdata[15:8];
						mask=4'b0010;
				    end
					2'b10:begin
					    data_wr[23:16]=wdata[23:16];
						mask=4'b0100;
				    end
					2'b11:begin
					    data_wr[31:24]=wdata[31:24];
						mask=4'b1000;
				    end
				endcase
end
            3'b001:begin//SH        			
			    case(addr[1])
				    1'b0:begin
					    data_wr[15:0]=wdata[15:0];
						mask=4'b0011;
				    end
					1'b1:begin
					    data_wr[31:16]=wdata[31:16];
						mask=4'b1100;
				    end
					endcase
					end
			3'b010:begin//SW
                data_wr=wdata;
                mask=4'b1111;
            end
            default : begin
                data_wr='0;
            end				
				endcase
	end
end
    always_ff @(posedge clk)
	begin 
	$writememh("data_memory.txt", data_memory);
	    if (wr_en)begin
		    if(mask[0])
			    data_memory[addr][7:0]=wdata[7:0];
		    if(mask[1])
			    data_memory[addr][15:8]=wdata[15:8];
		    if(mask[2])
			    data_memory[addr][23:16]=wdata[23:16];
		    if(mask[3])
			    data_memory[addr][31:24]=wdata[31:24];
		end
    end
endmodule