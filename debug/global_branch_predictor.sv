import rv32i_types::*;

module global_branch_predictor  #(parameter pattern_bits = 4) // history num = 2 ^ history_bits
(
    input clk,
    input branch_result,
    input update,
    input [pattern_bits-1:0] MEM_pattern_used,
    output logic prediction, // 1 = take
	 output logic [pattern_bits-1:0] IF_pattern_used
);
localparam num_table = 1 << 4;
logic [3:0] pattern_history;
logic PHT_prediction[num_table];
initial begin
	pattern_history = 4'b0;
end

always_ff @ (posedge clk) begin
	if (update) begin
		pattern_history = pattern_history << 1;
		pattern_history[0] = branch_result;
	end
end

genvar j;
generate
    for (j = 0; j < num_table; j = j + 1) begin : generate_pattern_hist_table
        branch_history_table local_hist_table(
            .clk,
            .branch_result,
            .update(update && (MEM_pattern_used == j)),
            .flush(1'b0),
            .prediction(PHT_prediction[j])  
        );
   end     
endgenerate

always_comb begin
    prediction = 0;
	 IF_pattern_used = pattern_history;
    for (int i = 0; i < num_table;  i = i + 1) begin
		if (pattern_history == i)
			prediction = PHT_prediction[i];
    end
end

endmodule