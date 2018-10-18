module pmem_addr_logic
(
	input [31:0] mem_address,
	input LRU,
	input [2:0] set,
	input [23:0] tag_1,
	input [23:0] tag_2,
	input pmem_addr_select,
	output logic [31:0] pmem_addr
);

always_comb
begin
	pmem_addr=mem_address;
	if(pmem_addr_select)
	begin
		if(LRU)
			pmem_addr={{tag_2[23:0]}, {set[2:0]}, 5'b0};
		else
			pmem_addr={{tag_1[23:0]}, {set[2:0]}, 5'b0};
	end
end
endmodule : pmem_addr_logic