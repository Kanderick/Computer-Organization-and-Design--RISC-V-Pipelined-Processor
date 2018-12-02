module L2cache_datapath
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
// parse address
logic [23:0] tag;
assign tag = mem_address[31:8];
logic [2:0] idx;
assign idx = mem_address[7:5];
//logic [2:0] offset;
//assign offset = mem_address[4:2];
//logic [1:0] alignment;
//assign alignment = mem_address[1:0];

// pmem signals
//assign pmem_address[31:5] = mem_address[31:5];
//assign pmem_address[4:0] = 5'b0;
logic [31:0] write_back_addr;

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
logic load_data_way0, load_data_way1;
logic [255:0] datain;
logic [255:0] dataout_way0, dataout_way1;
array #(.width(256)) data_array0
(
    .clk,
    .write(load_data_way0),
    .index(idx),
    .datain(line_datain),
    .dataout(dataout_way0)
);
array #(.width(256)) data_array1
(
    .clk,
    .write(load_data_way1),
    .index(idx),
    .datain(line_datain),
    .dataout(dataout_way1)
);

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
assign hit0 = (tag == tagout_way0);
assign hit1 = (tag == tagout_way1);
assign hit = hit0 || hit1 ;

//select line
logic [255:0] selected_line;
logic way_select;
assign mem_rdata = selected_line;

mux2 #(.width(256)) line_select
(
    .sel(way_select),
    .a(dataout_way0),
    .b(dataout_way1),
    .f(selected_line)
);

logic LRUout;
mux2 #(.width(256)) LRU_line_preload
(
    .sel(LRUout),
    .a(dataout_way0),
    .b(dataout_way1),
    .f(LRU_line)
);


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


/*
//unpack cache line
logic [31:0] unpacked_32[8];
int i;
always_comb begin
    for (i = 0; i < 8; i = i + 1) begin
        unpacked_32[i] = selected_line[32*i+:32];
    end    
end
// select word
logic [31:0] selected_word;
mux8 #(.width(32)) word_select
(
.sel(offset),
.a(unpacked_32[0]),
.b(unpacked_32[1]),
.c(unpacked_32[2]),
.d(unpacked_32[3]),
.e(unpacked_32[4]),
.f(unpacked_32[5]),
.g(unpacked_32[6]),
.h(unpacked_32[7]),
.o(selected_word)
);
*/
/*
misaligned_read adjust_alignment
(
.word_32(selected_word),
.alignment,
.word_out(mem_rdata)
); */

// modified cache line
/*
logic [31:0] modified_word;
misaligned_write construxt_new_word(
    .original_word_32(selected_word),
    .write_word(mem_wdata),
    .alignment,
    .mem_byte_enable,
    .word_out(modified_word)
); */
/*
int j;
always_comb begin
    for (j = 0; j < 8; j = j + 1) begin
        modified_line[32*j+:32] = (j == offset)? modified_word:selected_line[32*j+:32];
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
mux2 #(.width(32)) tag_for_write_back
(
    .sel(way_select),
    .a(tagout_way0),
    .b(tagout_way1),
    .f(tag_selected)
);
assign write_back_addr = {tag_selected,idx,5'b0};
endmodule
