module WB_pipe
(
	input MEM_cmp_out,
	input [31:0] MEM_alu_out,
	input [31:0] MEM_rdata,	/*read from data cache*/
	input [31:0] MEM_pc,
	output logic WB_cmp_out,
	output logic [31:0] WB_alu_out,
	output logic [31:0] WB_rdata,
	output logic [31:0] WB_pc,
	/*other signals*/
	input clk,
	input load,
	input reset
);

always_ff @(posedge clk) begin

	if(reset) begin
	WB_alu_out<=0;
	WB_rdata<=0;
	WB_pc<=0;
	end

	else begin
	WB_alu_out<=MEM_alu_out;
	WB_rdata<=MEM_rdata;
	WB_pc<=MEM_pc;
	end
end

endmodule : WB_pipe 