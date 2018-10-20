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
		input jb_sel,
		
		output logic [31:0] ID_rs1_out,
		output logic [31:0] ID_rs2_out,
		output logic [31:0] ID_jmp_pc,
		output logic [31:0] ID_pc_out
);

logic [31:0] imm;

assign ID_jmp_pc = imm + ID_pc;

mux2 jb_mux(
	.sel(jb_sel),
	.a(ID_b_imm),
	.b(ID_j_imm),
	.f(imm)
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
