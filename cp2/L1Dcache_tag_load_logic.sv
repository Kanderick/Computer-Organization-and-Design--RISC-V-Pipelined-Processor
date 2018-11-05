module tag_load_logic
(
	input load_tag,
	input lru,
	output logic tag_load_0,
	output logic tag_load_1
);

always_comb
begin
	if (load_tag == 0)
	begin
		tag_load_0 = 0;
		tag_load_1 = 0;
	end
	
	else if (load_tag == 1 && lru == 0)
	begin
		tag_load_0 = 1;
		tag_load_1 = 0;
	end
	
	else
	begin
		tag_load_0 = 0;
		tag_load_1 = 1;
	end
end

endmodule : tag_load_logic