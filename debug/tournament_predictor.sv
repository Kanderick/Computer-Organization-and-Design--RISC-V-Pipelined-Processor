import rv32i_types::*;

module tournament_predictor  // history num = 2 ^ history_bits
(
	 input clk,
    input global_prediction,
    input local_prediction,
    input hit,
	 input IF_is_jal,
    output logic prediction, // 1 = take
	 
	 input MEM_global_prediction,
	 input MEM_local_prediction,
	 input branch_result,
	 input update
);

logic GHT_correct;
logic LHT_correct;
logic select_local;
assign GHT_correct = (MEM_global_prediction == branch_result);
assign LHT_correct = (MEM_local_prediction == branch_result);

/*need more logic*/
always_comb begin
	prediction = 1'b0;
	if (IF_is_jal)
		prediction = 1;
	else if (hit) 
		prediction = select_local ? local_prediction : global_prediction;
end	

branch_history_table predictor_selector 
(
    .clk,
    .branch_result(LHT_correct),
    .update(update && (GHT_correct != LHT_correct)),
    .flush(0),
    .prediction(select_local) // 1 = take local_prediction
);
endmodule