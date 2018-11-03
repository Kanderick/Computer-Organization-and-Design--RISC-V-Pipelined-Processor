module WB_IF_forwarding
(
	input [4:0] ID_rs1,
	input [4:0] ID_rs2,
	input [4:0] WB_rd,
	input WB_load_regfile,
	input [31:0] regfile_rs1_out,
	input [31:0] regfile_rs2_out,
	input [31:0] WB_in,
	output logic [31:0] ID_rs1_out,
	output logic [31:0] ID_rs2_out
);

always_comb
begin
	ID_rs1_out=regfile_rs1_out;
	ID_rs2_out=regfile_rs2_out;
	if(WB_load_regfile)
	begin
		if(WB_rd==ID_rs1)
			ID_rs1_out=WB_in;
		if(WB_rd==ID_rs2)
			ID_rs2_out=WB_in;
	end

end
endmodule : WB_IF_forwarding