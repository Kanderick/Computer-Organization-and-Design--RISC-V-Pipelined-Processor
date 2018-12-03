module victim_cache_datapath 
(
	input clk,
	
	input [31:0] l2_vc_address,
	input [31:0] l2_vc_lru_address,
	input [255:0] l2_vc_wdata,
	output logic [255:0] l2_vc_rdata,
	
	output logic [31:0] vc_pmem_address,
	output logic [255:0] vc_pmem_wdata,
	input [255:0] vc_pmem_rdata,
	
	output logic hit,
	input update_victim,
	input rdata_sel
);

/*Internal Signals*/
	logic load0;
	logic load1;
	logic load2;
	logic load3;
	
	logic [255:0] dataout0;
	logic [255:0] dataout1;
	logic [255:0] dataout2;
	logic [255:0] dataout3;
	
	logic [26:0] tagout0;
	logic [26:0] tagout1;
	logic [26:0] tagout2;
	logic [26:0] tagout3;
	
	logic [3:0] hit_way;
	
	logic [1:0] new_access;
	logic [1:0] lru;
	
/*Assignments*/
assign vc_pmem_address = l2_vc_address;
assign vc_pmem_wdata = l2_vc_wdata;

/*module instantiations*/
register #(.width(256)) data0
(
	.clk,
	.load(load0),
	.in(l2_vc_wdata),
	.out(dataout0)
);

register #(.width(256)) data1
(
	.clk,
	.load(load1),
	.in(l2_vc_wdata),
	.out(dataout1)
);

register #(.width(256)) data2
(
	.clk,
	.load(load2),
	.in(l2_vc_wdata),
	.out(dataout2)
);

register #(.width(256)) data3
(
	.clk,
	.load(load3),
	.in(l2_vc_wdata),
	.out(dataout3)
);

register #(.width(27)) tag0
(
	.clk,
	.load(load0),
	.in(l2_vc_lru_address[31:5]),
	.out(tagout0)
);

register #(.width(27)) tag1
(
	.clk,
	.load(load1),
	.in(l2_vc_lru_address[31:5]),
	.out(tagout1)
);

register #(.width(27)) tag2
(
	.clk,
	.load(load2),
	.in(l2_vc_lru_address[31:5]),
	.out(tagout2)
);

register #(.width(27)) tag3
(
	.clk,
	.load(load3),
	.in(l2_vc_lru_address[31:5]),
	.out(tagout3)
);

victim_cache_tag_comparator victim_cache_tag_comparator
(
	.l2_vc_address,
	.tag0(tagout0),
	.tag1(tagout1),
	.tag2(tagout2),
	.tag3(tagout3),
	.hit,
	.hit_way
);

victim_cache_lru_unit victim_cache_lru_unit
(
	.clk,
	.load_lru(update_victim),
	.new_access,
	.lru
);

victim_cache_victim_update_logic victim_cache_victim_update_logic
(
	.*
);

victim_cache_rdata_logic victim_cache_rdata_logic
(
	.data0(dataout0),
	.data1(dataout1),
	.data2(dataout2),
	.data3(dataout3),
	.*
);

endmodule	: victim_cache_datapath