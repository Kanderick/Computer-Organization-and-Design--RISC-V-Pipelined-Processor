module L2cache_datapath #(parameter set_bits = 5, parameter way_bits = 2)
(
// cache interface
    input clk,
    input logic [31:0] mem_address,
    input logic [255:0] mem_wdata,
    output logic [255:0] mem_rdata,
 // physical memory interface
    output logic [31:0]  pmem_address,
    output logic [255:0]  pmem_wdata,
    input logic [255:0] pmem_rdata,
	 output logic [31:0] write_back_addr,
 //control signal
    input way_sel_method,
    input load_line_data,
    input load_valid,
    input load_wdata_reg,
    input load_dirty,
    input load_LRU,
    input line_datain_sel,
    input valid_in,
    input dirty_in,
    input address_sel,
    output logic dirty,
    output logic hit,
    output logic valid
);
localparam tag_bits = 32 - 5 - set_bits;
localparam num_sets = 1 << set_bits;
localparam num_ways = 1 << way_bits;
// parse address
logic [tag_bits-1:0] tag;
assign tag = mem_address[31:31-(tag_bits-1)];
logic [set_bits-1:0] idx;
assign idx = mem_address[5+set_bits-1:5];

genvar j;
//logic [31:0] write_back_addr;

mux2 #(.width(32)) addr_mux
(
.sel(address_sel),
.a({mem_address[31:5],5'b0}),
.b(write_back_addr),
.f(pmem_address)
);


logic [255:0] wdata_reg_out;
logic [255:0] LRU_line;

register #(.width(256)) wdata_reg
(
    .clk,
    .load(load_wdata_reg),
    .in(LRU_line),
    .out(wdata_reg_out)
);

assign pmem_wdata = wdata_reg_out;

//line data selection
logic [255:0] line_datain;
logic [255:0] modified_line; //modified by wdata
assign modified_line = mem_wdata;

mux2 #(.width(256)) line_data_in
(
    .sel(line_datain_sel),
    .a(pmem_rdata),
    .b(modified_line),
    .f(line_datain)
);
// data array
logic load_data_way[num_ways];
logic [255:0] datain;
logic [255:0] dataout_way[num_ways];
//tag array
logic [tag_bits-1:0] tagout_way[num_ways];
//valid bit array
logic load_valid_way[num_ways];
logic validout_way[num_ways];
//dirty bit array
logic load_dirty_way[num_ways];
logic dirtyout_way[num_ways];
generate 
	for (j = 0; j < num_ways; j = j+1) begin: generate_arrays
		array #(.width(256), .idx_bits(set_bits)) data_array
		(
			 .clk,
			 .write(load_data_way[j]),
			 .index(idx),
			 .datain(line_datain),
			 .dataout(dataout_way[j])
		);
		
		 array #(.width(tag_bits), .idx_bits(set_bits)) tag_array
		(
			 .clk,
			 .write(load_data_way[j]),
			 .index(idx),
			 .datain(tag),
			 .dataout(tagout_way[j])
		);
		
		 array #(.width(1), .idx_bits(set_bits)) valid_array
		(
			 .clk,
			 .write(load_valid_way[j]),
			 .index(idx),
			 .datain(valid_in),
			 .dataout(validout_way[j])
		);
		 array #(.width(1), .idx_bits(set_bits)) dirty_array
		(
			 .clk,
			 .write(load_dirty_way[j]),
			 .index(idx),
			 .datain(dirty_in),
			 .dataout(dirtyout_way[j])
		);
	end
endgenerate


//comparater
logic [way_bits-1:0] hit_idx;
always_comb begin
	hit = 0;
	hit_idx = 0;
	for (int i = 0; i < num_ways; i = i + 1) begin
		if(tag == tagout_way[i] && validout_way[i]== 1) begin
			hit_idx = i[way_bits-1:0];
			hit = 1;
		end	
	end
end
//select line
logic [255:0] selected_line;
logic [way_bits-1:0]way_select;
assign mem_rdata = selected_line;
logic [way_bits-1:0] LRUout;

//assign selected_line = dataout_way[way_select];
assign selected_line = dataout_way[hit_idx];
assign LRU_line = dataout_way[LRUout];

//LRU bit array
/*
 array #(.width(1)) LRU_array 
(
    .clk,
    .write(load_LRU),
    .index(idx),
    .datain(!way_select),
    .dataout(LRUout)
);
*/

logic [way_bits-1:0] lru_out_arr[num_sets];
generate 
	for (j = 0; j < num_sets; j++) begin : generate_lru_arrays
		pseudo_lru #(.bits(way_bits)) pseudo_lru
		(
			.clk,
			.load_lru(load_LRU),
			.new_access(way_select),
			.lru(lru_out_arr[j])
		);
	end
endgenerate
assign LRUout = lru_out_arr[idx];


mux2 #(.width(way_bits)) selection_method
(
    .sel(way_sel_method),
    .a(hit_idx),
    .b(LRUout),
    .f(way_select)
);

// load signals

always_comb begin
	for (int i = 0; i < num_ways; i = i + 1) begin
		load_valid_way[i] = 0;
		load_data_way[i] = 0;
		load_dirty_way[i] = 0;
		if (way_select == i) begin
			if (load_valid) 
				load_valid_way[i] = 1;
			if(load_line_data)	
				load_data_way[i] = 1;
			if(load_dirty)	
				load_dirty_way[i] = 1;
		end
	end
end


assign valid = validout_way[way_select];
assign dirty = dirtyout_way[LRUout];

//address for write_back
logic [tag_bits-1:0] tag_selected;
assign tag_selected = tagout_way[way_select];

//localparam zeros = 32-tag_bits-set_bits;
assign write_back_addr = {tag_selected,idx,{(32-tag_bits-set_bits){1'b0}}};
endmodule
