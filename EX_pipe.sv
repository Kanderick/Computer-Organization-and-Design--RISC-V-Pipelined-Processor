module EX_pipe
(
	input [31:0] ID_pc,
	input [31:0] ID_rs1_out,
	input [31:0] ID_rs2_out,
	output logic [31:0] EX_pc,
	output logic [31:0] EX_rs1_out,
	output logic [31:0] EX_rs2_out,
	/*other signals*/
	input clk,
	input reset
);

always_ff @ (posedge clk) begin
	if(reset) begin
	EX_pc<=0;
	EX_rs1_out<=0;
	EX_rs2_out<=0;
	end
	else begin
	EX_pc<=ID_pc;
	EX_rs1_out<=ID_rs1_out;
	EX_rs2_out<=ID_rs2_out;
	end
end
endmodule : EX_pipe