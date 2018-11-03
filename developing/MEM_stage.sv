module MEM_stage
(
	input [31:0] MEM_rs2_out,
	input [31:0] MEM_alu_out,
	input [4:0] MEM_rs2,
	input [4:0] WB_rd,
	input [31:0] WB_in,
	output logic [31:0] MEM_addr,
	output logic [31:0] MEM_data

);	
logic sel;
assign MEM_addr = MEM_alu_out;
assign sel= (MEM_rs2==WB_rd);
mux2 #(.width(32)) MEM_select
(
		.a(MEM_rs2_out),
		.b(WB_in),
		.sel,
		.f(MEM_data)
);

endmodule: MEM_stage