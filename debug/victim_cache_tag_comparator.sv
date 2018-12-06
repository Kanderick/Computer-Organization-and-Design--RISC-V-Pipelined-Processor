module victim_cache_tag_comparator
(
	input [31:0] l2_vc_address,
	input [26:0] tag0,
	input [26:0] tag1,
	input [26:0] tag2,
	input [26:0] tag3,
	
	output logic hit,
	output logic [3:0] hit_way
);

	logic [26:0] address_word;
	
assign address_word = l2_vc_address[31:5];
	
always_comb
begin
	if (address_word == tag0)
	begin
		hit = 1;
		hit_way = 4'b0001;
	end
	
	else if(address_word == tag1)
	begin
		hit = 1;
		hit_way = 4'b0010;
	end
	
	else if(address_word == tag2)
	begin
		hit = 1;
		hit_way = 4'b0100;
	end
	
	else if(address_word == tag3)
	begin
		hit = 1;
		hit_way = 4'b1000;
	end
	
	else
	begin
		hit = 0;
		hit_way = 0000;
	end
end


endmodule	: victim_cache_tag_comparator