module L1Icache_array_load_logic
(
	input lru,
	
	input ld_tag,
	input ld_valid,
	input ld_data,
	
	output logic ld_tag0,
	output logic ld_tag1,
	output logic ld_valid0,
	output logic ld_valid1,
	output logic ld_data0,
	output logic ld_data1
);

always_comb
begin
	if (ld_tag == 0)
	begin
		ld_tag0 = 0;
		ld_tag1 = 0;
	end
	else if (ld_tag == 1 && lru == 0)
	begin
		ld_tag0 = 1;
		ld_tag1 = 0;
	end
	else
	begin
		ld_tag0 = 0;
		ld_tag1 = 1;
	end

	if (ld_valid == 0)
	begin
		ld_valid0 = 0;
		ld_valid1 = 0;
	end
	else if (ld_valid == 1 && lru == 0)
	begin
		ld_valid0 = 1;
		ld_valid1 = 0;
	end
	else
	begin
		ld_valid0 = 0;
		ld_valid1 = 1;
	end
	
	if (ld_data == 0)
	begin
		ld_data0 = 0;
		ld_data1 = 0;
	end
	else if (ld_data == 1 && lru == 0)
	begin
		ld_data0 = 1;
		ld_data1 = 0;
	end
	else
	begin
		ld_data0 = 0;
		ld_data1 = 1;
	end
end

endmodule	: L1Icache_array_load_logic