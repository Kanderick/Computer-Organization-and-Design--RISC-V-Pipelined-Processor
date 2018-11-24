module L1Dcache
(
	input clk,

	input [31:0] cpu_l1d_address,
	input [31:0] cpu_l1d_wdata,
	input cpu_l1d_read,
	input cpu_l1d_write,
	input [3:0] cpu_l1d_byte_enable,

	input [255:0] l1d_arbi_rdata,
	input l1d_arbi_resp,

	output logic [31:0] cpu_l1d_rdata,
	output logic cpu_l1d_resp,

	output logic [31:0] l1d_arbi_address,
	output logic [255:0] l1d_arbi_wdata,
	output logic l1d_arbi_read,
	output logic l1d_arbi_write,
	output logic l1d_miss_sig
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
	.mem_address(cpu_l1d_address),
	.mem_wdata(cpu_l1d_wdata),
	.mem_byte_enable(cpu_l1d_byte_enable),
	.pmem_rdata(l1d_arbi_rdata),
	.mem_rdata(cpu_l1d_rdata),
	.pmem_address(l1d_arbi_address),
	.pmem_wdata(l1d_arbi_wdata),
	.*
);

L1Dcache_control control
(
	.mem_read(cpu_l1d_read),
	.mem_write(cpu_l1d_write),
	.pmem_resp(l1d_arbi_resp),
	.mem_resp(cpu_l1d_resp),
	.pmem_read(l1d_arbi_read),
	.pmem_write(l1d_arbi_write),
	.*
);

endmodule : L1Dcache
