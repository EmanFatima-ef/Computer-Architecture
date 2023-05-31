module datapath(input clk, reset);
logic [31:0]  inst_machine_code,rdata1,rdata2,wdata,immediate,rdata,alu_out;
logic [3:0] operator;
logic [31:0] pc_out;
logic sel_A, sel_B;
logic [31:0] operand_1, operand_2;
logic [1:0] wb_sel;
logic [2:0] br_type;

instruction_mem IM(.address(pc_out),.inst_machine_code(inst_machine_code));

register Reg(.clk(clk), .reset(reset), .write_en(write_en), .wdata(wdata), .raddr1(inst_machine_code[19:15]), .raddr2(inst_machine_code[24:20]), 
			 .waddr(inst_machine_code[11:7]), .rdata1(rdata1), .rdata2(rdata2));

PC PC(.clk(clk), .reset(reset),.br_taken(br_taken), .pc_in(alu_out), .pc_out(pc_out));

Immediate_gen I_Gen(.instr(inst_machine_code), .immediate(immediate));

data_mem DM(.clk(clk), .rd_en(rd_en), .wr_en(wr_en), .func3(inst_machine_code[14:12]), .addr(alu_out), .wdata(rdata2), .rdata(rdata));

branch_condition Br_C(.A(rdata1), .B(rdata2), .br_type(br_type),.br_taken(br_taken));

always_comb begin
operand_1 = sel_A ? pc_out : rdata1;
operand_2 = sel_B ? immediate : rdata2;
end

ALU ALU(.operand_1(operand_1), .operand_2(operand_2), .operator(operator), .result(alu_out));

always_comb begin
case (wb_sel)
2'b00 : wdata = pc_out + 4;
2'b01 : wdata = alu_out;
2'b10 : wdata = rdata;
endcase
end

control Ctrl(.instr(inst_machine_code), .alu_op(operator), .reg_wr(write_en), .sel_B(sel_B), .sel_A(sel_A), .wr_en(wr_en), .rd_en(rd_en), .br_type(br_type), .wb_sel(wb_sel));

endmodule

