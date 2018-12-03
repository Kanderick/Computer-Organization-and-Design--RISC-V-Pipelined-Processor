module L2cache_datapath
(
	input clk,
	
	input [31:0] mem_address,
	input [255:0] mem_wdata,
	input [255:0] pmem_rdata,
	
	/*input from cache_control*/
	input pmem_addr_sel,
	input load_lru,
	input load_tag,
	input load_data,
	input load_valid,
	input data_in_sel,
	input set_dirty,
	input clr_dirty,
	
	output logic [255:0] mem_rdata,
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,
	
	/*output to cache_control*/
	output logic hit,
	output logic dirty
);

/*Internal Signals*/

	logic signal_high;
	
	logic [4:0] index;
	logic [3:0] set;
	logic [22:0] tag;
	
	logic tag_load_0;
	logic tag_load_1;
	logic [22:0] tag_0;
	logic [22:0] tag_1;
	
	logic lru_datain;
	logic lru;
	
	logic dirty_load_0;
	logic dirty_load_1;
	logic dirty_data;
	logic dirty_0;
	logic dirty_1;
	
	logic valid_load_0;
	logic valid_load_1;
	logic valid_0;
	logic valid_1;
	
	logic data_load_0;
	logic data_load_1;
	logic [255:0] data_datain;
	logic [255:0] data_0;
	logic [255:0] data_1;
	
	logic cmp_rst;
	
	logic data_sel;
	logic [255:0] data_out;

/*Assignments*/
	assign signal_high = 1'b1;
	assign lru_datain = ! cmp_rst;
	assign pmem_wdata = data_out;
	assign mem_rdata = data_out;
	

/*module instantiation*/
L2cache_address_decoder cache_address_decoder
(
	.*
);

L2cache_pmem_address_logic pmem_address_logic
(
	.*
);

array_16 #(.width(23)) tag_array0
(
	.clk,
	.write(tag_load_0),
	.index(set),
	.datain(tag),
	.dataout(tag_0)
);

array_16 #(.width(23)) tag_array1
(
	.clk,
	.write(tag_load_1),
	.index(set),
	.datain(tag),
	.dataout(tag_1)
);

array_16 #(.width(1)) lru_array
(
	.clk,
	.write(load_lru),
	.index(set),
	.datain(lru_datain),
	.dataout(lru)
);

dirty_array_16 #(.width(1)) dirty_array0
(
	.clk,
	.write(dirty_load_0),
	.index(set),
	.datain(dirty_data),
	.dataout(dirty_0)
);

dirty_array_16 #(.width(1)) dirty_array1
(
	.clk,
	.write(dirty_load_1),
	.index(set),
	.datain(dirty_data),
	.dataout(dirty_1)
);

array_16 #(.width(1)) valid_array0
(
	.clk,
	.write(valid_load_0),
	.index(set),
	.datain(signal_high),
	.dataout(valid_0)
);

array_16 #(.width(1)) valid_array1
(
	.clk,
	.write(valid_load_1),
	.index(set),
	.datain(signal_high),
	.dataout(valid_1)
);

array_16 #(.width(256)) data_array0
(
	.clk,
	.write(data_load_0),
	.index(set),
	.datain(data_datain),
	.dataout(data_0)
);

array_16 #(.width(256)) data_array1
(
	.clk,
	.write(data_load_1),
	.index(set),
	.datain(data_datain),
	.dataout(data_1)
);

L2cache_tag_comparator tag_comparator
(
	.*
);

mux2 #(.width(1)) dirtyout_mux
(
	.sel(lru),
	.a(dirty_0),
	.b(dirty_1),
	.f(dirty)
);

mux2 #(.width(1)) datasel_mux
(
	.sel(hit),
	.a(lru),
	.b(cmp_rst),
	.f(data_sel)
);

mux2 #(.width(256)) datain_mux
(
	.sel(data_in_sel),
	.a(pmem_rdata),
	.b(mem_wdata),
	.f(data_datain)
);

mux2 #(.width(256)) dataout_mux
(
	.sel(data_sel),
	.a(data_0),
	.b(data_1),
	.f(data_out)
);

L2cache_tag_load_logic tag_load_logic
(
	.*
);

L2cache_dirty_load_logic dirty_load_logic
(
	.*
);

L2cache_valid_load_logic valid_load_logic
(
	.*
);

L2cache_data_load_logic data_load_logic
(
	.*
);

endmodule : L2cache_datapath