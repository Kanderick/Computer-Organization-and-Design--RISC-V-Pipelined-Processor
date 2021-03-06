import rv32i_types::*;

module JB_hazard_detection_unit 
(
	input [1:0] jb_sel,
	input branch_funct3_t cmpop,
	input [31:0] rs1_out,
	input [31:0] rs2_out,
	output logic pcmux_sel,
	output logic flush
);

logic br_out;

CMP JB_CMP
(
	.cmpop,
	.a(rs1_out),
	.b(rs2_out),
	.br_en(br_out)
);

always_comb begin
	flush=1'b0;
	pcmux_sel=0;
	if(jb_sel==0)
		pcmux_sel=0;
	else if(jb_sel!=2'b11) begin
		pcmux_sel=1;
		flush=1;
	end
	else begin
		pcmux_sel=br_out;
		flush=br_out;
	end

end
endmodule : JB_hazard_detection_unit