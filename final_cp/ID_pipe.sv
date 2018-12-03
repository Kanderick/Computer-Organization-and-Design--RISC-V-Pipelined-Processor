module ID_pipe
(
	input [31:0] IF_pc,
	output logic [31:0] ID_pc,
	input clk,
	input reset,
	input load,
    input IF_BTB_hit,
    input IF_prediction,
    output logic ID_BTB_hit,
    output logic ID_prediction ,
	 
	 //ght
	input [3:0] IF_pattern_used,
	output logic [3:0] ID_pattern_used,
	
	input IF_local_prediction,
	output logic ID_local_prediction,
	input IF_global_prediction,
	output logic ID_global_prediction
);

initial
begin
	 ID_pc=0;
    ID_BTB_hit = 0;
    ID_prediction = 0;
	 ID_pattern_used = 0;
	 ID_local_prediction = 0;
	 ID_global_prediction = 0;
end
always_ff @ (posedge clk) begin

	if(reset) begin
		ID_pc<=0;
        ID_BTB_hit <= 0;
        ID_prediction <= 0;
		  ID_pattern_used <= 0;
		  ID_local_prediction <= 0;
	     ID_global_prediction <= 0;
	end
	else if(load) begin
		ID_pc<=IF_pc;
        ID_BTB_hit <= IF_BTB_hit;
        ID_prediction <= IF_prediction;
        ID_pattern_used <= IF_pattern_used;
		  ID_local_prediction <= IF_local_prediction;
	     ID_global_prediction <= IF_global_prediction;
	end

end
endmodule : ID_pipe