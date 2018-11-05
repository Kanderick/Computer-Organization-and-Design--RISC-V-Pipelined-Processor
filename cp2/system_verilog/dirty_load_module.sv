module dirty_load_logic
(
	input LRU,
	input clr_dirty,
	input hitway,
	input set_dirty,
	output logic in_1,
	output logic in_2,
	output logic load_1,
	output logic load_2
);

always_comb
begin
	load_1=1'b0;
	load_2=1'b0;
	in_1=1'b0;
	in_2=1'b0;
	if(set_dirty)
	begin
		if(hitway)
		begin
			load_2=1'b1;
			in_2=1'b1;
		end
		else
		begin
			load_1=1'b1;
			in_1=1'b1;
		end
	end
	else if(clr_dirty)
	begin
		if(LRU)
			load_2=1'b1;
		else
			load_1=1'b1;
	end

end

endmodule : dirty_load_logic
