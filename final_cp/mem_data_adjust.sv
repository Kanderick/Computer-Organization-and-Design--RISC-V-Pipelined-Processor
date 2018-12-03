module mem_data_adjust
(
	input [3:0] byte_en,
	input [31:0] mem_data,
	output logic [7:0] adjust_data [4]
);

always_comb
begin
	if(byte_en==4'b1111)
	begin
		adjust_data[0] = mem_data[7:0];
		adjust_data[1] = mem_data[15:8];
		adjust_data[2] = mem_data[23:16];
		adjust_data[3] = mem_data[31:24];
	end
	else if(byte_en==4'b0011)
	begin
		adjust_data[0] = mem_data[7:0];
		adjust_data[1] = mem_data[15:8];
		adjust_data[2] = 0;
		adjust_data[3] = 0;
	end
	else if(byte_en==4'b0001)
	begin
		adjust_data[0] = mem_data[7:0];
		adjust_data[1] = 0;
		adjust_data[2] = 0;
		adjust_data[3] = 0;
	end
	else
	begin
		adjust_data[0] = 0;
		adjust_data[1] = 0;
		adjust_data[2] = 0;
		adjust_data[3] = 0;
	end
end
endmodule : mem_data_adjust