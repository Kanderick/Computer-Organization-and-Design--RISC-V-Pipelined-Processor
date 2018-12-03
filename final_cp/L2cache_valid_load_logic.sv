module L2cache_valid_load_logic
(
	input load_valid,
	input lru,
	
	output logic valid_load_0,
	output logic valid_load_1
);

always_comb
begin
	if (load_valid == 1 && lru == 0)
	begin
		valid_load_0 = 1;
		valid_load_1 = 0;
	end
	
	else if (load_valid == 1 && lru == 1)
	begin
		valid_load_0 = 0;
		valid_load_1 = 1;
	end
	
	else
	begin
		valid_load_0 = 0;
		valid_load_1 = 0;
	end
end

endmodule : L2cache_valid_load_logic