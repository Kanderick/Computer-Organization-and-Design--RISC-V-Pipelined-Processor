import rv32i_types::*;

// branch target buffer and local branch history table combined
module BTB_BHT #(parameter num_entry_bits = 6)
(
	input clk,

	input rv32i_word IF_PC,
	input rv32i_word MEM_PC,    
	input rv32i_word target_in, //from MEM, input to the data array during a miss
	input replace, // from MEM, add input to a array during a miss
	input branch_result, //from MEM, addr to jump to calculated by ALU
	input update, //from MEM
   input MEM_is_jal,
	output rv32i_word target_out, // to IF, addr to jump to 
    output logic hit, // to IF, if it is a jmp/br
    output logic prediction, // to IF
	 output logic IF_is_jal
);
localparam num_entries = 1 << num_entry_bits;


array_signals btb_bht_array[num_entries];
logic [num_entry_bits-1:0] replace_ptr;
//logic [num_entry_bits-1:0] new_access;


initial begin
    for (int i = 0; i < num_entries;  i = i + 1) begin
       btb_bht_array[i] <= 0;
       replace_ptr <= 0;
    end    
end
/*
pseudo_lru #(.bits(num_entry_bits)) pseudo_lru
(
	.clk,
	.load_lru(update),
	.new_access,
	.lru(replace_ptr)
);
*/
//logic IF_PC_hit[num_entries];
logic MEM_PC_hit[num_entries];
logic BHT_prediction[num_entries];

always_ff @ (posedge clk) begin
    if (replace) begin
        replace_ptr <= replace_ptr + 1'b1;
        for (int i = 0; i < num_entries;  i = i + 1) begin
            if (i == replace_ptr) begin
                btb_bht_array[i].tag <= MEM_PC;
                btb_bht_array[i].valid <= 1;
                btb_bht_array[i].data <= target_in;
                btb_bht_array[i].is_jal <= MEM_is_jal;					 
            end
        end    
    end /*
	 else if (update) //necessary for jalr
		for (int i = 0; i < num_entries;  i = i + 1) begin
            if (btb_bht_array[i].tag == MEM_PC) begin
                btb_bht_array[i].data <= target_in;
            end
      end  */
end

always_comb begin
    prediction = 0;
    target_out = 0;
    hit = 0;
	 IF_is_jal = 0;
	 //new_access = 0;
    for (int i = 0; i < num_entries;  i = i + 1) begin
			/*
        IF_PC_hit[i] = (btb_bht_array[i].tag == IF_PC) && btb_bht_array[i].valid; 
        prediction = IF_PC_hit[i] ? BHT_prediction[i] : prediction;
        target_out = IF_PC_hit[i] ? btb_bht_array[i].data : target_out;
        hit |= IF_PC_hit[i];
		  IF_is_jal = IF_PC_hit[i] ? btb_bht_array[i].is_jal : IF_is_jal;
		  */
		  if (btb_bht_array[i].tag == IF_PC && btb_bht_array[i].valid ) begin
				prediction = BHT_prediction[i] ;
				hit = 1;
				IF_is_jal = btb_bht_array[i].is_jal;
				target_out = btb_bht_array[i].data;
				//new_access = i[num_entry_bits-1:0];
		  end 
		  MEM_PC_hit[i] = (btb_bht_array[i].tag == MEM_PC) && btb_bht_array[i].valid;       
    end
	 
end

genvar j;
generate
    for (j = 0; j < num_entries; j = j + 1) begin : generate_local_hist_table
        branch_history_table local_hist_table(
            .clk,
            .branch_result,
            .update(update && MEM_PC_hit[j]),
            .flush(replace && (replace_ptr == j)),
            .prediction(BHT_prediction[j])  
        );
   end     
endgenerate

endmodule