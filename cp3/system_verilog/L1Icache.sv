module L1Icache
(
	input clk,

	input [31:0] cpu_l1i_address,
	output logic [31:0] cpu_l1i_rdata,
	input cpu_l1i_read,
	output logic cpu_l1i_resp,

	output logic [31:0] l1i_arbi_address,
	input [255:0] l1i_arbi_rdata,
	output logic l1i_arbi_read,
	input l1i_arbi_resp
);

/*Internal Signals*/
	logic ld_tag;
	logic ld_lru;
	logic ld_valid;
	logic ld_data;
	logic hit;

L1Icache_datapath L1Icache_datapath
(
	.*
);

L1Icache_control L1Icache_control
(
	.*
);

endmodule	: L1Icache
