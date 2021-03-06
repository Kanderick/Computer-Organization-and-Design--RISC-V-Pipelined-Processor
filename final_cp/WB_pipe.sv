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
initial
begin
	WB_cmp_out=0;
	WB_alu_out=0;
	WB_rdata=0;
	WB_pc=0;
end
always_ff @(posedge clk) begin

	if(reset) begin
	WB_alu_out<=0;
	WB_rdata<=0;
	WB_pc<=0;
	WB_cmp_out<=0;
	end

	else if(load) begin
	WB_alu_out<=MEM_alu_out;
	WB_rdata<=MEM_rdata;
	WB_pc<=MEM_pc;
	WB_cmp_out<=MEM_cmp_out;
	end
end

endmodule : WB_pipe 