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

//input of cache from arbitor
logic read_I, read_D;
logic write_I, write_D;
//logic [3:0] wmask_D;
logic [31:0] address_I, address_D;
logic [255:0] wdata_D;
logic resp_I, resp_D;
logic [255:0] rdata_I, rdata_D;
    
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
    .rdata_b
);

L1Icache instruction_cache
(
	.clk,
	.cpu_l1i_address(address_a),
	.cpu_l1i_rdata(rdata_a),
	.cpu_l1i_read(read_a),
	.cpu_l1i_resp(resp_a),
	
	.l1i_arbi_address(address_I),
	.l1i_arbi_rdata(rdata_I),
	.l1i_arbi_read(read_I),
	.l1i_arbi_resp(resp_I)
);

L1Dcache data_cache
(
	.clk,
    .cpu_l1d_address(address_b),
	.cpu_l1d_wdata(wdata_b),
	.cpu_l1d_read(read_b),
	.cpu_l1d_write(write_b),
	.cpu_l1d_byte_enable(wmask_b),
	
	.l1d_arbi_rdata(rdata_D),
	.l1d_arbi_resp(resp_D),
	.cpu_l1d_rdata(rdata_b),
	.cpu_l1d_resp(resp_b),
	.l1d_arbi_address(address_D),
	.l1d_arbi_wdata(wdata_D),
	.l1d_arbi_read(read_D),
	.l1d_arbi_write(write_D)
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
    .L2cache_read(read),
    .L2cache_write(write),
    .L2cache_address(address),
    .L2cache_wdata(wdata),
    .L2cache_byte_enable(),
    .L2cache_rdata(rdata),
    .L2cache_resp(resp)        
);


endmodule : mp3