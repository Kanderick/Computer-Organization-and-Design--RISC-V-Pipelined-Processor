module tag_comparator
(
	input [23:0] tag,
	input [23:0] tag_0,
	input [23:0] tag_1,
	input valid_0,
	input valid_1,
	
	output logic hit,
	output logic cmp_rst
);

always_comb
begin
	if ((tag == tag_0) && valid_0)
	begin
		hit = 1'b1;
		cmp_rst = 1'b0;
	end
	
	else if ((tag == tag_1) && valid_1)
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

endmodule : tag_comparator