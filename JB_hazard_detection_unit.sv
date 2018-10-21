import rv32i_types::*;

module JB_hazard_detection_unit 
(
	input [1:0] jb_sel,
	input branch_funct3_t cmpop,
	input [31:0] ID_rs1_out,
	input [31:0] ID_rs2_out,
	output pcmux_sel,
	output flush
);

logic br_out;

CMP JB_CMP
(
	.cmpop,
	.a(ID_rs1_out),
	.b(ID_rs2_out),
	.br_en(br_out)
);

always_comb begin
	if(jb_sel==3'b11)
		pcmux_sel=0;
	else if(jb_sel) begin
		pcmux_sel=1;
	end
	else begin
		pcmux_sel=br_out;
	end

end
endmodule : JB_hazard_detection_unit