module MEM_stage
(
	input [31:0] MEM_rs2_out,
	input [31:0] MEM_alu_out,
	input [4:0] MEM_rs2,
	input [4:0] WB_rd,
	input [31:0] WB_in,
	input WB_writeback,
	output logic [31:0] MEM_addr,
	output logic [31:0] MEM_data,
	/*forwarding use signals*/
	input MEM_cmp_out,
	input [31:0] u_imm,
	input [31:0] pc,
	input [2:0] regfilemux_sel,
	output logic [31:0] forwarding_out

);	
logic sel;
logic [31:0] pc_plus_4;
assign pc_plus_4 = pc+4;
assign MEM_addr = MEM_alu_out;
assign sel= (MEM_rs2==WB_rd && WB_writeback);
mux2 #(.width(32)) MEM_select
(
		.a(MEM_rs2_out),
		.b(WB_in),
		.sel,
		.f(MEM_data)
);

mux8 WB_regfilemux (
	.sel(regfilemux_sel),
	.a(MEM_alu_out),
	.b({31'b0, MEM_cmp_out}),
	.c(u_imm),
	.d(32'b0),
	.e(pc_plus_4),
	.f(),
	.g(),
	.h(),
	.o(forwarding_out)
);


endmodule: MEM_stage