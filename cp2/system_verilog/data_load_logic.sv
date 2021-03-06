module data_load_logic
(
	input LRU,
	input hitway,
	input [1:0] load_data_select,
	output logic load_1,
	output logic load_2
);

always_comb
begin 
	load_1=1'b0;
	load_2=1'b0;
	if(load_data_select[1])
	begin
		if(load_data_select[0])
		begin
			if(LRU)
				load_2=1'b1;
			else
				load_1=1'b1;
		end
		else
		begin
			if(hitway)
				load_2=1'b1;
			else
				load_1=1'b1;
		end
	end
end
endmodule : data_load_logic
