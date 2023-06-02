module control(input logic [31:0] instr,
               output logic [3:0] alu_op,
			   output logic reg_wr, sel_B, sel_A, wr_en, rd_en,output logic [2:0] br_type, logic [1:0] wb_sel);
  
			   logic [6:0] opcode, func7;
               logic [2:0] func3;
               assign opcode = instr[6:0];
               assign func3 = instr[14:12];
               assign func7 = instr[31:25];
               always_comb begin
			   alu_op = 0;
               reg_wr = 0;
               sel_A = 0;
               sel_B = 0;
               wr_en = 0;
               rd_en = 0;
               wb_sel = 0;
               br_type = 3'b111;
			   //R type
			   if (opcode == 7'b0110011) begin
			   reg_wr = 1;
               rd_en = 1;
               wb_sel = 1;			   
			   if (func7== 7'b0000000)begin
               case(func3)
			   3'b000 : alu_op =4'b0000;
			   3'b001 : alu_op =4'b0010;         
			   3'b010 : alu_op =4'b0011;
			   3'b011 : alu_op =4'b0100;
			   3'b100 : alu_op =4'b0101;
               3'b101 : alu_op =4'b0110;
			   3'b110 : alu_op =4'b1000;
			   3'b111 : alu_op =4'b1001;
			   endcase
			   end
			   else if (func7== 7'b0100000)begin
			   case(func3)
			   3'b000 : alu_op =4'b0001;
               3'b101 : alu_op =4'b0111;
			   endcase
			   end
			   end
			   //Load
			   if (opcode == 7'b0000011) begin
			   reg_wr = 1;  
               sel_B = 1;			 			
               rd_en = 1;			   
               wb_sel = 2;
			   end
			   //Store
			   if (opcode == 7'b0100011) begin 
               sel_B = 1;			 						   
               wb_sel = 2;
			   wr_en = 1;
			   end
			   //I type
			   if (opcode == 7'b0010011) begin
			   reg_wr = 1;  
               sel_B = 1;			 			
               rd_en = 1;			   
               wb_sel = 1;
			   if (func7== 7'b0000000)begin
               case(func3)
			   3'b000 : alu_op =4'b0000;
			   3'b001 : alu_op =4'b0010;         
			   3'b010 : alu_op =4'b0011;
			   3'b011 : alu_op =4'b0100;
			   3'b100 : alu_op =4'b0101;
               3'b101 : alu_op =4'b0110;
			   3'b110 : alu_op =4'b1000;
			   3'b111 : alu_op =4'b1001;
			   endcase
			   end
			   else if (func7== 7'b0100000)begin
			   case(func3)
			   3'b000 : alu_op =4'b0001;
               3'b101 : alu_op =4'b0111;
			   endcase
			   end
			   end
			   //Branch
			   if (opcode == 7'b1100011) begin
			   sel_A = 1;
               sel_B = 1;
               case(func3)
                     0: br_type = 0;
                     1: br_type = 1;
                     4: br_type = 2;
                     5: br_type = 3;
                     6: br_type = 4;
                     7: br_type = 5;
               default: br_type = 7;
               endcase
               end
			   //AUIPC
			   if (opcode == 7'b0010111) begin
			   alu_op = 0;
               sel_A = 1;
               sel_B = 1;
               br_type = 6;
			   end
			   //LUI
			   if (opcode == 7'b0110111) begin
			   alu_op = 9;
               reg_wr = 1;
               sel_B = 1;
               rd_en = 1;
               wb_sel = 1;
			   end
			   //JAL
			   if (opcode == 7'b1101111) begin
			   sel_A = 1;
               sel_B = 1;
               br_type = 6;
               reg_wr = 1;
               wb_sel = 0;
			   end
			   //JALR
			   if (opcode == 7'b1100111) begin
               sel_A = 0;
               sel_B = 1;
			   wb_sel = 1;
               reg_wr = 1;
               br_type = 6;
			   end
end
endmodule