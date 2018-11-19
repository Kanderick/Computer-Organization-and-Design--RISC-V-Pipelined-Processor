module L2cache_address_decoder
(
	input [31:0] mem_address,
	output logic [4:0] index,
	output logic [3:0] set,
	output logic [22:0] tag
);

always_comb
begin
	index = mem_address[4:0];
	set = mem_address[8:5];
	tag = mem_address[31:9];
end

endmodule : L2cache_address_decoder