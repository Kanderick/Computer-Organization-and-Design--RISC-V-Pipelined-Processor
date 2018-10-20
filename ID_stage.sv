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
		input [1:0] jb_sel;
		
		output logic [31:0] ID_rs1_out,
		output logic [31:0] ID_rs2_out,
		output logic [31:0] ID_jmp_pc,
		output logic [31:0] ID_pc_out
);

logic [31:0] imm;
logic [31:0] pc_rs1_add_rst;

assign ID_jmp_pc = imm + pc_rs1_add_rst;

mux4 imm_mux(
	.sel(jb_sel),
	.a(ID_b_imm),
	.b(ID_j_imm),
	.c(ID_i_imm),
	.d(ID_i_imm),
	.f(imm)
);

mux2 pc_rs1_mux(
	.sel({jb_sel[1]}),
	.a(ID_pc),
	.b(ID_rs1_out),
	.f(pc_rs1_add_rst)
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

mux2
endmodule : ID_stage
