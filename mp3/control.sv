import rv32i_types::*; /* Import types defined in rv32i_types.sv */


/*
module datapath
(
    input clk,
    /* select signals *
    input pcmux_sel,
	 input marmux_sel,
	 input alumux1_sel,
	 input cmpmux_sel
	 input [1:0] alumux2_sel,
	 input [1:0] regfilemux_sel,
	 /* control signals *
    input load_pc,
	 input load_ir,
	 input load_MDR, 
	 input load_MAR,
	 input load_regfile,
	 input load_mem_data_out,
	 /* ALU info signal *
	 input alu_ops aluop,
	 input branch_funct3_t cmpop,
	 /* memory input *
	 input rv32i_word mem_rdata,
	 
	 /* output signals *
	 output logic [2:0] funct3,
    output logic [6:0] funct7,
    output rv32i_opcode opcode,
	 output rv32i_word mem_address
	 output rv32i_word mem_wdata,
	 output logic br_en;
);*/
module cpu_control
(
    /* Input and output port declarations */
	 input clk,
	 /* datapath controls */
	 /* ir */
	 input rv32i_opcode opcode,
	 input [2:0] funct3,
    input [6:0] funct7,
	 /* CMP */
	 input br_en,
	 /* load signal */
	 output logic load_pc,
	 output logic load_ir,
	 output logic load_regfile,
	 output logic load_MAR,
	 output logic load_MDR,
	 output logic instr_data,
	 output logic load_mem_data_out,
	 /* select signal */
	 output logic pcmux_sel,
	 output logic marmux_sel,
	 output logic alumux1_sel,
	 output logic cmpmux_sel,
	 output logic [2:0] alumux2_sel,
	 output logic [2:0] regfilemux_sel,
	 /* alu signal */
	 output alu_ops aluop,
	 /* CMP signal */
	 output branch_funct3_t cmpop,
	 /* memory signals */
	 input mem_resp,
	 output logic mem_read,
	 output logic mem_write,
	 output rv32i_mem_wmask mem_byte_enable
);

store_funct3_t store_op;
assign store_op = store_funct3_t'(funct3);

enum int unsigned {
    /* List of states */
	 fetch1,
	 fetch2,
	 fetch3,
	 decode,
	 s_auipc,
	 s_SLTI,
	 s_SLTIU,
	 s_SRAI,
	 s_imm,
	 s_reg, 
	 s_reg_SRAI, 
	 s_reg_SLTI, 
	 s_reg_SLTIU,
	 s_BR,
	 s_LW_calc_addr,
	 s_ldr1,
	 s_ldr2,
	 s_SW_calc_addr,
	 s_str1,
	 s_str2,
	 s_LUI,
	 s_JAL,
	 s_JALR
} state, next_states;

