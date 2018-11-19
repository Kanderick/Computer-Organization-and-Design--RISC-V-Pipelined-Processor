module WB_MEM_EX_forwarding 
(
	input [4:0] EX_rs1,
	input [4:0] EX_rs2,
	input [4:0] MEM_rd,
	input [4:0] WB_rd,
	input [2:0] MEM_regfilemux_sel,
	input MEM_writeback,
	input WB_writeback,
	output logic [1:0] forwarding_sel1,
	output logic [1:0] forwarding_sel2,
	output logic MEM_EX_rdata_hazard
);

always_comb 
begin
	MEM_EX_rdata_hazard=0;
	forwarding_sel2=2'b0;
	forwarding_sel1=2'b0;
	if(WB_rd==EX_rs1 && WB_writeback && WB_rd!=0)
		forwarding_sel1=2'b10;
	if(WB_rd==EX_rs2 && WB_writeback && WB_rd!=0)
		forwarding_sel2=2'b10;
	if(MEM_rd==EX_rs1 && MEM_writeback && MEM_rd!=0)
		forwarding_sel1=2'b01;
	if(MEM_rd==EX_rs2 && MEM_writeback && MEM_rd!=0)
		forwarding_sel2=2'b01;
	if(((MEM_rd==EX_rs1) || (MEM_rd==EX_rs2)) && WB_writeback && WB_rd!=0 && (MEM_regfilemux_sel==3'b011))
		MEM_EX_rdata_hazard=1'b1;
end

endmodule : WB_MEM_EX_forwarding