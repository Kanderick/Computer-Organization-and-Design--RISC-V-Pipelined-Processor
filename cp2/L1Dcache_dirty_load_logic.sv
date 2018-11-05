module dirty_load_logic
(
	input lru,
	input cmp_rst,
	input set_dirty,
	input clr_dirty,
	
	output logic dirty_load_0,
	output logic dirty_load_1,
	output logic dirty_data
);

always_comb
begin
	if (set_dirty == 1 && cmp_rst == 0)
	begin
		dirty_load_0 = 1;
		dirty_load_1 = 0;
		dirty_data = 1;
	end
	
	else if (set_dirty == 1 && cmp_rst == 1)
	begin
		dirty_load_0 = 0;
		dirty_load_1 = 1;
		dirty_data = 1;
	end
	
	else if (clr_dirty == 1 && lru == 0)
	begin
		dirty_load_0 = 1;
		dirty_load_1 = 0;
		dirty_data = 0;
	end
	
	else if (clr_dirty == 1 && lru == 1)
	begin
		dirty_load_0 = 0;
		dirty_load_1 = 1;
		dirty_data = 0;
	end
	
	else
	begin
		dirty_load_0 = 0;
		dirty_load_1 = 0;
		dirty_data = 0;
	end
end

endmodule : dirty_load_logic