module L1Icache_address_decoder
(
	input [31:0] cpu_l1i_address,
	output logic [4:0] index,
	output logic [2:0] set,
	output logic [23:0] tag
);

always_comb
begin
	index = cpu_l1i_address[4:0];
	set = cpu_l1i_address[7:5];
	tag = cpu_l1i_address[31:8];
end

endmodule : L1Icache_address_decoder