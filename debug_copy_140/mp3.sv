`define USE_PERFORM_UNIT
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


//eviction write buffer_L1
logic [31:0] l1_evict_address;
logic l1_evict_read;
logic l1_evict_write;
logic [255:0] l1_evict_rdata;
logic [255:0] l1_evict_wdata;
logic l1_evict_resp;
logic [31:0] MEM_PC;
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
	 .MEM_PC,
	 .pcmux_sel(mis_prediction)
);

icache instruction_cache
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
	.pmem_resp(resp_I),
	.miss_sig(l1i_miss_sig)
);
logic if_MEM_datamiss;
logic if_L1D_miss;
logic if_L2_miss;
assign if_MEM_datamiss=if_L2_miss;

`ifdef USE_PERFORM_UNIT
performance_unit_user_enable performance_unit_user_enable
(
	.clk,
	.reset(),
	.if_stall,
	.resp_l2,
	/*br miss prediction*/
	.flush,
	.jb_sel,
	/*L1I miss*/
	.l1i_miss_sig,
	.read_a,
	/*L1D miss*/
	.l1d_miss_sig,
	.read_b,
	.write_b,
	/*L2 miss*/
	.l2_miss_sig,
	.write_l2,
	.read_l2,
	/*arbitor conflict*/
	.read_I,
	.read_D,
	.write_D,
	/*user interface*/
	.cpu_l1d_read,
	.address_b,
	.cpu_l1d_address,
	.cpu_l1d_rdata,
	.rdata_b,
	.resp_b,
	.cpu_l1d_resp
);
`endif
dcache data_cache
(
	.clk,
   .mem_address(cpu_l1d_address),
	.mem_wdata(wdata_b),
	.mem_read(cpu_l1d_read),
	.mem_write(write_b),
	.mem_byte_enable(wmask_b),
	.mem_rdata(cpu_l1d_rdata),
	.mem_resp(cpu_l1d_resp),

	.pmem_rdata(rdata_D),
	.pmem_resp(resp_D),
	.pmem_address(address_D),
	.pmem_wdata(wdata_D),
	.pmem_read(read_D),
	.if_miss(if_L1D_miss),
	.pmem_write(write_D),
	.miss_sig(l1d_miss_sig)
);


arbitor_with_reg #(.width(256)) arbitor
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
	 
	 /*
	 .L2cache_read(read),
    .L2cache_write(write),
    .L2cache_address(address),
    .L2cache_wdata(wdata),
    .L2cache_byte_enable(),
    .L2cache_rdata(rdata),
    .L2cache_resp(resp)
	 */
);

	//eviction write buffer
	logic [31:0] l2_evict_address;
	logic l2_evict_read;
	logic l2_evict_write;
	logic [255:0] l2_evict_rdata;
	logic [255:0] l2_evict_wdata;
	logic l2_evict_resp;


	logic [31:0] l2_vc_lru_address, l2_vc_lru_address_reg;
	logic [31:0] l2_vc_address, l2_vc_address_reg;
	logic l2_vc_read, l2_vc_read_reg;
	logic l2_vc_write, l2_vc_write_reg;
	logic [255:0] l2_vc_wdata, l2_vc_wdata_reg;
	logic [255:0] l2_vc_rdata, l2_vc_rdata_reg;
	logic l2_vc_resp, l2_vc_resp_reg;
	logic l2_vc_valid_lru_way, l2_vc_valid_lru_way_reg;

 L2cache L2cache
(
	.mem_read(read_l2),
   .mem_write(write_l2),
   .mem_address(address_l2),
	.mem_wdata(wdata_l2),
   .mem_resp(resp_l2),
   .mem_rdata(rdata_l2),

/*
	.pmem_resp(l2_evict_resp),
	.pmem_rdata(l2_evict_rdata),
	.pmem_read(l2_evict_read),
	.pmem_write(l2_evict_write),
	.pmem_address(l2_evict_address),
	.pmem_wdata(l2_evict_wdata),
	.write_back_addr(),
*/
	
	//.pmem_resp(l2_vc_resp),
	//.pmem_rdata(l2_vc_rdata),
	 .pmem_resp(l2_evict_resp),
	 .pmem_rdata(l2_evict_rdata),
	.pmem_read(l2_vc_read),
	.pmem_write(l2_vc_write),
	.pmem_address(l2_vc_address),
	.pmem_wdata(l2_vc_wdata),
	.write_back_addr(l2_vc_lru_address),
	.valid_lru_way(l2_vc_valid_lru_way),
	

	
	//.pmem_resp(resp),
	//.pmem_rdata(rdata),
	//.pmem_read(read),
	//.pmem_write(write),
	//.pmem_address(address),
	//.pmem_wdata(wdata),
	.if_miss(if_L2_miss),
	.clk,
	.miss_sig(l2_miss_sig)
); 
	
	mem_access_regslice  #(.width(256), .custom_sig_width(32), .custom_sig_width_2(1)) l2_victim_slice
	(
		 .clk,

		 //L2 cache signal
		 .L2cache_read(l2_vc_read),
		 .L2cache_write(l2_vc_write),
		 .L2cache_address(l2_vc_address),
		 .L2cache_wdata(l2_vc_wdata),
		 .custom_signal(l2_vc_lru_address),
		 .custom_signal_2(l2_vc_valid_lru_way),
		 //L2 cache signalreg/
		 /*
		 .L2cache_read_reg(l2_vc_read_reg),
		 .L2cache_write_reg(l2_vc_write_reg),
		 .L2cache_address_reg(l2_vc_address_reg),
		 .L2cache_wdata_reg(l2_vc_wdata_reg),
		 .L2cache_rdata(l2_vc_rdata),
		 .L2cache_resp(l2_vc_resp),   
		 .custom_signal_reg(l2_vc_lru_address_reg),
		 .custom_signal_2_reg(l2_vc_valid_lru_way_reg),		 
		 */
		 /*
		 .L2cache_read_reg(read),
		 .L2cache_write_reg(write),
		 .L2cache_address_reg(address),
		 .L2cache_wdata_reg(wdata),
		 .L2cache_rdata(rdata),
		 .L2cache_resp(resp),   
		 .L2cache_byte_enable_reg(),
		 .L2cache_byte_enable()
		 */
		 .L2cache_read_reg(l2_evict_read),
		 .L2cache_write_reg(l2_evict_write),
		 .L2cache_address_reg(l2_evict_address),
		 .L2cache_wdata_reg(l2_evict_wdata),
		 .L2cache_rdata(l2_evict_rdata),
		 .L2cache_resp(l2_evict_resp),   
		 .L2cache_byte_enable_reg(),
		 .L2cache_byte_enable()	
	); 
	/*
victim_cache victim_cache
(
	.clk,
	/
	.l2_vc_address(l2_vc_address),
	.l2_vc_lru_address(l2_vc_lru_address),
	.l2_vc_read(l2_vc_read),
	.l2_vc_write(l2_vc_write),
	.l2_vc_wdata(l2_vc_wdata),
	.l2_vc_rdata(l2_vc_rdata),
	.l2_vc_resp(l2_vc_resp),
	.valid_lru_way(l2_vc_valid_lru_way),
	/
	.l2_vc_address(l2_vc_address_reg),
	.l2_vc_lru_address(l2_vc_lru_address_reg),
	.l2_vc_read(l2_vc_read_reg),
	.l2_vc_write(l2_vc_write_reg),
	.l2_vc_wdata(l2_vc_wdata_reg),
	.l2_vc_rdata(l2_vc_rdata),
	.l2_vc_resp(l2_vc_resp),
	.valid_lru_way(l2_vc_valid_lru_way_reg),
	/
	.vc_pmem_address(l2_evict_address),
	.vc_pmem_read(l2_evict_read),
	.vc_pmem_write(l2_evict_write),
	.vc_pmem_wdata(l2_evict_wdata),
	.vc_pmem_rdata(l2_evict_rdata),
	.vc_pmem_resp(l2_evict_resp)
	/
	
	.vc_pmem_address(address),
	.vc_pmem_read(read),
	.vc_pmem_write(write),
	.vc_pmem_wdata(wdata),
	.vc_pmem_rdata(rdata),
	.vc_pmem_resp(resp)	
	
);
*/

	logic [31:0] L2_req_address;
	logic L2_req_read;
	logic L2_req_write;
	logic [255:0] L2_req_wdata;
	logic [255:0] L2_req_rdata;
	logic L2_req_resp;

	logic [31:0] evic_reg_address;
	logic evic_reg_read;
	logic evic_reg_write;
	logic [255:0] evic_reg_wdata;
	
eviction_write_buffer eviction_write_buffer_L2
(
	.clk,
	.address(l2_evict_address),
	.read(l2_evict_read),
	.write(l2_evict_write),
	.rdata(l2_evict_rdata),
	.wdata(l2_evict_wdata),
	.resp(l2_evict_resp),
	
	.pmem_address(evic_reg_address),
	.pmem_read(evic_reg_read),
	.pmem_write(evic_reg_write),
	.pmem_rdata(rdata),
	.pmem_wdata(evic_reg_wdata),
	.pmem_resp(resp)
	
	/*
	.pmem_address(L2_req_address),
	.pmem_read(L2_req_read),
	.pmem_write(L2_req_write),
	.pmem_rdata(L2_req_rdata),
	.pmem_wdata(L2_req_wdata),
	.pmem_resp(L2_req_resp)
  */

); 

	mem_access_regslice  #(.width(256), .custom_sig_width(1), .custom_sig_width_2(1)) evic_pmem_slice
	(
		 .clk,

		 //L2 cache signal
		 .L2cache_read(evic_reg_read),
		 .L2cache_write(evic_reg_write),
		 .L2cache_address(evic_reg_address),
		 .L2cache_wdata(evic_reg_wdata),
		 .custom_signal(),
		 .custom_signal_2(),

		 .L2cache_read_reg(read),
		 .L2cache_write_reg(write),
		 .L2cache_address_reg(address),
		 .L2cache_wdata_reg(wdata),
		 .L2cache_rdata(rdata),
		 .L2cache_resp(resp),   
		 .L2cache_byte_enable_reg(),
		 .L2cache_byte_enable()	
	);
	

endmodule : mp3
