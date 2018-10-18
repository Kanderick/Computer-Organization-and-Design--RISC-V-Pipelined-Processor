import rv32i_types::*;

module cmp
(
	input branch_funct3_t cmpop,
	input rv32i_word op1,
	input rv32i_word op2,
	output logic br_en
);

always_comb
begin
	case(cmpop)
		default: br_en = 0;
		blt: br_en = ($signed(op1) < $signed(op2))? 1 : 0;
		bltu: br_en = (op1 < op2)? 1 : 0;
		beq: br_en = (op1 == op2);
		bne: br_en = (op1 != op2);
		bge: br_en = ($signed(op1) >= $signed(op2))? 1 : 0;
		bgeu: br_en = (op1 >= op2)? 1 : 0;
	endcase
end

endmodule : cmp