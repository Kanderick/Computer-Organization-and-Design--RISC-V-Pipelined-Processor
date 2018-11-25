module MEM_WB_pipe
(
	input load,
	input [31:0] MEM_pc,
	input MEM_cmp_out,
	input [31:0] MEM_alu_out,
	input [31:0] MEM_rdata,
	output logic [31:0] WB_pc,
	output logic [31:0] WB_data,
	output logic WB_cmp_out,
	output logic WB_alu_out
);

endmodule	: MEM_WB_pipe