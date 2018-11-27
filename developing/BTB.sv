import rv32i_types::*;

// branch target buffer and branch history table combined
module BTB #(parameter num_entry_bits = 6)
(
	input clk,

	input rv32i_word IF_PC,
	input rv32i_word MEM_PC,    
	input rv32i_word target_in, //from MEM, input to the data array during a miss
	input replace, // from MEM, add input to a array during a miss
	input branch_result, //from MEM, addr to jump to calculated by ALU
	input update, //from MEM
  
	output rv32i_word target_out, // to IF, addr to jump to 
    output logic hit, // to IF, if it is a jmp/br
    output logic prediction // to IF
);
localparam num_entries = 1 << num_entry_bits;

typedef struct packed {
  rv32i_word tag;
  logic valid;
  rv32i_word data;
  logic prediction;
} array_signals;

array_signals btb_bht_array[num_entries];
logic IF_PC_hit[num_entries];
logic MEM_PC_hit[num_entries];

logic [num_entry_bits-1:0] replace_ptr;
always_ff @ (posedge clk) begin
    if (replace)
        replace_ptr <= replace_ptr + 1'b1;
    for (int i = 0; i < num_entries;  i = i + 1) begin
        if (i == replace_ptr) begin
            btb_bht_array[i].tag <= MEM_PC;
            btb_bht_array[i].valid <= 1;
            btb_bht_array[i].data <= target_in;
        end
    end        
end

always_comb begin
    prediction = 0;
    target_out = 0;
    hit = 0;
    for (int i = 0; i < num_entries;  i = i + 1) begin
        IF_PC_hit[i] = (btb_bht_array[i].tag == IF_PC) && btb_bht_array[i].valid;
        MEM_PC_hit[i] = (btb_bht_array[i].tag == MEM_PC) && btb_bht_array[i].valid;        
        prediction |= btb_bht_array[i].prediction;
        target_out |= btb_bht_array[i].data;
        hit |= IF_PC_hit[i];
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
            .prediction(btb_bht_array[j].prediction)  
        );
   end     
endgenerate

endmodule