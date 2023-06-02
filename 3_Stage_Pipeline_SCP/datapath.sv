module datapath(input clk, reset);
logic [31:0]  inst_machine_code,rdata1,rdata2,wdata,immediate,rdata,alu_out,inst_machine_codeMW,pc_outMW2,pc_outMW,alu_outMW,rdata2MW,inst_machine_codeMW2;
logic [3:0] operator;
logic [31:0] pc_out,rdata1mux,rdata2mux;
logic sel_A, sel_B,reg_wrMW,wr_enMW,rd_enMW;
logic [31:0] operand_1, operand_2;
logic [1:0] wb_sel,wb_selMW;
logic [2:0] br_type;
logic br_taken,stall,For_A,For_B,stall_MW,stallflush,flush;

instruction_mem IM(.address(pc_out),.inst_machine_code(inst_machine_code));

register Reg(.clk(clk), .reset(reset), .write_en(reg_wrMW), .wdata(wdata), .raddr1(inst_machine_codeMW[19:15]), .raddr2(inst_machine_codeMW[24:20]), 
			 .waddr(inst_machine_codeMW2[11:7]), .rdata1(rdata1), .rdata2(rdata2));

PC PC(.clk(clk), .reset(reset),.br_taken(br_taken), .pc_in(alu_outMW), .pc_out(pc_out));

Immediate_gen I_Gen(.instr(inst_machine_codeMW), .immediate(immediate));

data_mem DM(.clk(clk), .rd_en(rd_enMW), .wr_en(wr_enMW), .func3(inst_machine_codeMW[14:12]), .addr(alu_outMW), .wdata(rdata2MW), .rdata(rdata));

branch_condition Br_C(.br_type(br_type), .A(rdata1), .B(rdata2),  .br_taken(br_taken));

always_comb begin
operand_1 = sel_A ? pc_outMW : rdata1mux;
operand_2 = sel_B ? immediate : rdata2mux;
end

ALU ALU(.operand_1(operand_1), .operand_2(operand_2), .operator(operator), .result(alu_out));

always_comb begin
case (wb_selMW)
2'b00 : wdata = pc_outMW2 + 4;
2'b01 : wdata = alu_outMW;
2'b10 : wdata = rdata;
endcase
end

// Registers for Pipeline

regfile PC_RF(.clk(clk), .reset(reset), .stall(stall), .reg_in(pc_out), .reg_out(pc_outMW));

assign stallflush = stall & flush;

regfile IR_RF(.clk(clk), .reset(reset), .stall(stallflush), .reg_in(inst_machine_code), .reg_out(inst_machine_codeMW));

regfile PC_DM(.clk(clk), .reset(reset), .stall(stall_MW), .reg_in(pc_outMW), .reg_out(pc_outMW2));

regfile ALU_DM(.clk(clk), .reset(reset), .stall(stall_MW), .reg_in(alu_out), .reg_out(alu_outMW));

regfile WD_DM(.clk(clk), .reset(reset), .stall(stall_MW), .reg_in(rdata2), .reg_out(rdata2MW));

regfile IR_DM(.clk(clk), .reset(reset), .stall(stall_MW), .reg_in(inst_machine_codeMW), .reg_out(inst_machine_codeMW2));

// Controllers

control Ctrl(.instr(inst_machine_codeMW), .alu_op(operator), .reg_wr(write_en), .sel_B(sel_B), .sel_A(sel_A), .wr_en(wr_en), .rd_en(rd_en), .br_type(br_type), .wb_sel(wb_sel));

ControlMW CtrlMW(.reset(reset), .clk(clk), .reg_wr(write_en), .wr_en(wr_en), .rd_en(rd_en),.stall(stall), .wb_sel(wb_sel),.reg_wrMW(reg_wrMW), .wr_enMW(wr_enMW), .rd_enMW(rd_enMW), .wb_selMW(wb_selMW));

always_comb begin

rdata1mux = For_A ? alu_outMW : rdata1;
rdata2mux = For_B ? alu_outMW : rdata2;
end

Forward_stall_unit FSU(.clk(clk),.inst_machine_codeMW2(inst_machine_codeMW2), .inst_machine_codeMW(inst_machine_codeMW), .reg_wrMW(reg_wrMW), .br_taken(br_taken), .For_A(For_A), .For_B(For_B), .stall(stall), .stall_MW(stall_MW), .flush(flush));


endmodule





