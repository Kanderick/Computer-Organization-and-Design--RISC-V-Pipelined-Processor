module cache_datapath
(
	/*control signals*/
	input load_tag,
	input [1:0] load_data_select,
	input pmem_addr_select,
	input set_LRU,
	input clr_dirty,
	input set_dirty,
	input set_valid,
	input data_write_select,
	output logic hit,
	output logic dirty,
	/*cpu_signals*/
	input [31:0] mem_address,
	input [31:0] mem_wdata,
	input [3:0]  mem_byte_enable,
	output logic [31:0] mem_rdata, 
	/*pmem_signals*/
	input [255:0] pmem_rdata,
	output logic [255:0] pmem_wdata,
	output logic [31:0] pmem_addr,
	/*other signals*/
	input clk
);
/*common logics*/
logic [2:0] offset;
logic [1:0] byte_offset;
logic [2:0] set;
logic LRU;
logic hitway;
assign offset = mem_address[4:2];
assign set = mem_address[7:5];
assign byte_offset = mem_address[1:0];

logic load_data_1;
logic load_data_2;
logic [255:0] datain;
logic [255:0] data_1_out;
logic [255:0] data_2_out;
logic [255:0] mem_wdata_out;

logic load_tag_1;
logic load_tag_2;
logic [23:0] tag_1_out;
logic [23:0] tag_2_out;

logic load_valid_1;
logic load_valid_2;
logic valid_1_in;
logic valid_2_in;
logic valid_1_out;
logic valid_2_out;
assign valid_1_in=1'b1;
assign valid_2_in=1'b1;


logic load_dirty_1;
logic load_dirty_2;
logic dirty_1_in;
logic dirty_2_in;
logic dirty_1_out;
logic dirty_2_out;

/*data arrays*/

array #(.width(256)) data_array0
(
	.clk,
	.write(load_data_1),
	.index(set),
	.datain,
	.dataout(data_1_out)
);

array #(.width(256)) data_array1
(
	.clk,
	.write(load_data_2),
	.index(set),
	.datain,
	.dataout(data_2_out)

);

mux2 #(.width(256)) datain_mux
(
	.a(mem_wdata_out),
	.b(pmem_rdata),
	.sel(data_write_select),
	.f(datain)
);

datain_logic datain_logic
(
	.hit_way(hitway),
	.mem_wdata,
	.mem_byte_enable,
	.offset,
	.byte_offset,
	.data_1(data_1_out),
	.data_2(data_2_out),
	.mem_wdata_out
);

data_load_logic data_load_logic
(
	.LRU,
	.hitway,
	.load_data_select,
	.load_1(load_data_1),
	.load_2(load_data_2)
);

mux2 #(.width(256)) pmem_wdata_mux
(
	.a(data_1_out),
	.b(data_2_out),
	.sel(LRU),
	.f(pmem_wdata)
);

mem_data_convertor mem_data_convertor
(
	.data_1(data_1_out),
	.data_2(data_2_out),
	.hit_way(hitway),
	.byte_offset,
	.offset,
	.mem_rdata
);



/*tag arrays*/
array #(.width(24)) tag_array0
(
	.clk,
	.write(load_tag_1),
	.index(set),
	.datain(mem_address[31:8]),
	.dataout(tag_1_out)
);

array #(.width(24)) tag_array1
(
	.clk,
	.write(load_tag_2),
	.index(set),
	.datain(mem_address[31:8]),
	.dataout(tag_2_out)
);

simple_load_logic tag_load_logic
(
	.LRU,
	.load(load_tag),
	.load_1(load_tag_1),
	.load_2(load_tag_2)
);



/*valid arrays*/
array #(.width(1)) valid_array_1
(
	.clk,
	.write(load_valid_1),
	.index(set),
	.datain(valid_1_in),
	.dataout(valid_1_out)
);

array #(.width(1)) valid_array_2
(
	.clk,
	.write(load_valid_2),
	.index(set),
	.datain(valid_2_in),
	.dataout(valid_2_out)
);

simple_load_logic valid_load_logic
(
	.LRU,
	.load(set_valid),
	.load_1(load_valid_1),
	.load_2(load_valid_2)
);



/*dirty arrays*/
array #(.width(1)) dirty_array_1
(
	.clk,
	.write(load_dirty_1),
	.index(set),
	.datain(dirty_1_in),
	.dataout(dirty_1_out)
);

array #(.width(1)) dirty_array_2
(
	.clk,
	.write(load_dirty_2),
	.index(set),
	.datain(dirty_2_in),
	.dataout(dirty_2_out)
);

dirty_load_logic dirty_load_logic
(
	.LRU,
	.clr_dirty,
	.hitway,
	.set_dirty,
	.in_1(dirty_1_in),
	.in_2(dirty_2_in),
	.load_1(load_dirty_1),
	.load_2(load_dirty_2)
);

mux2 #(.width(1)) dirty_mux
(
	.a(dirty_1_out),
	.b(dirty_2_out),
	.sel(LRU),
	.f(dirty)
);


/*LRU array*/
array #(.width(1)) LRU_array
(
	.clk,
	.write(set_LRU),
	.index(set),
	.datain(~hitway),
	.dataout(LRU)
);

/*hit_checker*/
hit_checker hit_checker
(
	.tag_1_out,
	.tag_2_out,
	.valid_1_out,
	.valid_2_out,
	.mem_addr(mem_address),
	.hit,
	.hit_way(hitway)
);

/*pmem_addr_logic*/
pmem_addr_logic pmem_addr_logic
(
	.mem_address,
	.LRU,
	.set,
	.tag_1(tag_1_out),
	.tag_2(tag_2_out),
	.pmem_addr_select,
	.pmem_addr
);


endmodule : cache_datapath
