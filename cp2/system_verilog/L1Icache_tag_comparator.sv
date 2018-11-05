module L1Icache_tag_comparator
(
	input [23:0] tag,
	input [23:0] tag0,
	input [23:0] tag1,
	input valid0,
	input valid1,
	
	output logic hit,
	output logic cmp_rst
);

always_comb
begin
	if ((tag == tag0) && valid0)
	begin
		hit = 1'b1;
		cmp_rst = 1'b0;
	end
	
	else if ((tag == tag1) && valid1)
	begin
		hit = 1'b1;
		cmp_rst = 1'b1;
	end
	
	else
	begin
		hit = 1'b0;
		cmp_rst = 1'b0;
	end
end

endmodule : L1Icache_tag_comparator