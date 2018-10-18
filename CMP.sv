import rv32i_types::*;

module CMP 
(
		input branch_funct3_t cmpop,
		input [31:0] a,
		input [31:0] b,
		output logic br_en
);

logic equal, signed_less, unsigned_less, negate;

always_comb
begin
	equal = (a == b);
	signed_less = ($signed(a) < $signed(b));
	unsigned_less = ($unsigned(a) < $unsigned(b));
	negate = 1'b0;
	if(cmpop == bne || cmpop == bge || cmpop == bgeu)
		negate = 1'b1;
		
	if(cmpop == beq || cmpop == bne)
		br_en = negate ^ equal;
	else if(cmpop == blt || cmpop == bge)
		br_en = negate ^ signed_less;
	else if(cmpop == bltu || cmpop == bgeu)
		br_en = negate ^ unsigned_less;
	else 
		br_en = 1'b0;
end
endmodule : CMP 