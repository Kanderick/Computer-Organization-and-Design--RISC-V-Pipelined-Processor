module icache_datapath #(set_bits = 3)
(
// cache interface
    input clk,
    input logic [3:0] mem_byte_enable,
    input logic [31:0] mem_address,
    //input logic [31:0] mem_wdata,
    output logic [31:0] mem_rdata,
 // physical memory interface
    output logic [31:0]  pmem_address,
    //output logic [255:0]  pmem_wdata,
    input logic [255:0] pmem_rdata,
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
	 input rdata_sel,
    output logic dirty,
    output logic hit,
    output logic valid
);
// parse address
logic [23:0] tag;
assign tag = mem_address[31:8];
logic [2:0] idx;
assign idx = mem_address[7:5];
logic [2:0] offset;
assign offset = mem_address[4:2];
/*
logic [1:0] alignment;
assign alignment = mem_address[1:0];
*/

// pmem signals
assign pmem_address[31:5] = mem_address[31:5];
assign pmem_address[4:0] = 5'b0;
/*
logic [31:0] write_back_addr;

mux2 #(.width(32)) addr_mux
(
.sel(address_sel),
.a({mem_address[31:5],5'b0}),
.b(write_back_addr),
.f(pmem_address)
);
*/

genvar j;
/*
logic [7:0] wdata_reg_out[32];
logic [7:0] LRU_line [32];
generate  
	for (j = 0; j < 32; j = j + 1) begin : generate_wdata_reg
		register #(.width(8)) wdata_reg
		(
			 .clk,
			 .load(load_wdata_reg),
			 .in(LRU_line[j]),
			 .out(wdata_reg_out[j])
		);
	end
endgenerate

always_comb begin
	for (int i = 0; i < 32; i = i + 1) 
		 pmem_wdata[i*8+:8] = wdata_reg_out[i];
end
*/
//line data selection
/*
logic [7:0] line_datain[32];
logic [7:0] modified_line[32]; //modified by wdata

generate  
	for (j = 0; j < 32; j = j + 1) begin : generate_line_datain
		mux2 #(.width(8)) line_data_in
		(
			 .sel(line_datain_sel),
			 .a(pmem_rdata[j*8+:8]),
			 .b(modified_line[j]),
			 .f(line_datain[j])
		);
	end
endgenerate
*/
// data array
logic load_data_way0, load_data_way1;
logic [7:0] dataout_way0 [32];
logic [7:0] dataout_way1 [32];
generate  
	for (j = 0; j < 32; j++) begin : generate_dataarray
		array #(.width(8), .idx_bits(set_bits)) data_array0
		(
		 .clk,
		 .write(load_data_way0),
		 .index(idx),
		 .datain(pmem_rdata[j*8+:8]),
		 .dataout(dataout_way0[j])
		);
		
		array #(.width(8), .idx_bits(set_bits)) data_array1
		(
		 .clk,
		 .write(load_data_way1),
		 .index(idx),
		 .datain(pmem_rdata[j*8+:8]),
		 .dataout(dataout_way1[j])
		);
	end
endgenerate
//tag array
logic [23:0] tagout_way0, tagout_way1;
 array #(.width(24)) tag_array0
(
    .clk,
    .write(load_data_way0),
    .index(idx),
    .datain(tag),
    .dataout(tagout_way0)
);
array #(.width(24)) tag_array1
(
    .clk,
    .write(load_data_way1),
    .index(idx),
    .datain(tag),
    .dataout(tagout_way1)
);

//valid bit array
logic load_valid_way0, load_valid_way1;
logic validout_way0, validout_way1;
 array #(.width(1)) valid_array0
(
    .clk,
    .write(load_valid_way0),
    .index(idx),
    .datain(valid_in),
    .dataout(validout_way0)
);
array #(.width(1)) valid_array1
(
    .clk,
    .write(load_valid_way1),
    .index(idx),
    .datain(valid_in),
    .dataout(validout_way1)
);
//dirty bit array
logic load_dirty_way0, load_dirty_way1;
logic dirtyout_way0, dirtyout_way1;
 array #(.width(1)) dirty_array0
(
    .clk,
    .write(load_dirty_way0),
    .index(idx),
    .datain(dirty_in),
    .dataout(dirtyout_way0)
);
array #(.width(1)) dirty_array1
(
    .clk,
    .write(load_dirty_way1),
    .index(idx),
    .datain(dirty_in),
    .dataout(dirtyout_way1)
);

//comparater
logic hit0, hit1;
assign hit0 = (tag == tagout_way0 && validout_way0 == 1);
assign hit1 = (tag == tagout_way1 && validout_way1 == 1);
assign hit = hit0 || hit1 ;

