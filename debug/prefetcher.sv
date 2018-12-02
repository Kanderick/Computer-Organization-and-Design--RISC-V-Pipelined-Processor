module prefetcher
(
	input clk,
	input [31:0] ORB,
	input prefetch_en,
	/**/
	.pmem_address(address),
	.pmem_read(read),
	.pmem_write(write),
	.pmem_rdata(rdata),
	.pmem_wdata(wdata),
	.pmem_resp(resp)
	input [31:0] L2_req_address,
	input L2_req_read,
	input L2_req_write,
	input [31:0] L2_req_rdata,
	output logic 
);

endmodule : prefetcher