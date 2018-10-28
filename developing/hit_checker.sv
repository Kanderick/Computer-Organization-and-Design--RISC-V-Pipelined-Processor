module hit_checker
(
	input [23:0] tag_1_out,
	input [23:0] tag_2_out,
	input valid_1_out,
	input valid_2_out,
	input [31:0] mem_addr,
	output logic hit,
	output logic hit_way
);

always_comb
begin
	hit=0;
	hit_way=0;
	if(tag_1_out==mem_addr[31:8] && valid_1_out==1)
		hit=1;
	else if(tag_2_out==mem_addr[31:8] && valid_2_out==1)
	begin
		hit=1;
		hit_way=1;
	end
end

endmodule
