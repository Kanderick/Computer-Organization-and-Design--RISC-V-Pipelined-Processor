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
	output logic MEM_cmp_out,
	//dependency resolver
	input [31:0] EX_jmp_pc,
	input EX_pc_mux_sel,
	input EX_flush,
	output logic [31:0] MEM_jmp_pc,
	output logic MEM_pc_mux_sel,
	output logic flush
);

initial
begin
	MEM_pc=0;
	MEM_alu_out=0;
	MEM_rs2_out=0;
	MEM_cmp_out=0;
	MEM_jmp_pc=0;
	MEM_pc_mux_sel=0;
	flush=0;
end
always_ff @ (posedge clk)
begin
	if (reset)
	begin
		MEM_pc <= 0;
		MEM_alu_out <= 0;
		MEM_rs2_out <= 0;
		MEM_cmp_out <= 0;
		MEM_jmp_pc<=0;
		MEM_pc_mux_sel<=0;
		flush<=0;
	end
	
	else if(load)
	begin
		MEM_pc <= EX_pc;
		MEM_alu_out <= EX_alu_out;
		MEM_rs2_out <= EX_rs2_out;
		MEM_cmp_out <= EX_cmp_out;
		MEM_jmp_pc<=EX_jmp_pc;
		MEM_pc_mux_sel<=EX_pc_mux_sel;
		flush<=EX_flush;
	end
end

endmodule	: MEM_pipe