always_comb
begin : state_actions
    /* Default output assignments */
	 load_pc = 1'b0;
	 load_ir = 1'b0;
	 load_regfile = 1'b0;
	 load_MAR = 1'b0;
	 load_MDR = 1'b0;
	 load_mem_data_out = 1'b0;
	 pcmux_sel = 1'b0;
	 marmux_sel = 1'b0;
	 alumux1_sel = 1'b0;
	 cmpmux_sel = 1'b0;
	 alumux2_sel = 3'b000;
	 regfilemux_sel = 3'b000;
	 instr_data = 1'b0;
	 /* alu info signals */
	 aluop = alu_ops'(funct3);
	 mem_read = 1'b0;
	 mem_write = 1'b0;
	 mem_byte_enable = 4'b1111;
    cmpop = branch_funct3_t'(funct3);
	 /* Actions for each state */
	 case(state)
		fetch1:
		begin
			/* MAR <= PC */
			load_MAR = 1'b1;
		end
		
		fetch2:
		begin
			/* read memory */
			load_MDR = 1'b1;
			mem_read = 1'b1;
		end
		
		fetch3:
		begin
			/* load IR */
			load_ir = 1'b1;
		end
		
		decode:
		begin
		end
		
		s_auipc:
		begin
			load_regfile = 1'b1;
			alumux1_sel = 1'b1;
			alumux2_sel = 3'b001;
			aluop = alu_add;
			load_pc = 1'b1;
		end
		
		s_SLTI:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			cmpop = blt;
			regfilemux_sel = 3'b001;
			cmpmux_sel = 1'b1;
		end
		
		s_SLTIU:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			cmpop = bltu;
			regfilemux_sel = 3'b001;
			cmpmux_sel = 1'b1;
		end
		
		s_SRAI:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			aluop = alu_sra;
		end
		
		s_imm:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			aluop = alu_ops'(funct3);
		end
		s_reg_SRAI:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			aluop = alu_sra;
			alumux2_sel = 3'b101;
		end
		s_reg_SLTI:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			cmpop = blt;
			regfilemux_sel = 3'b001;
			cmpmux_sel = 1'b0;
		end
		s_reg_SLTIU:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			cmpop = bltu;
			regfilemux_sel = 3'b001;
			cmpmux_sel = 1'b0;
		end
		s_reg:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			aluop = alu_ops'(funct3);
			alumux2_sel = 3'b101;
			if (arith_funct3_t'(funct3) == add && funct7)
			begin
				aluop = alu_sub;
			end
			if (arith_funct3_t'(funct3) == sr && funct7)
			begin
				aluop = alu_sra;
			end
		end
		
		s_BR:
		begin
			pcmux_sel = br_en;
			load_pc = 1'b1;
			alumux1_sel = 1'b1;
			alumux2_sel = 3'b010;
			aluop = alu_add;
		end
		
		s_LW_calc_addr:
		begin
			aluop = alu_add;
			load_MAR = 1'b1;
			marmux_sel = 1'b1;
		end
		
		s_ldr1:
		begin
			load_MDR = mem_resp;
			mem_read = 1'b1;
			instr_data = 1'b1;
		end
		s_ldr2:
		begin
			regfilemux_sel = 3'b011;
			load_regfile = 1'b1;
			load_pc = 1'b1;
		end
		
		s_SW_calc_addr:
		begin
			alumux2_sel = 3'b011;
			aluop = alu_add;
			load_MAR = 1'b1;
			load_mem_data_out = 1'b1;
			marmux_sel = 1'b1;
		end
	   s_str1:
		begin
			mem_write = 1'b1;
			case(store_op)
				sb:
				begin
					mem_byte_enable = 4'b0001;
				end
				sh:
				begin
					mem_byte_enable = 4'b0011;
				end
				sw:
				begin
					mem_byte_enable = 4'b1111;
				end
				default:
				begin
				end
			endcase
		end	
	   s_str2:
		begin
			load_pc = 1'b1;
		end
		
		s_LUI:
		begin
			load_regfile = 1'b1;
			load_pc = 1'b1;
			regfilemux_sel = 3'b010;
		end
		s_JAL:
		begin
			pcmux_sel = 1'b1;
			alumux2_sel = 3'b100;
			alumux1_sel = 1'b1;
			load_pc = 1'b1;
			regfilemux_sel = 3'b100;
			load_regfile = 1'b1;
		end
		s_JALR:
		begin
			pcmux_sel = 1'b1;
			alumux2_sel = 3'b000;
			alumux1_sel = 1'b0;
			load_pc = 1'b1;
			regfilemux_sel = 3'b100;
			load_regfile = 1'b1;
		end
		default:
		begin
		end
	endcase 
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 next_states = state;
	 case(state)
		fetch1:
		begin
			next_states = fetch2;
		end
		fetch2:
		begin
			if (mem_resp)
				next_states = fetch3;
		end
		fetch3:
		begin
			next_states = decode;
		end
		decode:
		begin
			/*
			typedef enum bit [6:0] {
				 op_lui   = 7'b0110111, //load upper immediate (U type)
				 op_auipc = 7'b0010111, //add upper immediate PC (U type)
				 op_jal   = 7'b1101111, //jump and link (J type)
				 op_jalr  = 7'b1100111, //jump and link register (I type)
				 op_br    = 7'b1100011, //branch (B type)
				 op_load  = 7'b0000011, //load (I type)
				 op_store = 7'b0100011, //store (S type)
				 op_imm   = 7'b0010011, //arith ops with register/immediate operands (I type)
				 op_reg   = 7'b0110011, //arith ops with register operands (R type)
				 op_csr   = 7'b1110011  //control and status register (I type)
			} rv32i_opcode;
			*/
			case(opcode)
				op_auipc: 
				begin
					next_states = s_auipc;
				end
				op_br:
				begin
					next_states = s_BR;
				end
				op_reg:
				begin
					next_states = s_reg;
					if(funct7[6:0] == 7'b0100000 && funct3[2:0] == 3'b101)
						next_states = s_reg_SRAI;
					else if(funct3[2:0] == 3'b010)
						next_states = s_reg_SLTI;
					else if(funct3[2:0] == 3'b011)
						next_states = s_reg_SLTIU;
				end
				op_imm:
				begin
					next_states = s_imm;
					if(funct7[6:0] == 7'b0100000 && funct3[2:0] == 3'b101)
						next_states = s_SRAI;
					else if(funct3[2:0] == 3'b010)
						next_states = s_SLTI;
					else if(funct3[2:0] == 3'b011)
						next_states = s_SLTIU;
				end
				op_lui:
				begin
					next_states = s_LUI;
				end
				op_load:
				begin
					next_states = s_LW_calc_addr;
				end
				op_store:
				begin
					next_states = s_SW_calc_addr;
				end
				op_jal:
				begin
					next_states = s_JAL;
				end
				op_jalr:
				begin
					next_states = s_JALR;
				end
				default:
				begin
				end
			endcase
		end
		s_SLTI, s_SLTIU, s_auipc, s_BR, s_imm, s_LUI, s_SRAI, s_ldr2, s_str2, s_JAL, s_JALR, s_reg, s_reg_SRAI, s_reg_SLTI, s_reg_SLTIU:
		begin
			next_states = fetch1;
		end
		s_LW_calc_addr:
		begin
			next_states = s_ldr1;
		end
		s_ldr1:
		begin
			if(mem_resp)
				next_states = s_ldr2;
		end
		s_SW_calc_addr:
		begin
			next_states = s_str1;
		end
		s_str1:
		begin
			if(mem_resp)
				next_states = s_str2;
		end
		default:
		begin
		end
	 endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_states;
end

endmodule : cpu_control
