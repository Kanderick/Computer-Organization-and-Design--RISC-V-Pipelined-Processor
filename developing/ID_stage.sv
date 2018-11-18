import rv32i_types::*;
module ID_stage
(
		input clk,
		input [4:0] ID_rs1,
		input [4:0] ID_rs2,
		input [31:0] WB_in,
		input [4:0] WB_rd,
		input WB_load_regfile,
		
		output logic [31:0] ID_rs1_out,
		output logic [31:0] ID_rs2_out
);

regfile ID_regfile
(
	.clk,
	.load(WB_load_regfile),
	.in(WB_in),
	.src_a(ID_rs1),
	.src_b(ID_rs2),
	.dest(WB_rd),
	.reg_a(ID_rs1_out),
	.reg_b(ID_rs2_out)
);

endmodule : ID_stage
