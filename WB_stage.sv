module WB_stage(
	input [31:0] WB_pc,
	input [2:0] WB_funct3,
	input [31:0] WB_rdata,
	input WB_cmp_out,
	input [31:0] WB_alu_out,
	input [31:0] WB_u_imm,
	input [3:0] WB_regfilemux_sel,
	output logic [31:0] WB_in
);

logic [31:0] rdata_out;
logic [31:0] pc_plus_4;

add4 WB_add4(
	.a(WB_pc),
	.f(pc_plus_4)
);

rdata_out_logic rdata_out_logic(
	.funct3(WB_funct3),
	.data_in(WB_rdata),
	.data_out(rdata_out)
);

mux8 WB_regfilemux (
	.sel(WB_regfilemux_sel),
	.a(WB_alu_out),
	.b({31'b0, WB_cmp_out}),
	.c(WB_u_imm),
	.d(rdata_out),
	.e(pc_plus_4),
	.f(),
	.g(),
	.h(),
	.o(WB_in)
);
endmodule	: WB_stage