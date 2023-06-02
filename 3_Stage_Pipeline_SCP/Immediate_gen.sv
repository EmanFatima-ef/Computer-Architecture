module Immediate_gen(
    input logic [31:0] instr,
    output logic [31:0] immediate
);

    logic [6:0] opcode, funct7;
    logic [2:0] funct3;
    always_comb begin
        opcode = instr[6:0];
		funct3 = instr[14:12];
        funct7 = instr[31:25];
		//I Type
		if (opcode == 7'b0010011) begin
            if (funct3 == 3'b101 && funct7 == 7'b0100000) begin
                immediate = {27'b0, instr[24:20]};
            end else begin
                immediate = {{20{instr[31]}}, instr[31:20]};
            end
        end
		//Load
        else if (opcode == 7'b0000011) begin
            immediate = {{20{instr[31]}}, instr[31:20]};
        end
		//Store
        else if (opcode == 7'b0100011) begin
            immediate = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        end
		
		//LUI and AUIPC
        else if (opcode == 7'b0110111 || opcode == 7'b0010111) begin
            immediate = {instr[31:12], 12'b0};
        end
		
		//Branch
        else if (opcode == 7'b1100011) begin 
            immediate = {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
        end

		//JAL
        else if (opcode == 7'b1101111) begin 
            immediate = {{12{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
        end
		
		//JALR 
		else if (opcode == 7'b1100111) begin 
            immediate = {20'b0, instr[31:20]};
        end
    end

endmodule