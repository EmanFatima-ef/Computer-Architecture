module Forward_stall_unit(input logic [31:0] inst_machine_codeMW2, inst_machine_codeMW, input logic reg_wrMW,br_taken,clk,
                          output logic For_A, For_B, stall, stall_MW,flush);
						
						logic [4:0] rs1_addr, rs2_addr,rd_addr;
						logic rs1_valid, rs2_valid, rs1_hazard, rs2_hazard;
						assign rd_addr = inst_machine_codeMW2[11:7];
						assign rs1_addr = inst_machine_codeMW[19:15];
						assign rs2_addr = inst_machine_codeMW[24:20];
                        // Check the validity of the source operands from EXE stage
                        assign rs1_valid = |rs1_addr;
                        assign rs2_valid = |rs2_addr;
                        // Hazard detection
                        assign rs1_hazard = ((rs1_addr == rd_addr) & reg_wrMW)& rs1_valid & (inst_machine_codeMW2[6:0] != 7'b0000011);
                        assign rs2_hazard = ((rs2_addr == rd_addr) & reg_wrMW)& rs2_valid & (inst_machine_codeMW2[6:0] != 7'b0000011);

						assign For_A = rs1_hazard ;
						assign For_B = rs2_hazard ;
						assign stall = ((For_A | For_B) & (inst_machine_codeMW2[6:0] == 7'b0000011));
						assign stall_MW = ((For_A | For_B) & (inst_machine_codeMW2[6:0] == 7'b0000011));
						assign flush = (inst_machine_codeMW[6:0] == 7'b1100011 & br_taken);
endmodule