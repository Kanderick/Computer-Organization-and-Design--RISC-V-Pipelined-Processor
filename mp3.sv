module mp3
(
	/*physical memory*/
	input pmem_resp,
	input [255:0] pmem_rdata,
	output logic pmem_read,
	output logic pmem_write,
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,

	/*other signals*/
	input clk
);
logic mem_resp;
logic [31:0] mem_rdata;
logic mem_read;
logic mem_write;
logic [3:0] mem_byte_enable;
logic [31:0] mem_address;
logic [31:0] mem_wdata;
/*
module mp3_cpu
(
    input clk,

Memory signals
    input mem_resp,
    input [31:0] mem_rdata,
    output mem_read,
    output mem_write,
    output [3:0] mem_byte_enable,
    output [31:0] mem_address,
    output [31:0] mem_wdata
);
*/
mp3_cpu cpu
(
	.clk,
	.mem_resp,
   .mem_rdata,
   .mem_read,
   .mem_write,
   .mem_byte_enable,
   .mem_address,
   .mem_wdata
);
/*
module cache
(
cpu signals
	input mem_read,
   input mem_write,
   input [3:0] mem_byte_enable,
   input [31:0] mem_address,
   output logic mem_resp,
   output logic [31:0] mem_rdata,
   output [31:0] mem_wdata
	
pmem signals
	input pmem_resp,
	input [255:0] pmem_rdata,
	output logic pmem_read,
	output logic pmem_write,
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata
);
*/
cache cache
(
	.mem_read,
   .mem_write,
   .mem_byte_enable,
   .mem_address,
   .mem_resp,
   .mem_rdata,
   .mem_wdata,
	
	.pmem_resp,
	.pmem_rdata,
	.pmem_read,
	.pmem_write,
	.pmem_address,
	.pmem_wdata,
	
	.clk
);
endmodule : mp3