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
localparam num_sets = 1 << num_entry_bits;
logic [num_entry_bits-1:0] IF_idx;
assign IF_idx = IF_PC[num_entry_bits:1];
logic [num_entry_bits-1:0] MEM_idx;
assign MEM_idx = MEM_PC[num_entry_bits:1];
rv32i_word target_out_arr[num_sets];
logic hit_arr[num_sets];
logic prediction_arr[num_sets];
logic IF_is_jal_arr[num_sets];

genvar j;
generate
	for (j = 0; j < num_sets; j = j + 1) begin: generate_sets
		BTB_BHT #( .num_entry_bits (num_way_bits)) set
		(
			.clk,
			.IF_PC,
			.MEM_PC,    
			.target_in, //from MEM, input to the data array during a miss
			.replace(replace & (j == MEM_idx)), // from MEM, add input to a array during a miss
			.branch_result, //from MEM, addr to jump to calculated by ALU
			.update(update & (j == MEM_idx)), //from MEM
			.MEM_is_jal,
			.target_out(target_out_arr[j]), // to IF, addr to jump to 
			.hit(hit_arr[j]), // to IF, if it is a jmp/br
			.prediction(prediction_arr[j]), // to IF
			.IF_is_jal(IF_is_jal_arr[j])
		);
	end
endgenerate
assign target_out = target_out_arr[IF_idx];
assign hit = hit_arr[IF_idx];
assign prediction = prediction_arr[IF_idx];
assign IF_is_jal = IF_is_jal_arr[IF_idx];

endmodule : BTB_BHT_set_associative
