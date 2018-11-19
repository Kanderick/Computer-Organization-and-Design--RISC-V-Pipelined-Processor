module pmem_address_logic
(
	input lru,
	input [23:0] tag_0,
	input [23:0] tag_1,
	input [2:0] set,
	input pmem_addr_sel,
	input [31:0] mem_address,
	
	output logic [31:0] pmem_address
);

always_comb
begin
	if (pmem_addr_sel == 0)
	begin
		pmem_address = mem_address;
	end
	
	else if (pmem_addr_sel == 1 && lru == 0)
	begin
		pmem_address = {tag_0, set, 5'b00000};
	end
	
	else
	begin
		pmem_address = {tag_1, set, 5'b00000};
	end
end

endmodule : pmem_address_logic