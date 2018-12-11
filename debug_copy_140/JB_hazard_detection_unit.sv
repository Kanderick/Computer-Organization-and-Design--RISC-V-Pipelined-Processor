import rv32i_types::*;

module JB_hazard_detection_unit 
(
	input [1:0] jb_sel,
	input branch_funct3_t cmpop,
	input [31:0] rs1_out,
	input [31:0] rs2_out,
    input EX_prediction,
    input EX_BTB_hit,
	output logic pcmux_sel,
	output logic flush,
    output logic update_BHT,
    output logic replace_BHT,
	 output logic is_jal
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
    replace_BHT = 0;
    update_BHT = 0;
	 is_jal = 0;
	 /*
	if(jb_sel==0)
		pcmux_sel=0;
	else if(jb_sel!=2'b11) begin //jump
        if (!EX_BTB_hit) begin
            pcmux_sel=1;
            flush=1;
            replace_BHT = 1;
        end
	end
	else begin
		pcmux_sel= (br_out == EX_prediction)? 1'b0 : 1'b1;
        flush = (br_out == EX_prediction)? 1'b0 : 1'b1;
        update_BHT = 1;
        if (!EX_BTB_hit) 
            replace_BHT = 1;
	end */
	case(jb_sel)
	2'b0: pcmux_sel = 0; // no jump
	2'b1: begin  //jal
	        if (!EX_BTB_hit) begin
					pcmux_sel=1;
					flush=1;
					replace_BHT = 1;
					is_jal = 1;
			  end
			end
	2'b10: begin // jalr don't predict for now
				 pcmux_sel=1;
				 flush=1;
			 end 
	2'b11: begin //branch
		  pcmux_sel= (br_out == EX_prediction)? 1'b0 : 1'b1;
        flush = (br_out == EX_prediction)? 1'b0 : 1'b1;
        update_BHT = 1;
        if (!EX_BTB_hit) 
            replace_BHT = 1;
	end
	default: ;
	endcase
end
endmodule : JB_hazard_detection_unit