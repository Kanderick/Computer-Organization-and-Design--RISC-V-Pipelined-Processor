module stream_buffer_datapath
(
	input clk,
	
	/*Signals between L2 and stream write buffer*/
	input [31:0] address,
	input read,
	input write,
	output logic [255:0] rdata,
	input [255:0] wdata,
	output logic resp,
	
	/*Signals between stream write buffer and physical memory*/
	output logic [31:0] pmem_address,
	output logic pmem_read,
	output logic pmem_write,
	input [255:0] pmem_rdata,
	output logic [255:0] pmem_wdata,
	input logic pmem_resp
);

endmodule : stream_buffer_datapath