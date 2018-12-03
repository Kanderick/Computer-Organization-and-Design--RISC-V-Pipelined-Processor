module cache
(
	/*cpu signals*/
	input mem_read,
   input mem_write,
   input [3:0] mem_byte_enable,
   input [31:0] mem_address,
	input [31:0] mem_wdata,
   output logic mem_resp,
   output logic [31:0] mem_rdata,

	
	/*pmem signals*/
	input pmem_resp,
	input [255:0] pmem_rdata,
	output logic pmem_read,
	output logic pmem_write,
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,
	
	/*other signals*/
	input clk,
	
	/*report miss*/
	output logic if_miss
);
logic hit;
logic dirty;
logic set_LRU;
logic [1:0] load_data_select;
logic set_valid;
logic load_tag;
logic set_dirty;
logic clr_dirty;
logic pmem_addr_select;
logic data_write_select;





cache_control control
(
	.hit,
	.dirty,
	.set_LRU,
	.load_tag,
	.load_data_select,
	.set_valid,
	.set_dirty,
	.clr_dirty,
	.pmem_addr_select,
	.data_write_select,	
	.pmem_resp,
	.pmem_write,
	.pmem_read,
	.mem_read,
	.mem_write,
	.mem_resp,
	.clk,
	.if_miss
);

cache_datapath datapath
(
	.load_tag,
	.load_data_select,
	.pmem_addr_select,
	.set_LRU,
	.clr_dirty,
	.set_dirty,
	.set_valid,
	.data_write_select,
	.hit,
	.dirty,
	.mem_address,
	.mem_wdata,
	.mem_byte_enable,
	.mem_rdata, 
	.pmem_rdata,
	.pmem_wdata,
	.pmem_addr(pmem_address),
	.clk
);
endmodule : cache