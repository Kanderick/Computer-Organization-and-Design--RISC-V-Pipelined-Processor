module L2cache
(
	input clk,

	input [31:0] arbi_l2_address,
	input [255:0] arbi_l2_wdata,
	input arbi_l2_read,
	input arbi_l2_write,
	
	input [255:0] l2_pmem_rdata,
	input l2_pmem_resp,
	
	output logic [255:0] arbi_l2_rdata,
	output logic arbi_l2_resp,
	
	output logic [31:0] l2_pmem_address,
	output logic [255:0] l2_pmem_wdata,
	output logic l2_pmem_read,
	output logic l2_pmem_write,
	output logic l2_miss_sig
);

/*Internal Signals*/
	logic pmem_addr_sel;
	logic load_lru;
	logic load_tag;
	logic load_data;
	logic load_valid;
	logic data_in_sel;
	logic set_dirty;
	logic clr_dirty;
	logic hit;
	logic dirty;
	
L2cache_datapath datapath
(
	.mem_address(arbi_l2_address),
	.mem_wdata(arbi_l2_wdata),
	.pmem_rdata(l2_pmem_rdata),
	.mem_rdata(arbi_l2_rdata),
	.pmem_address(l2_pmem_address),
	.pmem_wdata(l2_pmem_wdata),
	.*
);

L2cache_control control
(
	.mem_read(arbi_l2_read),
	.mem_write(arbi_l2_write),
	.pmem_resp(l2_pmem_resp),
	.mem_resp(arbi_l2_resp),
	.pmem_read(l2_pmem_read),
	.pmem_write(l2_pmem_write),
	.*
);

endmodule : L2cache