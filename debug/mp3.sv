
module mp3
(
	/*other signals*/
    input clk,
    output read,
    output write,
    output logic [31:0] address,
    output logic [255:0] wdata,
    input logic resp,
    input logic [255:0] rdata
);

// output of cache
logic read_a;
logic write_a;
logic [3:0] wmask_a;
logic [31:0] address_a;
logic [31:0] wdata_a;
logic resp_a;
logic [31:0] rdata_a;
logic read_b;
logic write_b;
logic [3:0] wmask_b;
logic [31:0] address_b;
logic [31:0] wdata_b;
logic resp_b;
logic [31:0] rdata_b;

logic [31:0] address_l2;
logic read_l2;
logic write_l2;
logic [255:0] rdata_l2;
logic [255:0] wdata_l2;
logic resp_l2;

//input of cache from arbitor
logic read_I, read_D;
logic write_I, write_D;
//logic [3:0] wmask_D;
logic [31:0] address_I, address_D;
logic [255:0] wdata_D;
logic resp_I, resp_D;
logic [255:0] rdata_I, rdata_D;

//performance unit
logic flush;
logic [1:0] jb_sel;
logic l1i_miss_sig;
logic l1d_miss_sig;
logic l2_miss_sig;
logic if_stall;
logic [31:0] cpu_l1d_address;
logic [31:0] cpu_l1d_rdata;
logic cpu_l1d_read;
logic cpu_l1d_resp;
logic mis_prediction;

//eviction write buffer
logic [31:0] l2_evict_address;
logic l2_evict_read;
logic l2_evict_write;
logic [255:0] l2_evict_rdata;
logic [255:0] l2_evict_wdata;
logic l2_evict_resp;

//eviction write buffer_L1
logic [31:0] l1_evict_address;
logic l1_evict_read;
logic l1_evict_write;
logic [255:0] l1_evict_rdata;
logic [255:0] l1_evict_wdata;
logic l1_evict_resp;

mp3_cpu mp3_cpu
(
    .clk,
    .read_a,
    .write_a,
    .wmask_a,
    .address_a,
    .wdata_a,
    .resp_a,
    .rdata_a,
    .read_b,
    .write_b,
    .wmask_b,
    .address_b,
    .wdata_b,
    .resp_b,
    .rdata_b,
	 .flush,
	 .jb_sel,
	 .if_stall,
	 .pcmux_sel(mis_prediction)
);


cache instruction_cache
(
	.clk,
	.mem_address(address_a),
	.mem_rdata(rdata_a),
	.mem_read(read_a),
	.mem_resp(resp_a),
	.mem_write(0),	
	
	.pmem_address(address_I),
	.pmem_rdata(rdata_I),
	.pmem_read(read_I),
	.pmem_resp(resp_I) ,
	.miss_sig(l1i_miss_sig)
);

cache data_cache
(
	.clk,
   .mem_address(address_b),
	.mem_wdata(wdata_b),
	.mem_read(read_b),
	.mem_write(write_b),
	.mem_byte_enable(wmask_b),
	.mem_rdata(rdata_b),
	.mem_resp(resp_b),
	
	.pmem_rdata(rdata_D),
	.pmem_resp(resp_D),
	.pmem_address(address_D),
	.pmem_wdata(wdata_D),
	.pmem_read(read_D),
	.pmem_write(write_D) ,
	.miss_sig(l1d_miss_sig)
);


arbitor #(.width(256)) arbitor
(
    .clk,
    // instruction cache signal
    .icache_read(read_I),
    .icache_address(address_I),
    .icache_rdata(rdata_I),
    .icache_resp(resp_I),

    // data cache signal
    .dcache_read(read_D),
    .dcache_write(write_D),
    .dcache_address(address_D),
    .dcache_wdata(wdata_D),
    .dcache_byte_enable(),
    .dcache_rdata(rdata_D),
    .dcache_resp(resp_D),

    //L2 cache signal
    .L2cache_read(read_l2),
    .L2cache_write(write_l2),
    .L2cache_address(address_l2),
    .L2cache_wdata(wdata_l2),
    .L2cache_byte_enable(),
    .L2cache_rdata(rdata_l2),
    .L2cache_resp(resp_l2)
);

 L2cache L2cache
(
	.mem_read(read_l2),
   .mem_write(write_l2),
   .mem_address(address_l2),
	.mem_wdata(wdata_l2),
   .mem_resp(resp_l2),
   .mem_rdata(rdata_l2),

	
	
	.pmem_resp(l2_evict_resp),
	.pmem_rdata(l2_evict_rdata),
	.pmem_read(l2_evict_read),
	.pmem_write(l2_evict_write),
	.pmem_address(l2_evict_address),
	.pmem_wdata(l2_evict_wdata),
	
	//.pmem_resp(resp),
	//.pmem_rdata(rdata),
	//.pmem_read(read),
	//.pmem_write(write),
	//.pmem_address(address),
	//.pmem_wdata(wdata),	
	.clk,
	.miss_sig(l2_miss_sig)
);

eviction_write_buffer eviction_write_buffer_L2
(
	.clk,
	.address(l2_evict_address),
	.read(l2_evict_read),
	.write(l2_evict_write),
	.rdata(l2_evict_rdata),
	.wdata(l2_evict_wdata),
	.resp(l2_evict_resp),
	.pmem_address(address),
	.pmem_read(read),
	.pmem_write(write),
	.pmem_rdata(rdata),
	.pmem_wdata(wdata),
	.pmem_resp(resp)
); 

`ifdef USE_PERFORM_UNIT
performance_unit performance_unit
(
	.clk,
	.reset(0),
	.if_stall,
	.resp_l2,
	/*br*/
	.flush,
	.jb_sel,
	/*l1i*/
	.read_a,
	.l1i_miss_sig,
	/*l1d*/
	.read_b,
	.write_b,
	.l1d_miss_sig,
	/*l2*/
	.write_l2,
	.read_l2,
	.l2_miss_sig,
	/*arbitor conflict*/
	.read_I,
	.read_D,
	.write_D,
	/*user read ports*/
	.cpu_l1d_read,
	.address_b,
	.cpu_l1d_address,
	.cpu_l1d_rdata,
	.rdata_b,
	.resp_b,
	.cpu_l1d_resp
);
`endif 

endmodule : mp3
