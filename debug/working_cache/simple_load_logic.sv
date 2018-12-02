module simple_load_logic
(
		input LRU,
		input load,
		output logic load_1,
		output logic load_2
);

always_comb
begin
	load_1=1'b0;
	load_2=1'b0;
	if(load)
	begin
		if(LRU)
			load_2=1'b1;
		else
			load_1=1'b1;
	end
end

endmodule : simple_load_logic
