import rv32i_types::*;
module ID_stage
(
		input clk,
		input [4:0] ID_rs1,
		input [4:0] ID_rs2,
		input [31:0] WB_in,
		input [4:0] ID_rd,
		input ID_load_regfile,
		input [31:0] ID_pc,
		input [31:0] ID_b_imm,
		input [31:0] ID_j_imm,
		input [31:0] ID_i_imm,
		input [1:0] jb_sel,
		input branch_funct3_t cmpop,
		
		
		output logic ID_pc_mux_sel,
		output logic flush,
		output logic [31:0] ID_rs1_out,
		output logic [31:0] ID_rs2_out,
		output logic [31:0] ID_jmp_pc
);

logic [31:0] imm;
logic [31:0] pc_rs1_add_rst;
logic jb_mux;

assign jb_mux = (jb_sel==2'b11)?1'b0:1'b1;
assign ID_jmp_pc = imm + pc_rs1_add_rst;

mux4 imm_mux(
	.sel(jb_sel),
	.a(0),
	.b(ID_j_imm),
	.c(ID_i_imm),
	.d(ID_b_imm),
	.f(imm)
);

mux2 pc_rs1_mux(
	.sel(jb_mux),
	.a(ID_pc),
	.b(ID_rs1_out),
	.f(pc_rs1_add_rst)
);

JB_hazard_detection_unit ID_JB_unit
(
	.jb_sel,
	.cmpop,
	.ID_rs1_out,
	.ID_rs2_out,
	.pcmux_sel(ID_pc_mux_sel),
	.flush
);

regfile ID_regfile
(
	.clk,
	.load(ID_load_regfile),
	.in(WB_in),
	.src_a(ID_rs1),
	.src_b(ID_rs2),
	.dest(ID_rd),
	.reg_a(ID_rs1_out),
	.reg_b(ID_rs2_out)
);

endmodule : ID_stage
