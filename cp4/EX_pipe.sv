module EX_pipe
(
	input [31:0] ID_pc,
	input [31:0] ID_rs1_out,
	input [31:0] ID_rs2_out,
	input MEM_EX_rdata_hazard,
	input [31:0] WB_in,
	input WB_writeback,
	input [4:0] EX_rs1,
	input [4:0] EX_rs2,
	input [4:0] WB_rd,
	//input [31:0] ID_jmp_pc,
	//input ID_pc_mux_sel,
	//input ID_flush,
	
	output logic [31:0] EX_pc,
	output logic [31:0] EX_rs1_out,
	output logic [31:0] EX_rs2_out,
	//output logic [31:0] EX_jmp_pc,
	//output logic EX_pc_mux_sel,
	//output logic flush,
	/*other signals*/
	input clk,
	input reset,
	input load
);
initial
begin
	EX_pc=0;
	EX_rs1_out=0;
	EX_rs2_out=0;
	//EX_jmp_pc=0;
	//EX_pc_mux_sel=0;
	//flush=0;
end

always_ff @ (posedge clk) begin
	if(reset) begin
	EX_pc<=0;
	EX_rs1_out<=0;
	EX_rs2_out<=0;
	//EX_jmp_pc<=0;
	//EX_pc_mux_sel<=0;
	//flush<=0;
	end
	else if(load) begin
	EX_pc<=ID_pc;
	EX_rs1_out<=ID_rs1_out;
	EX_rs2_out<=ID_rs2_out;
	//EX_jmp_pc<=ID_jmp_pc;
	//EX_pc_mux_sel<=ID_pc_mux_sel;
	//flush<=ID_flush;
	end
	else if(MEM_EX_rdata_hazard)
	begin
	if(WB_rd==EX_rs1 && WB_writeback && WB_rd!=0)
		EX_rs1_out<=WB_in;
	if(WB_rd==EX_rs2 && WB_writeback && WB_rd!=0)
		EX_rs2_out<=WB_in;
	end
end
endmodule : EX_pipe