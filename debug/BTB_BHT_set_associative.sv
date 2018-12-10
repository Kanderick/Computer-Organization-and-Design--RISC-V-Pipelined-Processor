import rv32i_types::*;

// branch target buffer and local branch history table combined
module BTB_BHT_set_associative  #(parameter num_entry_bits = 4, parameter num_way_bits=2 ) //6  2
(
	input 	clk,

	input 	rv32i_word IF_PC,
	input 	rv32i_word MEM_PC,    
	input 	rv32i_word target_in, //from MEM, 	 to the data array during a miss
	input 	replace, // from MEM, add 	 to a array during a miss
	input 	branch_result, //from MEM, addr to jump to calculated by ALU
	input 	update, //from MEM
	input 	MEM_is_jal,
	output	rv32i_word target_out, // to IF, addr to jump to 
   output logic hit, // to IF, if it is a jmp/br
   output logic prediction, // to IF
	output logic IF_is_jal
);
localparam num_entries = 1 << num_entry_bits;
localparam num_way = 1<< num_way_bits;
localparam tag_bits = 32-num_entry_bits;
logic [num_entry_bits-1:0] IF_PC_index;
logic [num_entry_bits-1:0] MEM_PC_index ;
logic [num_way-1:0]MEM_PC_read_write_way ;
logic IF_hit_way [num_way];
logic MEM_hit_way [num_way];
logic [num_way_bits-1:0] lru_out;
logic [num_way_bits-1:0] new_access;


array_signals IF_data_out[num_way];
array_signals MEM_data_out[num_way];
array_signals new_entry;


// BHT
logic  [num_way-1:0] BHT_update_way ;
logic [num_way-1:0] BHT_replace_way;
logic BHT_prediction_way [num_way];
logic BHT_prediction[num_way];

/**/
assign IF_PC_index=IF_PC[num_entry_bits-1:0];
assign MEM_PC_index=MEM_PC[num_entry_bits-1:0];


genvar j;
generate
	for (j=0; j<num_way; j++) begin : data_way
		// set-associative array 
		dual_port_array data_way(
			 .clk,
			 .write(MEM_PC_read_write_way[j]),
			 .read_only_index(IF_PC_index),
			 .read_write_index(MEM_PC_index),
			 .write_datain(new_entry),
			 .read_only_dataout(IF_data_out[j]),
			 .read_write_dataout(MEM_data_out[j]),
			 
			 .branch_result,
			 .update(BHT_update_way[j]),
			 .replace(BHT_replace_way[j]),
			 .BHT_prediction(BHT_prediction[j])
		);
	end
endgenerate
// LRU
pseudo_lru #(.bits(num_way_bits)) LRU
(
	.clk,
	.load_lru(hit),
	.new_access,
	.lru(lru_out)
);
always_comb
begin
	MEM_PC_read_write_way = replace<<lru_out;
	BHT_update_way = update << new_access;
	BHT_replace_way = replace << lru_out;
end
always_comb
begin
	hit = 0;
	prediction = 0;
   target_out = 0;
	new_access = 0;
	IF_is_jal=0;
	for (int i=0; i<num_way; i++) begin
		IF_hit_way[i] = (IF_data_out[i].tag[31-:tag_bits]==IF_PC[31-:tag_bits]) && IF_data_out[i].valid;
		MEM_hit_way[i] = (MEM_data_out[i].tag[31-:tag_bits]==MEM_PC[31-:tag_bits]) && MEM_data_out[i].valid;
		prediction = IF_hit_way[i] ? BHT_prediction[i] : prediction;
      target_out = IF_hit_way[i] ? IF_data_out[i].data : target_out;
		hit |= IF_hit_way[i];
		IF_is_jal = IF_hit_way[i] ? IF_data_out[i].is_jal : IF_is_jal;
		new_access = MEM_hit_way[i] ? i[num_way_bits-1:0] : new_access;
	end
end
always_comb
begin
	new_entry.tag = MEM_PC;
   new_entry.valid = 1;
   new_entry.data = target_in;
   new_entry.is_jal = MEM_is_jal;	
end

endmodule : BTB_BHT_set_associative
