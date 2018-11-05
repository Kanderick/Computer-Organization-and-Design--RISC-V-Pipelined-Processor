module mp3
(
	/*other signals*/
    input clk,
    /* Port A */
    output read,
    output write,
    output logic [3:0] wmask,
    output logic [31:0] address,
    output logic [31:0] wdata,
    input logic resp,
    input logic [31:0] rdata 
);

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

arbitor arbitor  
(
    .clk,
    // instruction cache signal
    .icache_read(read_a),
    .icache_address(address_a),
    .icache_rdata(rdata_a),
    .icache_resp(resp_a),
    
    // data cache signal
    .dcache_read(read_b),
    .dcache_write(write_b),    
    .dcache_address(address_b),
    .dcache_wdata(wdata_b),
    .dcache_byte_enable(wmask_b),
    .dcache_rdata(rdata_b),
    .dcache_resp(resp_b),

    //L2 cache signal
    .L2cache_read(read),
    .L2cache_write(write),
    .L2cache_address(address),
    .L2cache_wdata(wdata),
    .L2cache_byte_enable(wmask),
    .L2cache_rdata(rdata),
    .L2cache_resp(resp)        
);


endmodule : mp3