module cache_address_decoder
(
	input [31:0] mem_address,
	output logic [4:0] index,
	output logic [2:0] set,
	output logic [23:0] tag
);

always_comb
begin
	index = mem_address[4:0];
	set = mem_address[7:5];
	tag = mem_address[31:8];
end

endmodule : cache_address_decoder