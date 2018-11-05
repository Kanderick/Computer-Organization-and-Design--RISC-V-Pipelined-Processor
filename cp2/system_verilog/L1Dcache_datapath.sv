module L1Dcache_datapath
(
	input clk,
	
	input [31:0] mem_address,
	input [31:0] mem_wdata,
	input [3:0] mem_byte_enable,
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
	
	output logic [31:0] mem_rdata,
	output logic [31:0] pmem_address,
	output logic [255:0] pmem_wdata,
	
	/*output to cache_control*/
	output logic hit,
	output logic dirty
);

/*Internal Signals*/

	logic signal_high;
	
	logic [4:0] index;
	logic [2:0] set;
	logic [23:0] tag;
	
	logic tag_load_0;
	logic tag_load_1;
	logic [23:0] tag_0;
	logic [23:0] tag_1;
	
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
	logic [255:0] data_cache;

	/* New data arrays*/
	logic [7:0] datamux0 [32];
	logic [7:0] datamux1 [32];
	logic [7:0] data0 [32];
	logic [7:0] data1 [32];
	logic [31:0] data_read0;
	logic [31:0] data_read1;
	logic [7:0] data_in0 [32];
	logic [7:0] data_in1 [32];
	
	
/*Assignments*/
	assign signal_high = 1'b1;
	assign lru_datain = ! cmp_rst;
	
	

/*module instantiation*/
cache_address_decoder cache_address_decoder
(
	.*
);

pmem_address_logic pmem_address_logic
(
	.*
);

array #(.width(24)) tag_array0
(
	.clk,
	.write(tag_load_0),
	.index(set),
	.datain(tag),
	.dataout(tag_0)
);

array #(.width(24)) tag_array1
(
	.clk,
	.write(tag_load_1),
	.index(set),
	.datain(tag),
	.dataout(tag_1)
);

array #(.width(1)) lru_array
(
	.clk,
	.write(load_lru),
	.index(set),
	.datain(lru_datain),
	.dataout(lru)
);

array #(.width(1)) dirty_array0
(
	.clk,
	.write(dirty_load_0),
	.index(set),
	.datain(dirty_data),
	.dataout(dirty_0)
);

array #(.width(1)) dirty_array1
(
	.clk,
	.write(dirty_load_1),
	.index(set),
	.datain(dirty_data),
	.dataout(dirty_1)
);

array #(.width(1)) valid_array0
(
	.clk,
	.write(valid_load_0),
	.index(set),
	.datain(signal_high),
	.dataout(valid_0)
);

array #(.width(1)) valid_array1
(
	.clk,
	.write(valid_load_1),
	.index(set),
	.datain(signal_high),
	.dataout(valid_1)
);

//array #(.width(256)) data_array0
//(
//	.clk,
//	.write(data_load_0),
//	.index(set),
//	.datain(data_datain),
//	.dataout(data_0)
//);
//
//array #(.width(256)) data_array1
//(
//	.clk,
//	.write(data_load_1),
//	.index(set),
//	.datain(data_datain),
//	.dataout(data_1)
//);

genvar i;
genvar j;

generate
    for (i=0; i<=31; i=i+1) begin : generate_data_array0
    array #(.width(8)) data_array0 (
        .clk(clk),
        .write(data_load_0),
        .index(set),
        .datain(datamux0[i]),
        .dataout(data0[i])
    );
end 
endgenerate

generate
    for (j=0; j<=31; j=j+1) begin : generate_data_array1
    array #(.width(8)) data_array1 (
        .clk(clk),
        .write(data_load_1),
        .index(set),
        .datain(datamux1[j]),
        .dataout(data1[j])
    );
end 
endgenerate

generate
    for (i=0; i<=31; i=i+1) begin : generate_datain_mux0
    mux2 #(.width(8)) datain_mux0 (
        .sel(data_in_sel),
		  .a(pmem_rdata[8*i+7: 8*i]),
		  .b(data_in0[i]),
		  .f(datamux0[i])
    );
end 
endgenerate

generate
    for (j=0; j<=31; j=j+1) begin : generate_datain_mux1
    mux2 #(.width(8)) datain_mux1 (
        .sel(data_in_sel),
		  .a(pmem_rdata[8*j+7: 8*j]),
		  .b(data_in1[j]),
		  .f(datamux1[j])
    );
end 
endgenerate

L1Dcache_write_data_assembler L1Dcache_write_data_assembler
(
	.*
);

L1Dcache_data_assembler L1Dcache_data_assembler0
(
	.datain(data0),
	.index,
	.dataout(data_read0)
);

L1Dcache_data_assembler L1Dcache_data_assembler1
(
	.datain(data1),
	.index,
	.dataout(data_read1)
);

mux2 #(.width(256)) eviction_mux
(
	.sel(lru),
	.a({data0[31], data0[30], data0[29], data0[28], data0[27], data0[26], data0[25], data0[24], data0[23], data0[22], data0[21], data0[20], data0[19], data0[18], data0[17], data0[16], data0[15], data0[14], data0[13], data0[12], data0[11], data0[10], data0[9], data0[8], data0[7], data0[6], data0[5], data0[4], data0[3], data0[2], data0[1], data0[0]}),
	.b({data1[31], data1[30], data1[29], data1[28], data1[27], data1[26], data1[25], data1[24], data1[23], data1[22], data1[21], data1[20], data1[19], data1[18], data1[17], data1[16], data1[15], data1[14], data1[13], data1[12], data1[11], data1[10], data1[9], data1[8], data1[7], data1[6], data1[5], data1[4], data1[3], data1[2], data1[1], data1[0]}),
	.f(pmem_wdata)
);

mux2 #(.width(32)) dataout_mux
(
	.sel(cmp_rst),
	.a(data_read0),
	.b(data_read1),
	.f(mem_rdata)
);

tag_comparator tag_comparator
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

tag_load_logic tag_load_logic
(
	.*
);

dirty_load_logic dirty_load_logic
(
	.*
);

valid_load_logic valid_load_logic
(
	.*
);

data_load_logic data_load_logic
(
	.*
);

endmodule : L1Dcache_datapath