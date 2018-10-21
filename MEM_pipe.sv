module MEM_pipe(
	input clk,
	input reset,
	input load,
	
	input [31:0] EX_pc,
	input [31:0] EX_alu_out,
	input [31:0] EX_rs2_out,
	input EX_cmp_out,
	
	output logic [31:0] MEM_pc,
	output logic [31:0] MEM_alu_out,
	output logic [31:0] MEM_rs2_out,
	output MEM_cmp_out
);

always_ff @ (posedge clk)
begin
	if (reset)
	begin
		MEM_pc <= 0;
		MEM_alu_out <= 0;
		MEM_rs2_out <= 0;
		MEM_cmp_out <= 0;
	end
	
	else if(load)
	begin
		MEM_pc <= EX_pc;
		MEM_alu_out <= EX_alu_out;
		MEM_rs2_out <= EX_rs2_out;
		MEM_cmp_out <= EX_cmp_out;
	end
end

endmodule	: MEM_pipe