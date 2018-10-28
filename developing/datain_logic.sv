module datain_logic
(
	input hit_way,
	input [31:0] mem_wdata,
	input [3:0] mem_byte_enable,
	input [2:0] offset,
	input [1:0] byte_offset,
	input [255:0] data_1,
	input [255:0] data_2,
	output logic [255:0] mem_wdata_out
);

always_comb
begin
	if(hit_way)
		mem_wdata_out[255:0]=data_2[255:0];
	else
		mem_wdata_out[255:0]=data_1[255:0];
		
	if(mem_byte_enable[0])
		mem_wdata_out[(32*offset+8*byte_offset+7)-:8]=mem_wdata[7:0];
	if(mem_byte_enable[1])
		mem_wdata_out[(32*offset+8*byte_offset+15)-:8]=mem_wdata[15:8];
	if(mem_byte_enable[2])
		mem_wdata_out[(32*offset+8*byte_offset+23)-:8]=mem_wdata[23:16];
	if(mem_byte_enable[3])
		mem_wdata_out[(32*offset+8*byte_offset+31)-:8]=mem_wdata[31:24];
	
end

endmodule : datain_logic