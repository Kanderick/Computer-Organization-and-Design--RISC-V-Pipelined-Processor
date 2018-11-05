module L1Dcache
(
	input clk,

	input [31:0] mem_address,
	input [31:0] mem_wdata,
	input mem_read,
	input mem_write,
	input [3:0] mem_byte_enable,
	
	input [255:0] pmem_rdata,
	input pmem_resp,
	
	output logic [31:0] mem_rdata,
	output logic mem_resp,
	
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,
	output logic pmem_read,
	output logic pmem_write
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
	
L1Dcache_datapath datapath
(
	.*
);

L1Dcache_control control
(
	.*
);

endmodule : L1Dcache