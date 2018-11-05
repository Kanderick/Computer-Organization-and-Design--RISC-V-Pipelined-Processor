module data_load_logic
(
	input load_data,
	input data_sel,
	
	output logic data_load_0,
	output logic data_load_1
);

always_comb
begin
	if (load_data == 1 && data_sel == 0)
	begin
		data_load_0 = 1;
		data_load_1 = 0;
	end
	
	else if (load_data == 1 && data_sel == 1)
	begin
		data_load_0 = 0;
		data_load_1 = 1;
	end
	
	else
	begin
		data_load_0 = 0;
		data_load_1 = 0;
	end
end

endmodule : data_load_logic