//select line
//logic [7:0] selected_line[32], selected_line[32];
logic way_select;
/*
generate  
	for (j = 0; j < 32; j++) begin  : generate_selected_line
		mux2 #(.width(8)) line_select
		(
			 .sel(way_select),
			 .a(dataout_way0[j]),
			 .b(dataout_way1[j]),
			 .f(selected_line[j])
		);
	end
endgenerate	
*/
logic LRUout;
/*
generate  
	for (j = 0; j < 32; j = j + 1) begin : generate_LRU_line
		mux2 #(.width(8)) LRU_line_preload
		(
			 .sel(LRUout),
			 .a(dataout_way0[j]),
			 .b(dataout_way1[j]),
			 .f(LRU_line[j])
		);
	end
endgenerate
*/
//LRU bit array
 array #(.width(1)) LRU_array 
(
    .clk,
    .write(load_LRU),
    .index(idx),
    .datain(!way_select),
    .dataout(LRUout)
);

mux2 #(.width(1)) selection_method
(
    .sel(way_sel_method),
    .a(hit1&&validout_way1),
    .b(LRUout),
    .f(way_select)
);



// select word
logic [7:0] selected_word0[4];
logic [7:0] selected_word1[4];
logic [7:0] selected_word[4] ;
generate  
	for (j = 0; j < 4; j = j + 1) begin : generate_selected_word0
		mux8 #(.width(8)) word_select
		(
		.sel(offset),
		.a(dataout_way0[j+0]),
		.b(dataout_way0[j+4]),
		.c(dataout_way0[j+8]),
		.d(dataout_way0[j+12]),
		.e(dataout_way0[j+16]),
		.f(dataout_way0[j+20]),
		.g(dataout_way0[j+24]),
		.h(dataout_way0[j+28]),
		.o(selected_word0[j])
		);
	end
endgenerate
generate  
	for (j = 0; j < 4; j = j + 1) begin : generate_selected_word1
		mux8 #(.width(8)) word_select
		(
		.sel(offset),
		.a(dataout_way1[j+0]),
		.b(dataout_way1[j+4]),
		.c(dataout_way1[j+8]),
		.d(dataout_way1[j+12]),
		.e(dataout_way1[j+16]),
		.f(dataout_way1[j+20]),
		.g(dataout_way1[j+24]),
		.h(dataout_way1[j+28]),
		.o(selected_word1[j])
		);
	end
endgenerate

always_comb begin
	for (int i = 0; i<4 ; i = i+1) begin
		selected_word[i] = (way_select == 0)? selected_word0[i]:selected_word1[i];
	end
end 

assign mem_rdata = {selected_word[3],selected_word[2],selected_word[1],selected_word[0]};

// modified cache line
/*
logic [7:0] modified_word[4];
misaligned_write_8 construxt_new_word(
	.byte_0(selected_word[0]),
	.byte_1(selected_word[1]),
	.byte_2(selected_word[2]),
	.byte_3(selected_word[3]),
    .write_word(mem_wdata),
    .alignment,
    .mem_byte_enable,
	 .modified_out0(modified_word[0]),
	 .modified_out1(modified_word[1]),
	 .modified_out2(modified_word[2]),
	 .modified_out3(modified_word[3])
);
*/
/*
always_comb begin
    for ( int i = 0; i < 32; i = i + 1) begin
        modified_line[i] = (i/4 == offset)? modified_word[i%4]:selected_line[i];
    end    
end
*/
// load signals
decoder2 load_valid_bit
(
    .i0(way_select),
    .o0(load_valid_way0),
    .o1(load_valid_way1),
    .en(load_valid)
);
decoder2 load_data_signal
(
    .i0(way_select),
    .o0(load_data_way0),
    .o1(load_data_way1),
    .en(load_line_data)
);

decoder2 load_dirty_bit
(
    .i0(way_select),
    .o0(load_dirty_way0),
    .o1(load_dirty_way1),
    .en(load_dirty)
);
// output signal to control
mux2 #(.width(1)) to_control_valid
(
    .sel(way_select),
    .a(validout_way0),
    .b(validout_way1),
    .f(valid)
);

mux2 #(.width(1)) to_control_dirty
(
    .sel(LRUout),
    .a(dirtyout_way0),
    .b(dirtyout_way1),
    .f(dirty)
);

//address for write_back
logic [23:0] tag_selected;
mux2 #(.width(24)) tag_for_write_back
(
    .sel(way_select),
    .a(tagout_way0),
    .b(tagout_way1),
    .f(tag_selected)
);
//assign write_back_addr = {tag_selected,idx,5'b0};
endmodule
