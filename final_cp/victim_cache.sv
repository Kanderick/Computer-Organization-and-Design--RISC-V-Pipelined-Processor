module victim_cache 
(
	input clk,
	
	input [31:0] l2_vc_address,
	input [31:0] l2_vc_lru_address,
	input l2_vc_read,
	input l2_vc_write,
	input [255:0] l2_vc_wdata,
	output logic [255:0] l2_vc_rdata,
	output logic l2_vc_resp,
	
	output logic [31:0] vc_pmem_address,
	output logic vc_pmem_read,
	output logic vc_pmem_write,
	output logic [255:0] vc_pmem_wdata,
	input [255:0] vc_pmem_rdata,
	input vc_pmem_resp,
	
	input valid_lru_way
);

	logic hit;
	logic update_victim;
	logic rdata_sel;

victim_cache_datapath victim_cache_datapath
(
	.*
);

victim_cache_control victim_cache_control
(
	.*
);

endmodule	: victim_cache