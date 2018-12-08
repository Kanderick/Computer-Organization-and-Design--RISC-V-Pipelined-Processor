module Icache
(
// cache interface
    input clk,
    input logic mem_read,
    input logic [31:0] mem_address,
    output logic mem_resp,
    output logic [31:0] mem_rdata,
 // physical memory
    output logic pmem_read,
    output logic [31:0] pmem_address,
    input logic pmem_resp,
    input logic [255:0] pmem_rdata,
 // prefetcher
	 output logic if_miss,
	 output logic miss_sig
);
logic load_wdata_reg;
logic way_sel_method;
logic load_line_data;
logic load_valid;
logic load_dirty;
logic load_LRU;
logic line_datain_sel;
logic valid_in;
logic dirty_in;
logic dirty;
logic hit;
logic valid;
logic address_sel;

assign miss_sig = pmem_read;

 icache_control control
(
    .clk,
    .mem_read,
    .mem_write,
    .mem_resp,
    .pmem_read,
    .pmem_write,
    .pmem_resp,
    .load_wdata_reg,
    .way_sel_method,
    .load_line_data,
    .load_valid,
    .load_dirty,
    .load_LRU,
    .line_datain_sel,
    .valid_in,
    .dirty_in,
    .dirty,
    .hit,
    .valid,
    .address_sel,
	 .if_miss

    
);

icache_datapath datapath
(
    .clk,
    .mem_byte_enable,
    .mem_address,
    .mem_rdata,
    .pmem_address,
    .pmem_rdata,
    .way_sel_method,
    .load_line_data,
    .load_valid,
    .load_wdata_reg,
    .load_dirty,
    .load_LRU,
    .line_datain_sel,
    .valid_in,
    .dirty_in, 
    .dirty,
    .hit,
    .valid,
    .address_sel

);

endmodule
