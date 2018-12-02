module L1Icache_datapath
(
	input clk,
	
	input [31:0] cpu_l1i_address,
	output logic [31:0] cpu_l1i_rdata,
	
	output logic [31:0] l1i_arbi_address,
	input [255:0] l1i_arbi_rdata,
	
	/*From and to L1Icache_control*/
	input ld_tag,
	input ld_lru,
	input ld_valid,
	input ld_data,
	
	output logic hit
);

/*Internal Signals*/
	logic [4:0] index;
	logic [2:0] set;
	logic [23:0] tag;
	
	logic signal_high;
	logic lru_datain;
	logic cmp_rst;
	logic ld_tag0;
	logic [23:0] tag0;
	logic ld_tag1;
	logic [23:0] tag1;
	logic lru;
	logic ld_valid0;
	logic valid0;
	logic ld_valid1;
	logic valid1;
	
	logic ld_data0;
	logic ld_data1;
	logic [7:0] data0 [32];
	logic [7:0] data1 [32];
	
	logic [31:0] data_way0;
	logic [31:0] data_way1;
	
/*Assignments*/
	assign signal_high = 1'b1;
	assign lru_datain = ! cmp_rst;
	assign l1i_arbi_address = cpu_l1i_address;

L1Icache_address_decoder L1Icache_address_decoder
(
	.*
);

L1Icache_tag_comparator L1Icache_tag_comparator
(
	.*
);

L1Icache_data_assembler L1Icache_data_assembler0
(
	.datain(data0),
	.index(index),
	.dataout(data_way0)
);

L1Icache_data_assembler L1Icache_data_assembler1
(
	.datain(data1),
	.index(index),
	.dataout(data_way1)
);

mux2 #(.width(32)) dataout_mux
(
	.sel(cmp_rst),
	.a(data_way0),
	.b(data_way1),
	.f(cpu_l1i_rdata)
);

L1Icache_array_load_logic L1Icache_array_load_logic
(
	.*
);

array #(.width(24)) tag_array0
(
	.clk,
	.write(ld_tag0),
	.index(set),
	.datain(tag),
	.dataout(tag0)
);

array #(.width(24)) tag_array1
(
	.clk,
	.write(ld_tag1),
	.index(set),
	.datain(tag),
	.dataout(tag1)
);

array #(.width(1)) lru_array
(
	.clk,
	.write(ld_lru),
	.index(set),
	.datain(lru_datain),
	.dataout(lru)
);

array #(.width(1)) valid_array0
(
	.clk,
	.write(ld_valid0),
	.index(set),
	.datain(signal_high),
	.dataout(valid0)
);

array #(.width(1)) valid_array1
(
	.clk,
	.write(ld_valid1),
	.index(set),
	.datain(signal_high),
	.dataout(valid1)
);

genvar i;
generate
    for (i=0; i<=31; i=i+1) begin : generate_block_identifier1
    array #(.width(8)) data_array0 (
        .clk(clk),
        .write(ld_data0),
        .index(set),
        .datain(l1i_arbi_rdata[8*i+7: 8*i]),
        .dataout(data0[i])
    );
end 
endgenerate

genvar j;
generate
    for (j=0; j<=31; j=j+1) begin : generate_block_identifier2
    array #(.width(8)) data_array1 (
        .clk(clk),
        .write(ld_data1),
        .index(set),
        .datain(l1i_arbi_rdata[8*j+7: 8*j]),
        .dataout(data1[j])
    );
end 
endgenerate

endmodule	: L1Icache_datapath