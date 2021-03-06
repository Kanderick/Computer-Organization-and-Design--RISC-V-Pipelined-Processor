module MEM_stage
(
	input [31:0] MEM_rs2_out,
	input [31:0] MEM_alu_out,
	output logic [31:0] MEM_addr,
	output logic [31:0] MEM_data

);	

assign MEM_addr = MEM_alu_out;

mux2 #(.width(32)) MEM_select
(
		.a(MEM_rs2_out),
		.b(32'b0),
		.sel(1'b0),
		.f(MEM_data)
);

endmodule: MEM_stage